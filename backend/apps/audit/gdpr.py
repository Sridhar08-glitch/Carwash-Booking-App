"""
GDPR data export and right-to-erasure.

export_user_data  — collect all personal data for a user as a JSON dict.
erase_user_data   — anonymise PII; retain legally-required financial records.
"""
from __future__ import annotations

import logging
import uuid
from datetime import date

from django.db import transaction
from django.utils import timezone

logger = logging.getLogger(__name__)


def export_user_data(*, user) -> dict:
    """
    GDPR Article 20 — Data Portability.
    Returns all stored personal data for the user as a serialisable dict.
    """
    from apps.accounts.models import Address, Vehicle
    from apps.scheduling.models import Booking
    from apps.shop.models import Order
    from apps.notifications.models import Notification, NotificationPreference
    from apps.payments.models import Payment, Wallet, WalletTransaction

    bookings = list(
        Booking.all_objects.filter(user=user).values(
            "id", "status", "scheduled_date", "scheduled_start",
            "price_charged", "currency", "created_at",
        )
    )
    orders = list(
        Order.all_objects.filter(user=user).values(
            "id", "status", "total", "currency", "created_at",
        )
    )
    payments = list(
        Payment.objects.filter(user=user).values(
            "id", "amount", "currency", "method", "status", "created_at",
        )
    )
    addresses = list(
        Address.objects.filter(user=user).values(
            "id", "label", "line1", "line2", "city", "lat", "lng",
        )
    )
    vehicles = list(
        Vehicle.objects.filter(user=user).values(
            "id", "make", "model", "plate", "type",
        )
    )

    try:
        wallet = Wallet.objects.filter(user=user).first()
        wallet_data = {
            "balance": str(wallet.balance) if wallet else "0",
            "transactions": list(
                WalletTransaction.objects.filter(wallet__user=user).values(
                    "delta", "reason", "created_at",
                )
            ) if wallet else [],
        }
    except Exception:
        wallet_data = {}

    return {
        "export_date": timezone.now().isoformat(),
        "user": {
            "id": user.pk,
            "phone": user.phone,
            "email": user.email,
            "date_of_birth": str(user.date_of_birth) if user.date_of_birth else None,
            "locale": user.locale,
            "role": user.role,
            "created_at": user.date_joined.isoformat() if user.date_joined else None,
        },
        "addresses": addresses,
        "vehicles": vehicles,
        "bookings": bookings,
        "orders": orders,
        "payments": payments,
        "wallet": wallet_data,
    }


@transaction.atomic
def erase_user_data(*, user, erased_by=None) -> dict:
    """
    GDPR Article 17 — Right to Erasure.

    Anonymises all PII.
    Retains Payment/Order/Booking records (required for financial compliance)
    but replaces personal identifiers with anonymous tokens.

    Returns a summary of what was anonymised.
    """
    from apps.accounts.models import Address, CustomerProfile, Vehicle
    from apps.scheduling.models import Booking, RecurringBookingRule
    from apps.notifications.models import Notification, NotificationPreference
    from apps.loyalty.models import CustomerLoyalty, Referral

    anon_id = str(uuid.uuid4())[:8]
    anon_phone = f"+00000{anon_id}"
    anon_email = f"deleted-{anon_id}@erased.invalid"

    # Anonymise user
    user.phone = anon_phone
    user.email = anon_email
    user.first_name = ""
    user.last_name = ""
    user.fcm_token = ""
    user.date_of_birth = None
    user.is_active = False
    user.is_deleted = True
    user.deleted_at = timezone.now()
    user.save()

    # Delete PII-heavy records
    Address.objects.filter(user=user).delete()
    Vehicle.objects.filter(user=user).delete()
    Notification.objects.filter(user=user).delete()
    NotificationPreference.objects.filter(user=user).delete()
    RecurringBookingRule.objects.filter(user=user).update(is_active=False)

    # Anonymise location data in bookings (keep financial data)
    Booking.all_objects.filter(user=user).update(
        mobile_lat=None,
        mobile_lng=None,
        cancellation_reason="[ERASED]",
    )

    # Anonymise referrals
    Referral.objects.filter(referrer=user).update(referee_phone="[ERASED]")

    # Write audit log
    from apps.audit.models import AuditLog
    AuditLog.objects.create(
        actor=erased_by,
        action="gdpr.erasure",
        target_type="user",
        target_id=user.pk,
        after={"erased_at": timezone.now().isoformat(), "anon_phone": anon_phone},
    )

    logger.info("GDPR erasure completed for user pk=%s by actor=%s", user.pk, erased_by)
    return {"status": "erased", "user_pk": user.pk, "anon_phone": anon_phone}
