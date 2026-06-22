"""
Loyalty models — Phase 3 full implementation.

LoyaltyTier       — named tiers (Bronze, Silver, Gold) with wash-count thresholds.
CustomerLoyalty   — per-customer progress tracker.
Referral          — referrer → referee link + reward state.
MembershipPlan    — recurring membership (Stripe Billing).
UserSubscription  — customer ↔ plan subscription.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class LoyaltyTier(TenantScopedModel):
    name = models.CharField(max_length=100)
    threshold_washes = models.PositiveIntegerField(default=0)
    discount_percent = models.DecimalField(max_digits=5, decimal_places=2, default=0)
    perks = models.JSONField(default=dict, blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = "loyalty_tier"
        ordering = ["threshold_washes"]

    def __str__(self):
        return f"LoyaltyTier({self.name}, washes≥{self.threshold_washes})"


class CustomerLoyalty(TenantScopedModel):
    """Per-customer loyalty progress."""
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="loyalty"
    )
    washes_count = models.PositiveIntegerField(default=0)
    points = models.PositiveIntegerField(default=0)
    current_tier = models.ForeignKey(
        LoyaltyTier, on_delete=models.SET_NULL, null=True, blank=True
    )

    class Meta:
        db_table = "loyalty_customer"

    def __str__(self):
        return f"CustomerLoyalty({self.user_id}, washes={self.washes_count})"


class Referral(TenantScopedModel):
    """Referral links: referrer earns reward once referee makes first booking."""

    class RewardState(models.TextChoices):
        PENDING = "pending", "Pending"
        AWARDED = "awarded", "Awarded"
        EXPIRED = "expired", "Expired"

    referrer = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="referrals_made"
    )
    referee = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.SET_NULL,
        null=True, blank=True, related_name="referred_by",
    )
    code = models.CharField(max_length=20, db_index=True)
    reward_state = models.CharField(
        max_length=10, choices=RewardState.choices, default=RewardState.PENDING
    )
    referee_phone = models.CharField(max_length=20, blank=True)

    class Meta:
        db_table = "loyalty_referral"

    def __str__(self):
        return f"Referral(from={self.referrer_id}, code={self.code}, state={self.reward_state})"


class MembershipPlan(TenantScopedModel):
    """Recurring car-wash membership (Stripe Billing)."""
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default="SAR")
    billing_interval = models.CharField(
        max_length=10,
        choices=[("month", "Monthly"), ("year", "Annual")],
        default="month",
    )
    included_washes = models.PositiveSmallIntegerField(default=4)
    discount_percent = models.DecimalField(max_digits=5, decimal_places=2, default=0)
    stripe_price_id = models.CharField(max_length=100, blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = "loyalty_membership_plan"

    def __str__(self):
        return f"MembershipPlan({self.name}, {self.price}/{self.billing_interval})"


class UserSubscription(TenantScopedModel):
    """Customer ↔ MembershipPlan subscription record."""

    class Status(models.TextChoices):
        ACTIVE = "active", "Active"
        PAST_DUE = "past_due", "Past Due"
        CANCELLED = "cancelled", "Cancelled"
        INCOMPLETE = "incomplete", "Incomplete"
        TRIALING = "trialing", "Trialing"

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="subscriptions"
    )
    plan = models.ForeignKey(MembershipPlan, on_delete=models.PROTECT)
    stripe_subscription_id = models.CharField(max_length=100, blank=True, db_index=True)
    stripe_customer_id = models.CharField(max_length=100, blank=True)
    status = models.CharField(
        max_length=15, choices=Status.choices, default=Status.INCOMPLETE, db_index=True
    )
    current_period_start = models.DateTimeField(null=True, blank=True)
    current_period_end = models.DateTimeField(null=True, blank=True)
    washes_used_this_period = models.PositiveSmallIntegerField(default=0)
    cancelled_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "loyalty_user_subscription"

    def __str__(self):
        return f"UserSubscription({self.user_id}, plan={self.plan_id}, status={self.status})"
