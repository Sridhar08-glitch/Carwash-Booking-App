"""
Celery tasks for notifications.

send_booking_reminders        — fire 24h and 1h-before booking reminders.
send_abandoned_cart_reminders — push to users with inactive carts (> 1h old).
expire_idempotency_records    — delete IdempotencyRecord rows older than 7 days.
"""
from __future__ import annotations

import logging
from datetime import timedelta

from celery import shared_task
from django.utils import timezone

logger = logging.getLogger(__name__)


# ── Booking reminders ─────────────────────────────────────────────────────────

@shared_task(name="notifications.send_booking_reminders", bind=True, max_retries=3)
def send_booking_reminders(self):
    """
    Run every 30 minutes (see Beat schedule).
    Find confirmed bookings whose slot start_time is in the
    [now+23h55m .. now+24h05m] or [now+55m .. now+65m] windows
    and send a reminder push if one hasn't been sent yet.

    Idempotent: checks for an existing Notification of the matching type
    for each booking before sending.
    """
    from apps.scheduling.models import Booking, BookingSlot
    from apps.notifications.models import Notification
    from apps.notifications.services import send_booking_reminder

    now = timezone.now()
    sent_24h = 0
    sent_1h = 0

    for hours_before, notif_type, window_min, window_max in [
        (24, "booking_reminder_24h", timedelta(hours=23, minutes=55), timedelta(hours=24, minutes=5)),
        (1,  "booking_reminder_1h",  timedelta(minutes=55),            timedelta(hours=1, minutes=5)),
    ]:
        # Find slots starting in the window
        slot_start_min = now + window_min
        slot_start_max = now + window_max

        # Get bookings in these slots that are confirmed / assigned
        bookings = (
            Booking.objects.filter(
                status__in=["confirmed", "assigned"],
                slot__isnull=False,
            )
            .select_related("user", "slot")
        )

        for booking in bookings:
            slot = booking.slot
            if not slot:
                continue
            # Combine slot date + start_time into a datetime (UTC)
            import datetime
            slot_dt = datetime.datetime.combine(slot.date, slot.start_time)
            # Assume UTC; branches carry IANA timezone but for now treat as UTC
            slot_dt = timezone.make_aware(slot_dt, timezone.utc)

            if not (slot_start_min <= slot_dt <= slot_start_max):
                continue

            # Don't double-send
            already_sent = Notification.objects.filter(
                user=booking.user,
                type=notif_type,
                data__booking_id=str(booking.pk),
            ).exists()
            if already_sent:
                continue

            try:
                send_booking_reminder(booking=booking, hours_before=hours_before)
                if hours_before == 24:
                    sent_24h += 1
                else:
                    sent_1h += 1
            except Exception as exc:
                logger.exception("Reminder failed for booking %s: %s", booking.pk, exc)

    logger.info("Reminders sent: 24h=%s, 1h=%s", sent_24h, sent_1h)
    return {"sent_24h": sent_24h, "sent_1h": sent_1h}


# ── Abandoned cart ────────────────────────────────────────────────────────────

@shared_task(name="notifications.send_abandoned_cart_reminders", bind=True, max_retries=3)
def send_abandoned_cart_reminders(self):
    """
    Run every hour.
    Find carts with last_activity between 1h and 25h ago
    (i.e. abandoned but not so old it's spam)
    and push a reminder if we haven't pushed one in the last 24h.
    """
    from apps.shop.models import Cart
    from apps.notifications.models import Notification
    from apps.notifications.services import send_abandoned_cart_push

    now = timezone.now()
    cutoff_recent = now - timedelta(hours=1)
    cutoff_old = now - timedelta(hours=25)

    carts = (
        Cart.objects.filter(
            last_activity__lte=cutoff_recent,
            last_activity__gte=cutoff_old,
        )
        .prefetch_related("items")
        .select_related("user")
    )

    sent = 0
    for cart in carts:
        if not cart.items.exists():
            continue

        # Throttle: only one abandoned-cart push per 24h per user
        already_sent = Notification.objects.filter(
            user=cart.user,
            type="abandoned_cart",
            created_at__gte=now - timedelta(hours=24),
        ).exists()
        if already_sent:
            continue

        try:
            send_abandoned_cart_push(user=cart.user, cart=cart)
            sent += 1
        except Exception as exc:
            logger.exception("Abandoned cart push failed for user %s: %s", cart.user_id, exc)

    logger.info("Abandoned cart reminders sent: %s", sent)
    return {"sent": sent}


# ── Idempotency record cleanup ────────────────────────────────────────────────

@shared_task(name="audit.expire_idempotency_records", bind=True, max_retries=3)
def expire_idempotency_records(self, days: int = 7):
    """
    Delete IdempotencyRecord rows older than `days` days.
    Run daily. Safe to re-run (idempotent delete).
    """
    from apps.audit.models import IdempotencyRecord

    cutoff = timezone.now() - timedelta(days=days)
    deleted, _ = IdempotencyRecord.objects.filter(created_at__lt=cutoff).delete()
    logger.info("Expired %s idempotency records older than %s days", deleted, days)
    return {"deleted": deleted}


# -- Birthday notifications ---------------------------------------------------

@shared_task(name="notifications.send_birthday_notifications", bind=True, max_retries=3)
def send_birthday_notifications(self):
    """
    Run daily at 09:00 local time (UTC approximation via Beat schedule).
    Find users whose date_of_birth matches today and send a birthday push
    if we haven't already done so this year.
    """
    from django.utils import timezone
    from apps.accounts.models import CustomUser
    from .models import Notification
    from .services import send_notification

    today = timezone.now().date()
    # Match on month + day regardless of year
    users = CustomUser.objects.filter(
        date_of_birth__month=today.month,
        date_of_birth__day=today.day,
        is_active=True,
        is_deleted=False,
    ).select_related("tenant")

    sent = 0
    for user in users:
        # Idempotent: only one birthday push per year per user
        already = Notification.objects.filter(
            user=user,
            type="birthday",
            created_at__year=today.year,
        ).exists()
        if already:
            continue
        try:
            send_notification(
                user=user,
                title="Happy Birthday! 🎂",
                body="Celebrate with a fresh car wash. Use code BIRTHDAY15 for 15% off!",
                notification_type="birthday",
                data={"promo_hint": "BIRTHDAY15"},
            )
            sent += 1
        except Exception as exc:
            logger.exception("Birthday notification failed for user %s: %s", user.pk, exc)

    logger.info("Birthday notifications sent: %s", sent)
    return {"sent": sent}


# -- Membership renewal reminders ---------------------------------------------

@shared_task(name="notifications.send_membership_renewal_reminders", bind=True, max_retries=3)
def send_membership_renewal_reminders(self):
    """
    Run daily.
    Find UserSubscriptions whose current_period_end is in [now+2d .. now+3d]
    and push a renewal reminder if one hasn't been sent in the last 24h.
    """
    from datetime import timedelta
    from django.utils import timezone
    from apps.loyalty.models import UserSubscription
    from .models import Notification
    from .services import send_notification

    now = timezone.now()
    remind_window_start = now + timedelta(days=2)
    remind_window_end = now + timedelta(days=3)

    subs = UserSubscription.objects.filter(
        status__in=["active", "trialing"],
        current_period_end__gte=remind_window_start,
        current_period_end__lte=remind_window_end,
    ).select_related("user", "plan")

    sent = 0
    for sub in subs:
        # Throttle: max one renewal reminder per 24h per user
        already = Notification.objects.filter(
            user=sub.user,
            type="membership_renewal",
            created_at__gte=now - timedelta(hours=24),
        ).exists()
        if already:
            continue
        try:
            days_left = (sub.current_period_end - now).days
            send_notification(
                user=sub.user,
                title="Your membership renews soon 🔁",
                body=f"Your {sub.plan.name} membership renews in {days_left} day(s). "
                     "Make sure your payment method is up to date.",
                notification_type="membership_renewal",
                data={
                    "subscription_id": str(sub.pk),
                    "plan_name": sub.plan.name,
                    "renews_at": sub.current_period_end.isoformat(),
                },
            )
            sent += 1
        except Exception as exc:
            logger.exception("Renewal reminder failed for sub %s: %s", sub.pk, exc)

    logger.info("Membership renewal reminders sent: %s", sent)
    return {"sent": sent}
