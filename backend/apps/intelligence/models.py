"""
Intelligence models — rule-based pricing engine.

PricingRule — a single if/then pricing modifier.
Applied by the pricing engine when computing booking prices.

Per spec §13: no demand-surge for local wash (reputational cost).
Supported rule types: time-of-day, day-of-week, loyalty-tier, promo.
Hard NO: demand-based surge (disabled by default, flag off).
"""
from django.db import models

from apps.common.models import TenantScopedModel


class PricingRule(TenantScopedModel):
    """
    A single pricing rule that modifies a service's base_price.

    Rules are evaluated in priority order; the FIRST matching rule wins (no stacking).
    Discount type: percent or fixed_off.
    """

    class RuleType(models.TextChoices):
        TIME_OF_DAY = "time_of_day", "Time of Day Window"
        DAY_OF_WEEK = "day_of_week", "Day of Week"
        LOYALTY_TIER = "loyalty_tier", "Loyalty Tier Discount"
        SEASONAL = "seasonal", "Seasonal Promo"
        EARLY_BIRD = "early_bird", "Early Bird (first 2 slots)"

    class ModifierType(models.TextChoices):
        PERCENT_OFF = "percent_off", "Percentage Off"
        FIXED_OFF = "fixed_off", "Fixed Amount Off"
        PERCENT_SURCHARGE = "percent_surcharge", "Percentage Surcharge"

    name = models.CharField(max_length=200)
    rule_type = models.CharField(max_length=20, choices=RuleType.choices)
    modifier_type = models.CharField(max_length=20, choices=ModifierType.choices)
    modifier_value = models.DecimalField(max_digits=8, decimal_places=2)
    priority = models.PositiveSmallIntegerField(default=0, help_text="Lower = higher priority")
    is_active = models.BooleanField(default=True, db_index=True)

    # Condition fields (populated per rule_type)
    # time_of_day: match if booking start_time is between time_from and time_to
    time_from = models.TimeField(null=True, blank=True)
    time_to = models.TimeField(null=True, blank=True)
    # day_of_week: JSON list of weekdays [0..6]
    weekdays = models.JSONField(default=list, blank=True)
    # loyalty_tier: FK to LoyaltyTier
    loyalty_tier = models.ForeignKey(
        "loyalty.LoyaltyTier", on_delete=models.SET_NULL,
        null=True, blank=True, related_name="pricing_rules",
    )
    # seasonal: date range
    valid_from = models.DateField(null=True, blank=True)
    valid_until = models.DateField(null=True, blank=True)
    # Apply only to specific services (null = all services)
    service = models.ForeignKey(
        "catalog.Service", on_delete=models.SET_NULL,
        null=True, blank=True, related_name="pricing_rules",
    )

    class Meta:
        db_table = "intelligence_pricing_rule"
        ordering = ["priority", "name"]

    def __str__(self) -> str:
        return f"PricingRule({self.name}, {self.rule_type}, {self.modifier_type}={self.modifier_value})"
