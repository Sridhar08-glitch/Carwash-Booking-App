"""
Loyalty service layer — Phase 2 stubs.

award_points_for_booking  — called by Stripe webhook on payment_intent.succeeded.
award_points_for_order    — called by Stripe webhook on order payment success.
sync_stripe_subscription  — syncs Stripe subscription status → UserSubscription.
handle_invoice_payment_succeeded — reset washes_used_this_period on renewal.
"""
from __future__ import annotations

import logging
from decimal import Decimal

from django.db import transaction

logger = logging.getLogger(__name__)

# Points ratio: 1 point per SAR spent (configurable in Phase 4)
POINTS_PER_SAR = Decimal("1")


@transaction.atomic
def award_points_for_booking(*, booking) -> None:
    """
    Award loyalty points when a booking is paid.
    Creates CustomerLoyalty row if it doesn't exist yet.
    """
    from .models import CustomerLoyalty, LoyaltyTier

    loyalty, _ = CustomerLoyalty.objects.get_or_create(
        user=booking.user,
        defaults={"tenant": booking.user.tenant},
    )
    points_earned = int(booking.price_charged * POINTS_PER_SAR)
    loyalty.washes_count += 1
    loyalty.points += points_earned
    loyalty.save(update_fields=["washes_count", "points", "updated_at"])

    # Update tier
    _update_tier(loyalty=loyalty)
    logger.info(
        "Loyalty: user=%s booking=%s points+=%s total_washes=%s",
        booking.user_id, booking.pk, points_earned, loyalty.washes_count,
    )


@transaction.atomic
def award_points_for_order(*, order) -> None:
    """Award loyalty points for a shop order."""
    from .models import CustomerLoyalty

    loyalty, _ = CustomerLoyalty.objects.get_or_create(
        user=order.user,
        defaults={"tenant": order.user.tenant},
    )
    points_earned = int(order.total * POINTS_PER_SAR)
    loyalty.points += points_earned
    loyalty.save(update_fields=["points", "updated_at"])
    logger.info("Loyalty: user=%s order=%s points+=%s", order.user_id, order.pk, points_earned)


def _update_tier(*, loyalty) -> None:
    """Promote/demote tier based on washes_count."""
    from .models import LoyaltyTier

    best_tier = (
        LoyaltyTier.objects.filter(
            tenant=loyalty.tenant,
            is_active=True,
            threshold_washes__lte=loyalty.washes_count,
        )
        .order_by("-threshold_washes")
        .first()
    )
    if best_tier and best_tier != loyalty.current_tier:
        loyalty.current_tier = best_tier
        loyalty.save(update_fields=["current_tier", "updated_at"])


@transaction.atomic
def sync_stripe_subscription(*, subscription: dict) -> None:
    """Sync Stripe subscription object → UserSubscription row."""
    from django.utils.dateparse import parse_datetime
    from django.utils import timezone
    from .models import UserSubscription

    stripe_id = subscription.get("id")
    if not stripe_id:
        return

    sub = UserSubscription.objects.filter(stripe_subscription_id=stripe_id).first()
    if not sub:
        logger.warning("sync_stripe_subscription: no UserSubscription for %s", stripe_id)
        return

    stripe_status = subscription.get("status", "")
    status_map = {
        "active": UserSubscription.Status.ACTIVE,
        "past_due": UserSubscription.Status.PAST_DUE,
        "canceled": UserSubscription.Status.CANCELLED,
        "incomplete": UserSubscription.Status.INCOMPLETE,
        "trialing": UserSubscription.Status.TRIALING,
    }
    sub.status = status_map.get(stripe_status, UserSubscription.Status.INCOMPLETE)

    period_start = subscription.get("current_period_start")
    period_end = subscription.get("current_period_end")
    if period_start:
        import datetime
        sub.current_period_start = datetime.datetime.fromtimestamp(period_start, tz=timezone.utc)
    if period_end:
        import datetime
        sub.current_period_end = datetime.datetime.fromtimestamp(period_end, tz=timezone.utc)

    sub.save(update_fields=["status", "current_period_start", "current_period_end", "updated_at"])
    logger.info("Synced subscription %s → status=%s", stripe_id, sub.status)


@transaction.atomic
def handle_invoice_payment_succeeded(*, invoice: dict) -> None:
    """Reset washes_used_this_period on membership renewal."""
    from .models import UserSubscription

    stripe_subscription_id = invoice.get("subscription")
    if not stripe_subscription_id:
        return

    updated = UserSubscription.objects.filter(
        stripe_subscription_id=stripe_subscription_id,
        status=UserSubscription.Status.ACTIVE,
    ).update(washes_used_this_period=0)

    if updated:
        logger.info("Membership renewal: reset washes for subscription %s", stripe_subscription_id)


# -- Referral reward ----------------------------------------------------------

@transaction.atomic
def process_referral_reward(*, booking) -> None:
    """
    Called after a booking is paid (from Stripe webhook / award_points_for_booking).

    If this is the referee's FIRST completed booking and they were referred,
    award loyalty points to the referrer.

    Rules (configurable in Phase 4 via settings):
    - Referrer earns 50 points on the referee's first paid booking.
    - Each referral code can only be rewarded once (RewardState.AWARDED).
    - We do NOT auto-charge / auto-book on referral -- time-based rules only.
    """
    from .models import CustomerLoyalty, Referral

    REFERRAL_POINTS = 50  # Phase 4: move to a settings model

    # Is this the referee's first booking?
    from apps.scheduling.models import Booking
    prior_bookings = Booking.objects.filter(
        user=booking.user,
        status="completed",
    ).exclude(pk=booking.pk).exists()
    if prior_bookings:
        return  # Not first booking -- no referral reward

    # Was this user referred?
    referral = (
        Referral.objects.select_for_update()
        .filter(referee=booking.user, reward_state=Referral.RewardState.PENDING)
        .first()
    )
    if referral is None:
        return  # No pending referral

    # Award points to the referrer
    referrer_loyalty, _ = CustomerLoyalty.objects.get_or_create(
        user=referral.referrer,
        defaults={"tenant": referral.referrer.tenant},
    )
    referrer_loyalty.points += REFERRAL_POINTS
    referrer_loyalty.save(update_fields=["points", "updated_at"])

    # Mark referral as rewarded
    referral.reward_state = Referral.RewardState.AWARDED
    referral.save(update_fields=["reward_state", "updated_at"])

    # Notify the referrer
    try:
        from apps.notifications.services import send_notification
        send_notification(
            user=referral.referrer,
            title="Referral Reward! ⭐",
            body=f"Your friend completed their first car wash. You earned {REFERRAL_POINTS} points!",
            notification_type="loyalty_points",
            data={
                "points": str(REFERRAL_POINTS),
                "reason": "referral",
                "referee_id": str(booking.user_id),
            },
        )
    except Exception:
        pass  # Never block the booking confirm flow


@transaction.atomic
def link_referee_to_referral(*, user, referral_code: str) -> bool:
    """
    Called at OTP-verify registration time if a referral_code was passed.
    Links the new user (referee) to the referral row so reward can fire later.
    Returns True if linked, False if code not found / already used.
    """
    from .models import Referral

    referral = Referral.objects.select_for_update().filter(
        code=referral_code,
        reward_state=Referral.RewardState.PENDING,
        referee__isnull=True,
    ).first()
    if referral is None:
        return False

    referral.referee = user
    referral.referee_phone = user.phone
    referral.save(update_fields=["referee", "referee_phone", "updated_at"])
    return True
