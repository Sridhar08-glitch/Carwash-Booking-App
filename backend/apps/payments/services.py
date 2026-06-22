"""
Payments service layer.

top_up_wallet       — credit funds to a customer wallet (admin/top-up flow).
deduct_wallet       — debit wallet; raises ConflictError if insufficient funds.
validate_promo      — check a promo code is usable against a given amount/type.
apply_promo_to_amount — compute discount given a validated PromoCode.
create_booking_payment_intent — convenience wrapper for booking → PaymentIntent.
refund              — wrapper over stripe_service.refund_payment.
"""
from __future__ import annotations

import logging
from decimal import Decimal

from django.db import transaction

from apps.common.errors import ConflictError, NotFoundError

logger = logging.getLogger(__name__)


# ── Wallet ────────────────────────────────────────────────────────────────────

@transaction.atomic
def top_up_wallet(*, user, amount: Decimal, reference: str = "") -> "Wallet":
    """
    Credit `amount` to the user's wallet.
    Creates the Wallet if it doesn't exist yet.
    Records a WalletTransaction for the full audit trail.
    """
    from .models import Wallet, WalletTransaction

    if amount <= 0:
        raise ConflictError("Top-up amount must be positive.", code="WALLET_INVALID_AMOUNT")

    wallet, _ = Wallet.objects.select_for_update().get_or_create(
        user=user,
        defaults={"tenant": user.tenant, "balance": Decimal("0"), "currency": "SAR"},
    )
    wallet.balance += amount
    wallet.save(update_fields=["balance", "updated_at"])

    WalletTransaction.objects.create(
        tenant=user.tenant,
        wallet=wallet,
        delta=amount,
        balance_after=wallet.balance,
        reason=WalletTransaction.Reason.TOP_UP,
        reference=reference,
    )
    logger.info("Wallet top-up: user=%s amount=%s new_balance=%s", user.pk, amount, wallet.balance)
    return wallet


@transaction.atomic
def deduct_wallet(
    *, user, amount: Decimal, reason: str, reference: str = ""
) -> "Wallet":
    """
    Debit `amount` from the user's wallet.
    Raises ConflictError if balance is insufficient.
    Uses select_for_update() to prevent concurrent double-deductions.
    """
    from .models import Wallet, WalletTransaction

    wallet = (
        Wallet.objects.select_for_update()
        .filter(user=user)
        .first()
    )
    if wallet is None or wallet.balance < amount:
        raise ConflictError("Insufficient wallet balance.", code="WALLET_INSUFFICIENT")

    wallet.balance -= amount
    wallet.save(update_fields=["balance", "updated_at"])

    WalletTransaction.objects.create(
        tenant=user.tenant,
        wallet=wallet,
        delta=-amount,
        balance_after=wallet.balance,
        reason=reason,
        reference=reference,
    )
    logger.info("Wallet deduction: user=%s amount=%s new_balance=%s", user.pk, amount, wallet.balance)
    return wallet


@transaction.atomic
def credit_wallet_for_refund(*, user, amount: Decimal, reference: str = "") -> "Wallet":
    """Credit wallet after a refund (same as top_up but reason=REFUND)."""
    from .models import Wallet, WalletTransaction

    wallet, _ = Wallet.objects.select_for_update().get_or_create(
        user=user,
        defaults={"tenant": user.tenant, "balance": Decimal("0"), "currency": "SAR"},
    )
    wallet.balance += amount
    wallet.save(update_fields=["balance", "updated_at"])

    WalletTransaction.objects.create(
        tenant=user.tenant,
        wallet=wallet,
        delta=amount,
        balance_after=wallet.balance,
        reason=WalletTransaction.Reason.REFUND,
        reference=reference,
    )
    return wallet


@transaction.atomic
def credit_loyalty_points_to_wallet(*, user, amount: Decimal, reference: str = "") -> "Wallet":
    """Award loyalty cashback to wallet."""
    from .models import Wallet, WalletTransaction

    wallet, _ = Wallet.objects.select_for_update().get_or_create(
        user=user,
        defaults={"tenant": user.tenant, "balance": Decimal("0"), "currency": "SAR"},
    )
    wallet.balance += amount
    wallet.save(update_fields=["balance", "updated_at"])

    WalletTransaction.objects.create(
        tenant=user.tenant,
        wallet=wallet,
        delta=amount,
        balance_after=wallet.balance,
        reason=WalletTransaction.Reason.LOYALTY_CREDIT,
        reference=reference,
    )
    return wallet


# ── Promo validation ──────────────────────────────────────────────────────────

def validate_promo(*, tenant_id, code: str, amount: Decimal, applies_to: str) -> "PromoCode":
    """
    Validate a promo code against an amount and usage type.
    Returns the PromoCode if valid; raises ConflictError otherwise.
    """
    from django.utils import timezone
    from .models import PromoCode

    promo = PromoCode.objects.filter(
        tenant_id=tenant_id, code=code.upper(), is_active=True
    ).first()
    if promo is None:
        raise ConflictError("Promo code not found or inactive.", code="PROMO_INVALID")

    now = timezone.now()
    if now < promo.valid_from or now > promo.valid_until:
        raise ConflictError("Promo code is expired or not yet active.", code="PROMO_EXPIRED")

    if promo.usage_limit and promo.used_count >= promo.usage_limit:
        raise ConflictError("Promo code has reached its usage limit.", code="PROMO_EXHAUSTED")

    if promo.applies_to not in (applies_to, "both"):
        raise ConflictError(
            f"This promo code cannot be used for {applies_to}.", code="PROMO_WRONG_TYPE"
        )

    if amount < promo.min_spend:
        raise ConflictError(
            f"Minimum spend of {promo.min_spend} required for this promo.", code="PROMO_MIN_SPEND"
        )

    return promo


def apply_promo_to_amount(*, promo, amount: Decimal) -> Decimal:
    """Return the discount amount (not the final price)."""
    if promo.discount_type == "percent":
        discount = (amount * promo.value / Decimal("100")).quantize(Decimal("0.01"))
    else:
        discount = min(promo.value, amount)
    return discount


# ── Booking payment intent ────────────────────────────────────────────────────

@transaction.atomic
def create_booking_payment(
    *,
    user,
    booking,
    method: str = "card",
    idempotency_key: str = "",
) -> "Payment":
    """
    Create a Payment record for a booking.
    If method=wallet: deduct immediately and mark Payment succeeded.
    If method=card:   create Payment(requires_action), caller must call
                      stripe_service.create_payment_intent().
    If method=cash:   create Payment(pending) — settled by staff on completion.
    """
    from .models import Payment, WalletTransaction

    # Idempotency: don't double-charge
    if idempotency_key:
        existing = Payment.objects.filter(
            idempotency_key=idempotency_key, user=user
        ).first()
        if existing:
            return existing

    payment = Payment.objects.create(
        tenant=user.tenant,
        user=user,
        amount=booking.price_charged,
        currency="SAR",
        method=method,
        status=Payment.Status.PENDING,
        idempotency_key=idempotency_key,
    )

    if method == Payment.Method.WALLET:
        deduct_wallet(
            user=user,
            amount=booking.price_charged,
            reason=WalletTransaction.Reason.BOOKING_PAYMENT,
            reference=f"booking#{booking.pk}",
        )
        payment.status = Payment.Status.SUCCEEDED
        payment.save(update_fields=["status", "updated_at"])

        # Immediately confirm the booking
        from apps.scheduling.models import Booking
        booking.status = Booking.Status.CONFIRMED
        booking.payment = payment
        booking.save(update_fields=["status", "payment", "updated_at"])

    elif method == Payment.Method.CASH:
        # Cash is settled later by staff
        booking.payment = payment
        booking.save(update_fields=["payment", "updated_at"])

    else:
        # Card — attach payment to booking; Stripe intent created by view
        booking.payment = payment
        booking.save(update_fields=["payment", "updated_at"])
        payment.status = Payment.Status.REQUIRES_ACTION
        payment.save(update_fields=["status", "updated_at"])

    return payment


# ── Refund ────────────────────────────────────────────────────────────────────

def refund_payment(*, payment, amount: Decimal | None = None) -> dict:
    """
    Issue a refund.
    For card payments: calls Stripe.
    For wallet payments: credits wallet.
    For cash: marks refunded (manual handling).
    """
    from .models import Payment

    if payment.method == Payment.Method.CARD:
        from . import stripe_service
        return stripe_service.refund_payment(payment=payment, amount=amount)

    elif payment.method == Payment.Method.WALLET:
        refund_amount = amount if amount else payment.amount
        credit_wallet_for_refund(
            user=payment.user,
            amount=refund_amount,
            reference=f"refund-payment#{payment.pk}",
        )
        payment.status = (
            Payment.Status.REFUNDED if not amount or amount >= payment.amount
            else Payment.Status.PARTIALLY_REFUNDED
        )
        payment.refunded_amount = (payment.refunded_amount or Decimal("0")) + (amount or payment.amount)
        payment.save(update_fields=["status", "refunded_amount", "updated_at"])
        return {"status": "wallet_credited"}

    else:
        # Cash — just mark it
        payment.status = Payment.Status.REFUNDED
        payment.save(update_fields=["status", "updated_at"])
        return {"status": "marked_refunded"}
