"""
Accounts service layer — all write/command operations.

Rules
-----
* No business logic in views, serializers, or model save().
* Every function that writes to the DB is wrapped in a transaction.
* OTP codes are hashed before storage; raw code is never persisted.
* JWT tokens are issued here and returned to the view.
"""
from __future__ import annotations

import logging
import random
import string
from datetime import timedelta

from django.conf import settings
from django.db import transaction
from django.utils import timezone
from rest_framework_simplejwt.tokens import RefreshToken

from apps.common.celery_tenant import set_tenant_context
from apps.common.errors import ConflictError, NotFoundError
from apps.common.models import Tenant

from .models import Address, CustomerProfile, CustomUser, OTPCode, StaffProfile, Vehicle

logger = logging.getLogger(__name__)


# ── Helpers ───────────────────────────────────────────────────────────────────

def _generate_otp_code(length: int = 6) -> str:
    return "".join(random.choices(string.digits, k=length))


def _issue_tokens(user: CustomUser) -> dict:
    refresh = RefreshToken.for_user(user)
    # Embed tenant_id so TenantMiddleware can set RLS context from the JWT
    # Bearer token before DRF's JWTAuthentication queries accounts_customuser.
    if user.tenant_id is not None:
        refresh["tenant_id"] = str(user.tenant_id)
    return {
        "access": str(refresh.access_token),
        "refresh": str(refresh),
    }


def _get_or_create_default_tenant() -> Tenant:
    """
    Return the single tenant new users join (Phase 1 — single-tenant).

    Reuse the first active tenant if one exists (e.g. the one created by
    `manage.py seed`, slug='holora'); otherwise create 'default'. Previously
    this always used slug='default', so users logging in after seeding landed
    in a different tenant than the seeded catalog and saw an empty app.
    """
    tenant = Tenant.objects.filter(is_active=True).order_by("id").first()
    if tenant:
        return tenant
    tenant, _ = Tenant.objects.get_or_create(
        slug="default",
        defaults={"name": "Sridhar Car Wash", "is_active": True},
    )
    return tenant


# ── OTP ───────────────────────────────────────────────────────────────────────

def request_otp(*, phone: str) -> None:
    """
    Generate and send an OTP to the given phone number.
    Invalidates any previous un-used OTP for this phone.
    """
    # Invalidate old OTPs for this phone (mark as used)
    OTPCode.objects.filter(phone=phone, used=False).update(used=True)

    raw_code = _generate_otp_code()
    expires_at = timezone.now() + timedelta(minutes=settings.OTP_EXPIRY_MINUTES)

    OTPCode.objects.create(
        phone=phone,
        code_hash=OTPCode.hash_code(raw_code),
        expires_at=expires_at,
    )

    # Send SMS — Phase 1 stub (log to console; wire real provider in .env)
    logger.info("OTP for %s: %s", phone, raw_code)
    _send_otp_sms(phone=phone, code=raw_code)


def _send_otp_sms(*, phone: str, code: str) -> None:
    """
    Dispatch OTP via SMS provider.

    Set SMS_ENABLED=True and configure SMS_PROVIDER_* env vars to activate.
    Supported providers: twilio (default), aws_sns, infobip.
    When SMS_ENABLED=False the code is printed to the log only (dev/staging).
    """
    if not settings.SMS_ENABLED:
        logger.info(
            "SMS_ENABLED=False — OTP for %s logged but NOT sent (dev mode). Code: %s",
            phone, code,
        )
        return

    provider = getattr(settings, "SMS_PROVIDER", "twilio")

    if provider == "twilio":
        try:
            from twilio.rest import Client as TwilioClient  # type: ignore[import]
            client = TwilioClient(settings.SMS_ACCOUNT_SID, settings.SMS_AUTH_TOKEN)
            client.messages.create(
                body=f"Your Sridhar Car Wash verification code is: {code}. Valid for {settings.OTP_EXPIRY_MINUTES} minutes.",
                from_=settings.SMS_FROM_NUMBER,
                to=phone,
            )
            logger.info("OTP SMS sent via Twilio to %s", phone)
        except ImportError:
            logger.error("twilio package not installed. Add twilio to requirements.txt.")
        except Exception as exc:
            logger.exception("Twilio OTP delivery failed for %s: %s", phone, exc)

    elif provider == "aws_sns":
        try:
            import boto3  # already in requirements
            client = boto3.client(
                "sns",
                region_name=getattr(settings, "SMS_AWS_REGION", "us-east-1"),
                aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
            )
            client.publish(
                PhoneNumber=phone,
                Message=f"Sridhar Car Wash verification code: {code}. Expires in {settings.OTP_EXPIRY_MINUTES} min.",
            )
            logger.info("OTP SMS sent via AWS SNS to %s", phone)
        except Exception as exc:
            logger.exception("AWS SNS OTP delivery failed for %s: %s", phone, exc)

    else:
        logger.error("Unknown SMS_PROVIDER '%s'. Supported: twilio, aws_sns.", provider)


@transaction.atomic
def verify_otp_and_login(*, phone: str, code: str) -> dict:
    """
    Verify the OTP. If valid:
      - Mark it consumed
      - Create or update the user
      - Issue JWT tokens

    Returns {"tokens": {...}, "user": {...}, "is_new": bool}
    Raises ConflictError if code is invalid/expired.
    """
    otp = (
        OTPCode.objects.select_for_update()
        .filter(phone=phone, used=False)
        .order_by("-created_at")
        .first()
    )

    if otp is None:
        raise ConflictError(
            "No active OTP found for this phone. Please request a new code.",
            code="OTP_NOT_FOUND",
        )

    otp.attempts += 1
    otp.save(update_fields=["attempts"])

    if not otp.is_valid(code):
        remaining = max(0, settings.OTP_MAX_ATTEMPTS - otp.attempts)
        raise ConflictError(
            f"Invalid or expired OTP. {remaining} attempt(s) remaining.",
            code="OTP_INVALID",
        )

    otp.consume()

    tenant = _get_or_create_default_tenant()

    # RLS on accounts_customuser requires app.current_tenant to match the
    # row's tenant_id (migration 0003 removed the NULL-bypass). This request
    # is unauthenticated (no JWT yet), so TenantMiddleware never set the
    # session variable — set it here before the INSERT/UPDATE below.
    set_tenant_context(str(tenant.id))

    user, is_new = CustomUser.objects.get_or_create(
        phone=phone,
        defaults={
            "username": phone,
            "tenant": tenant,
            "is_phone_verified": True,
        },
    )

    if not is_new and not user.is_phone_verified:
        user.is_phone_verified = True
        user.save(update_fields=["is_phone_verified"])

    if user.tenant_id is None:
        user.tenant = tenant
        user.save(update_fields=["tenant"])

    # Create profile on first login
    if is_new and user.role == CustomUser.Role.CUSTOMER:
        CustomerProfile.objects.get_or_create(user=user)

    tokens = _issue_tokens(user)

    return {
        "tokens": tokens,
        "user": {
            "id": user.pk,
            "phone": user.phone,
            "role": user.role,
            "is_phone_verified": user.is_phone_verified,
        },
        "is_new": is_new,
    }


@transaction.atomic
def logout_user(*, refresh_token: str) -> None:
    """Blacklist the refresh token (invalidates the session)."""
    try:
        token = RefreshToken(refresh_token)
        token.blacklist()
    except Exception:
        pass  # Token already invalid — silent success


# ── Profile updates ───────────────────────────────────────────────────────────

@transaction.atomic
def update_profile(*, user: CustomUser, data: dict) -> CustomUser:
    """Update allowed profile fields on CustomUser."""
    allowed = {"email", "locale", "date_of_birth", "fcm_token"}
    for field, value in data.items():
        if field in allowed:
            setattr(user, field, value)
    user.save(update_fields=list(allowed & data.keys()) + ["updated_at"] if hasattr(user, "updated_at") else list(allowed & data.keys()))
    return user


# ── Vehicles ──────────────────────────────────────────────────────────────────

@transaction.atomic
def create_vehicle(*, user: CustomUser, data: dict) -> Vehicle:
    """Create a new vehicle for the user."""
    plate = data.get("plate", "").upper().strip()
    if Vehicle.objects.filter(user=user, plate=plate).exists():
        raise ConflictError(f"A vehicle with plate '{plate}' is already registered.")

    if data.get("is_default"):
        Vehicle.objects.filter(user=user, is_default=True).update(is_default=False)

    return Vehicle.objects.create(user=user, **{**data, "plate": plate})


@transaction.atomic
def update_vehicle(*, user: CustomUser, vehicle_id: int, data: dict) -> Vehicle:
    vehicle = Vehicle.objects.filter(user=user, pk=vehicle_id).first()
    if vehicle is None:
        raise NotFoundError("Vehicle not found.")
    if data.get("is_default"):
        Vehicle.objects.filter(user=user, is_default=True).exclude(pk=vehicle_id).update(is_default=False)
    for k, v in data.items():
        setattr(vehicle, k, v)
    vehicle.save()
    return vehicle


@transaction.atomic
def delete_vehicle(*, user: CustomUser, vehicle_id: int) -> None:
    vehicle = Vehicle.objects.filter(user=user, pk=vehicle_id).first()
    if vehicle is None:
        raise NotFoundError("Vehicle not found.")
    vehicle.soft_delete()


# ── Addresses ─────────────────────────────────────────────────────────────────

@transaction.atomic
def create_address(*, user: CustomUser, data: dict) -> Address:
    if data.get("is_default"):
        Address.objects.filter(user=user, is_default=True).update(is_default=False)
    return Address.objects.create(user=user, **data)


@transaction.atomic
def update_address(*, user: CustomUser, address_id: int, data: dict) -> Address:
    address = Address.objects.filter(user=user, pk=address_id).first()
    if address is None:
        raise NotFoundError("Address not found.")
    if data.get("is_default"):
        Address.objects.filter(user=user, is_default=True).exclude(pk=address_id).update(is_default=False)
    for k, v in data.items():
        setattr(address, k, v)
    address.save()
    return address


@transaction.atomic
def delete_address(*, user: CustomUser, address_id: int) -> None:
    """Soft-delete an address belonging to the user."""
    address = Address.objects.filter(user=user, pk=address_id).first()
    if address is None:
        raise NotFoundError("Address not found.")
    address.soft_delete()


# ── Staff profile ─────────────────────────────────────────────────────────────

@transaction.atomic
def create_staff_profile(*, user: CustomUser, data: dict) -> StaffProfile:
    """Create a staff profile for an employee/admin user."""
    if StaffProfile.objects.filter(user=user).exists():
        raise ConflictError("Staff profile already exists for this user.")
    return StaffProfile.objects.create(user=user, **data)


@transaction.atomic
def update_staff_profile(*, user: CustomUser, data: dict) -> StaffProfile:
    """Update mutable fields on an existing staff profile."""
    profile = StaffProfile.objects.filter(user=user).first()
    if profile is None:
        raise NotFoundError("Staff profile not found.")
    allowed = {"branch", "employee_id", "bio"}
    for field, value in data.items():
        if field in allowed:
            setattr(profile, field, value)
    profile.save()
    return profile


# ── Account deletion ──────────────────────────────────────────────────────────

@transaction.atomic
def request_account_deletion(*, user: CustomUser) -> None:
    """
    Mark the user's account as pending deletion.

    A scheduled task (or manual admin action) should hard-delete accounts that
    remain in this state for >30 days to allow chargeback resolution.
    """
    user.is_active = False
    user.save(update_fields=["is_active"])
    logger.info("Account deletion requested for user %s", user.pk)
