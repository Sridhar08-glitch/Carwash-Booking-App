"""
Notification service layer.

send_notification           — persist Notification + dispatch FCM push.
send_booking_confirmation   — called by Stripe webhook / cash confirm.
send_booking_reminder       — called by Celery reminder task.
send_order_confirmation     — called by Stripe webhook on order paid.
send_abandoned_cart_push    — called by Celery abandoned-cart task.
_send_fcm                   — raw FCM dispatch via firebase-admin.
"""
from __future__ import annotations

import logging

from django.conf import settings

logger = logging.getLogger(__name__)


# ── Core send ─────────────────────────────────────────────────────────────────

def send_notification(
    *,
    user,
    title: str,
    body: str,
    notification_type: str = "general",
    data: dict | None = None,
) -> "Notification":
    """
    Persist a Notification row and push via FCM if the user has a token
    and has not opted out.
    Never raises — FCM failures are logged, not re-raised.
    """
    from .models import Notification

    notif = Notification.objects.create(
        tenant=user.tenant,
        user=user,
        title=title,
        body=body,
        type=notification_type,
        data=data or {},
    )

    # Push only if user has an FCM token and push is enabled
    if _should_push(user=user):
        fcm_id = _send_fcm(
            token=user.fcm_token,
            title=title,
            body=body,
            data=data or {},
        )
        if fcm_id:
            notif.fcm_message_id = fcm_id
            notif.save(update_fields=["fcm_message_id"])

    return notif


def _should_push(*, user) -> bool:
    """Return True if this user has a valid FCM token and push is enabled."""
    if not getattr(user, "fcm_token", None):
        return False
    # Check notification preference (default ON)
    pref = getattr(user, "notification_prefs", None)
    if pref is None:
        try:
            from .models import NotificationPreference
            pref = NotificationPreference.objects.filter(user=user).first()
        except Exception:
            return True
    if pref and not pref.push_enabled:
        return False
    return True


def _send_fcm(*, token: str, title: str, body: str, data: dict) -> str | None:
    """
    Send a push via Firebase Cloud Messaging.
    Returns the FCM message_id on success; None on failure.
    """
    if not getattr(settings, "FCM_ENABLED", False):
        logger.debug("FCM disabled — skipping push: %s", title)
        return None

    try:
        import firebase_admin
        from firebase_admin import messaging

        # Initialise app once (idempotent)
        if not firebase_admin._apps:
            import firebase_admin.credentials as creds
            credential = creds.Certificate(settings.FCM_CREDENTIALS)
            firebase_admin.initialize_app(credential)

        message = messaging.Message(
            notification=messaging.Notification(title=title, body=body),
            data={k: str(v) for k, v in data.items()},
            token=token,
            android=messaging.AndroidConfig(priority="high"),
            apns=messaging.APNSConfig(
                payload=messaging.APNSPayload(
                    aps=messaging.Aps(sound="default", badge=1)
                )
            ),
        )
        response = messaging.send(message)
        logger.info("FCM sent: %s → %s", title, response)
        return response

    except Exception as exc:
        logger.warning("FCM send failed for token %s: %s", token[:20] if token else "?", exc)
        return None


# ── Domain-specific senders ───────────────────────────────────────────────────

def send_booking_confirmation(*, booking) -> None:
    send_notification(
        user=booking.user,
        title="Booking Confirmed ✅",
        body=f"Your car wash is confirmed for {booking.slot.date if booking.slot else 'your chosen time'}.",
        notification_type="booking_confirmed",
        data={"booking_id": str(booking.pk)},
    )


def send_booking_reminder(*, booking, hours_before: int) -> None:
    label = "tomorrow" if hours_before >= 24 else "in 1 hour"
    slot_date = booking.slot.date if booking.slot else "your appointment"
    send_notification(
        user=booking.user,
        title=f"Car Wash Reminder 🚗",
        body=f"Your car wash is {label} ({slot_date}). Get your vehicle ready!",
        notification_type=f"booking_reminder_{hours_before}h",
        data={"booking_id": str(booking.pk), "hours_before": str(hours_before)},
    )


def send_booking_cancelled(*, booking, reason: str = "") -> None:
    body = "Your booking has been cancelled."
    if reason:
        body += f" Reason: {reason}"
    send_notification(
        user=booking.user,
        title="Booking Cancelled",
        body=body,
        notification_type="booking_cancelled",
        data={"booking_id": str(booking.pk)},
    )


def send_order_confirmation(*, order) -> None:
    send_notification(
        user=order.user,
        title="Order Confirmed 🛍️",
        body=f"Your order #{order.pk} has been placed. Total: {order.total} {order.currency}.",
        notification_type="order_confirmed",
        data={"order_id": str(order.pk)},
    )


def send_order_shipped(*, order) -> None:
    send_notification(
        user=order.user,
        title="Order Shipped 📦",
        body=f"Your order #{order.pk} is on its way! Tracking: {order.tracking_number or 'N/A'}",
        notification_type="order_shipped",
        data={"order_id": str(order.pk)},
    )


def send_abandoned_cart_push(*, user, cart) -> None:
    from .models import NotificationPreference
    pref = NotificationPreference.objects.filter(user=user).first()
    if pref and not pref.promotions:
        return  # User opted out of promotions
    send_notification(
        user=user,
        title="You left something behind 🛒",
        body="Your cart is waiting. Complete your order before items sell out!",
        notification_type="abandoned_cart",
        data={"cart_id": str(cart.pk)},
    )


def send_loyalty_points_earned(*, user, points: int, reason: str = "") -> None:
    send_notification(
        user=user,
        title=f"+{points} Points Earned! ⭐",
        body=f"You earned {points} loyalty points{(' for ' + reason) if reason else ''}.",
        notification_type="loyalty_points",
        data={"points": str(points)},
    )
