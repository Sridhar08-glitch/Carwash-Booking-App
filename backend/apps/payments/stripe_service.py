"""
Stripe integration — service layer for payment intents and webhook handling.

Rules
-----
* Server always computes amount — never trust client.
* Webhook is the source of truth for payment success.
* All webhook handlers are idempotent (dedupe by Stripe event id).
* Signature is verified on every webhook call.
* On payment_intent.succeeded:
    1. Mark Payment succeeded.
    2. Mark Booking confirmed OR Order paid (+ stock decrement).
    3. Add loyalty points.
    4. Fire notification.
    All in one atomic transaction.
"""
from __future__ import annotations

import logging
from decimal import Decimal

import stripe
from django.conf import settings
from django.db import transaction

from apps.common.errors import ConflictError

logger = logging.getLogger(__name__)


def _get_stripe():
    stripe.api_key = settings.STRIPE_SECRET_KEY
    return stripe


# ── PaymentIntent creation ─────────────────────────────────────────────────────

def create_payment_intent(*, payment) -> str:
    """
    Create a Stripe PaymentIntent for the given Payment record.
    Returns the client_secret to be passed to the mobile SDK.
    Stores stripe_payment_intent_id + client_secret on the Payment.
    """
    if payment.stripe_payment_intent_id:
        # Already created — return existing client_secret
        return payment.stripe_client_secret

    s = _get_stripe()
    amount_cents = int(payment.amount * 100)  # Stripe uses cents

    intent = s.PaymentIntent.create(
        amount=amount_cents,
        currency=payment.currency.lower(),
        metadata={
            "payment_id": str(payment.pk),
            "user_id": str(payment.user_id),
            "tenant_id": str(payment.tenant_id),
        },
        idempotency_key=f"pi-{payment.pk}-{payment.idempotency_key or payment.pk}",
    )

    payment.stripe_payment_intent_id = intent["id"]
    payment.stripe_client_secret = intent["client_secret"]
    payment.status = "requires_action"
    payment.save(update_fields=["stripe_payment_intent_id", "stripe_client_secret", "status", "updated_at"])

    logger.info("Created PaymentIntent %s for payment %s", intent["id"], payment.pk)
    return intent["client_secret"]


# ── Subscription management (Phase 3 memberships) ─────────────────────────────

def create_subscription(*, user, stripe_price_id: str) -> dict:
    """Create a Stripe Subscription for a membership plan."""
    s = _get_stripe()

    # Ensure customer exists
    stripe_customer_id = _get_or_create_customer(user=user)

    subscription = s.Subscription.create(
        customer=stripe_customer_id,
        items=[{"price": stripe_price_id}],
        metadata={"user_id": str(user.pk), "tenant_id": str(user.tenant_id)},
        expand=["latest_invoice.payment_intent"],
    )
    return subscription


def cancel_subscription(*, stripe_subscription_id: str) -> dict:
    s = _get_stripe()
    return s.Subscription.delete(stripe_subscription_id)


def _get_or_create_customer(*, user) -> str:
    """Return or create a Stripe Customer ID for this user."""
    from apps.loyalty.models import UserSubscription  # lazy import
    # Check if we already have a customer id stored anywhere
    # For now, create a new one per call (idempotent via email)
    s = _get_stripe()
    try:
        customers = s.Customer.list(email=user.email or f"{user.phone}@noemail.sridharcarwash", limit=1)
        if customers["data"]:
            return customers["data"][0]["id"]
    except Exception:
        pass

    customer = s.Customer.create(
        email=user.email or f"{user.phone}@noemail.sridharcarwash",
        phone=user.phone,
        metadata={"user_id": str(user.pk), "tenant_id": str(user.tenant_id)},
    )
    return customer["id"]


# ── Webhook handler ────────────────────────────────────────────────────────────

def handle_webhook(*, payload: bytes, sig_header: str) -> dict:
    """
    Parse and verify a Stripe webhook event, then dispatch to handler.
    Returns {"status": "ok", "event_type": "..."} or raises ConflictError.

    SECURITY: construct_event() verifies the HMAC-SHA256 signature using
    STRIPE_WEBHOOK_SECRET.  If the secret is not configured (empty string),
    we reject ALL webhook calls so a misconfigured deployment cannot accept
    forged events that mark payments as succeeded.
    """
    if not settings.STRIPE_WEBHOOK_SECRET:
        logger.error(
            "Stripe webhook received but STRIPE_WEBHOOK_SECRET is not configured. "
            "Rejecting to prevent unauthenticated payment confirmation."
        )
        raise ConflictError(
            "Webhook endpoint is not configured.",
            code="WEBHOOK_NOT_CONFIGURED",
        )

    s = _get_stripe()
    try:
        event = s.Webhook.construct_event(
            payload, sig_header, settings.STRIPE_WEBHOOK_SECRET
        )
    except stripe.error.SignatureVerificationError as exc:
        raise ConflictError("Invalid webhook signature.", code="WEBHOOK_SIGNATURE_INVALID") from exc

    event_id = event["id"]
    event_type = event["type"]

    # Deduplicate: if we've processed this event before, skip
    from apps.audit.models import IdempotencyRecord
    _, created = IdempotencyRecord.objects.get_or_create(
        key=event_id,
        endpoint="stripe_webhook",
        defaults={"response_payload": {"event_type": event_type}},
    )
    if not created:
        logger.info("Stripe webhook already processed: %s", event_id)
        return {"status": "duplicate", "event_type": event_type}

    # Dispatch
    handlers = {
        "payment_intent.succeeded": _on_payment_intent_succeeded,
        "payment_intent.payment_failed": _on_payment_intent_failed,
        "customer.subscription.updated": _on_subscription_updated,
        "customer.subscription.deleted": _on_subscription_deleted,
        "invoice.payment_succeeded": _on_invoice_payment_succeeded,
    }
    handler = handlers.get(event_type)
    if handler:
        try:
            handler(event["data"]["object"])
        except Exception as exc:
            logger.exception("Webhook handler error for %s: %s", event_type, exc)
            raise

    return {"status": "ok", "event_type": event_type}


@transaction.atomic
def _on_payment_intent_succeeded(intent: dict) -> None:
    """
    Source of truth for payment success.
    Atomic: Payment → Booking/Order → stock → loyalty → notification.
    """
    from apps.payments.models import Payment
    from apps.scheduling.models import Booking

    payment_id = intent.get("metadata", {}).get("payment_id")
    if not payment_id:
        logger.warning("payment_intent.succeeded: no payment_id in metadata")
        return

    payment = Payment.objects.select_for_update().filter(pk=payment_id).first()
    if payment is None:
        logger.error("payment_intent.succeeded: payment %s not found", payment_id)
        return

    if payment.status == "succeeded":
        return  # Already handled

    payment.status = "succeeded"
    payment.save(update_fields=["status", "updated_at"])

    # Resolve target — Booking or Order?
    booking = Booking.objects.filter(payment=payment).first()
    if booking:
        _confirm_booking_payment(booking=booking, payment=payment)
        return

    order = payment.orders.first()
    if order:
        from apps.shop.services import confirm_order_payment
        confirm_order_payment(order_id=order.pk)
        _add_loyalty_for_order(order=order)
        _notify_order_paid(order=order)


def _confirm_booking_payment(*, booking, payment) -> None:
    from apps.scheduling.models import Booking as BookingModel
    booking.status = BookingModel.Status.CONFIRMED
    booking.save(update_fields=["status", "updated_at"])
    _add_loyalty_for_booking(booking=booking)
    _notify_booking_confirmed(booking=booking)


def _add_loyalty_for_booking(*, booking) -> None:
    """Award loyalty points + process referral reward for a paid booking."""
    try:
        from apps.loyalty.services import award_points_for_booking, process_referral_reward
        award_points_for_booking(booking=booking)
        process_referral_reward(booking=booking)
    except ImportError:
        pass  # Loyalty app not yet active


def _add_loyalty_for_order(*, order) -> None:
    try:
        from apps.loyalty.services import award_points_for_order
        award_points_for_order(order=order)
    except ImportError:
        pass


def _notify_booking_confirmed(*, booking) -> None:
    try:
        from apps.notifications.services import send_booking_confirmation
        send_booking_confirmation(booking=booking)
    except Exception as exc:
        logger.warning("Failed to send booking confirmation: %s", exc)


def _notify_order_paid(*, order) -> None:
    try:
        from apps.notifications.services import send_order_confirmation
        send_order_confirmation(order=order)
    except Exception as exc:
        logger.warning("Failed to send order confirmation: %s", exc)


@transaction.atomic
def _on_payment_intent_failed(intent: dict) -> None:
    from apps.payments.models import Payment
    payment_id = intent.get("metadata", {}).get("payment_id")
    if payment_id:
        Payment.objects.filter(pk=payment_id).update(status="failed")


@transaction.atomic
def _on_subscription_updated(subscription: dict) -> None:
    _sync_subscription(subscription)


@transaction.atomic
def _on_subscription_deleted(subscription: dict) -> None:
    _sync_subscription(subscription)


def _sync_subscription(subscription: dict) -> None:
    try:
        from apps.loyalty.services import sync_stripe_subscription
        sync_stripe_subscription(subscription=subscription)
    except ImportError:
        pass


def _on_invoice_payment_succeeded(invoice: dict) -> None:
    """Membership renewal — reset washes_used_this_period."""
    try:
        from apps.loyalty.services import handle_invoice_payment_succeeded
        handle_invoice_payment_succeeded(invoice=invoice)
    except ImportError:
        pass


# ── Refunds ────────────────────────────────────────────────────────────────────

def refund_payment(*, payment, amount=None) -> dict:
    """
    Issue a full or partial refund via Stripe.
    `amount` is Decimal; None = full refund.
    """
    s = _get_stripe()
    kwargs: dict = {"payment_intent": payment.stripe_payment_intent_id}
    if amount is not None:
        kwargs["amount"] = int(amount * 100)

    refund = s.Refund.create(**kwargs)

    with transaction.atomic():
        if amount is None or amount >= payment.amount:
            payment.status = "refunded"
        else:
            payment.refunded_amount = (payment.refunded_amount or Decimal(0)) + amount
            payment.status = "partially_refunded"
        payment.save(update_fields=["status", "refunded_amount", "updated_at"])

    return refund
