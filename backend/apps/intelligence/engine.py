"""
Rule-based pricing engine.

compute_price(service, booking_time, user) → Decimal

Evaluates all active PricingRules for the tenant in priority order.
First matching rule wins — no stacking.
Returns the final price (never negative, never below min_price).
"""
from __future__ import annotations

import logging
from decimal import Decimal

logger = logging.getLogger(__name__)

MIN_PRICE = Decimal("1.00")


def compute_price(*, service, booking_datetime, user=None) -> Decimal:
    """
    Compute the final price for a service at a given booking time.

    Priority: PricingRules → loyalty_tier discount → base_price.
    Returns a Decimal, always >= MIN_PRICE.
    """
    base = service.base_price

    # Load rules for this tenant + service
    from .models import PricingRule
    rules = PricingRule.objects.filter(
        tenant=service.tenant,
        is_active=True,
    ).filter(
        # service-specific or global
        __import__("django.db.models", fromlist=["Q"]).Q(service=service) |
        __import__("django.db.models", fromlist=["Q"]).Q(service__isnull=True)
    ).select_related("loyalty_tier").order_by("priority")

    for rule in rules:
        if _rule_matches(rule=rule, booking_datetime=booking_datetime, user=user):
            price = _apply_modifier(base=base, rule=rule)
            logger.debug("PricingRule %s matched: base=%s → %s", rule.name, base, price)
            return max(price, MIN_PRICE)

    # Loyalty tier discount (applied if no rule already discounted)
    if user:
        tier_discount = _get_loyalty_discount(user=user, service=service)
        if tier_discount > 0:
            price = base * (1 - tier_discount / 100)
            return max(price.quantize(Decimal("0.01")), MIN_PRICE)

    return base


def _rule_matches(*, rule, booking_datetime, user) -> bool:
    from datetime import date as ddate
    rt = rule.rule_type

    if rt == "time_of_day":
        t = booking_datetime.time()
        if rule.time_from and rule.time_to:
            return rule.time_from <= t <= rule.time_to
        return False

    if rt == "day_of_week":
        wd = booking_datetime.weekday()
        return wd in (rule.weekdays or [])

    if rt == "loyalty_tier":
        if not user or not rule.loyalty_tier:
            return False
        loyalty = getattr(user, "loyalty", None)
        if not loyalty:
            try:
                from apps.loyalty.models import CustomerLoyalty
                loyalty = CustomerLoyalty.objects.filter(user=user).first()
            except Exception:
                return False
        return loyalty and loyalty.current_tier_id == rule.loyalty_tier_id

    if rt == "seasonal":
        d = booking_datetime.date()
        if rule.valid_from and rule.valid_until:
            return rule.valid_from <= d <= rule.valid_until
        return False

    if rt == "early_bird":
        # First 2 slots of the day: start_time before 10:00
        return booking_datetime.time().hour < 10

    return False


def _apply_modifier(*, base: Decimal, rule) -> Decimal:
    mt = rule.modifier_type
    val = rule.modifier_value

    if mt == "percent_off":
        return (base * (1 - val / 100)).quantize(Decimal("0.01"))
    if mt == "fixed_off":
        return max(base - val, Decimal("0"))
    if mt == "percent_surcharge":
        return (base * (1 + val / 100)).quantize(Decimal("0.01"))
    return base


def _get_loyalty_discount(*, user, service) -> Decimal:
    """Return the loyalty tier discount % for this user, or 0."""
    try:
        from apps.loyalty.models import CustomerLoyalty
        loyalty = CustomerLoyalty.objects.filter(user=user).select_related("current_tier").first()
        if loyalty and loyalty.current_tier:
            return loyalty.current_tier.discount_percent
    except Exception:
        pass
    return Decimal("0")
