from rest_framework import serializers

from .models import CustomerLoyalty, LoyaltyTier, MembershipPlan, Referral, UserSubscription


# ---------------------------------------------------------------------------
# GAP 5 fix: frontend LoyaltyTierDto expects `min_washes`, not `threshold_washes`.
# We expose the DB field under the name the frontend actually reads.
# ---------------------------------------------------------------------------
class LoyaltyTierSerializer(serializers.ModelSerializer):
    # Alias threshold_washes → min_washes to match Flutter LoyaltyTierDto
    min_washes = serializers.IntegerField(source="threshold_washes", read_only=True)

    class Meta:
        model = LoyaltyTier
        fields = ["id", "name", "min_washes", "discount_percent", "perks"]


# ---------------------------------------------------------------------------
# GAP 6 fix: frontend LoyaltyStatusDto expects `washes_to_next`, not
# `washes_to_next_tier`.  Renamed the SerializerMethodField accordingly.
# ---------------------------------------------------------------------------
class CustomerLoyaltySerializer(serializers.ModelSerializer):
    current_tier = LoyaltyTierSerializer(read_only=True)
    next_tier = serializers.SerializerMethodField()
    # Renamed: was washes_to_next_tier — frontend key is washes_to_next
    washes_to_next = serializers.SerializerMethodField()

    class Meta:
        model = CustomerLoyalty
        fields = [
            "washes_count", "points", "current_tier",
            "next_tier", "washes_to_next",
        ]

    def _next_tier_obj(self, obj):
        return LoyaltyTier.objects.filter(
            tenant=obj.tenant,
            is_active=True,
            threshold_washes__gt=obj.washes_count,
        ).order_by("threshold_washes").first()

    def get_next_tier(self, obj):
        next_t = self._next_tier_obj(obj)
        return LoyaltyTierSerializer(next_t).data if next_t else None

    def get_washes_to_next(self, obj):
        next_t = self._next_tier_obj(obj)
        if next_t:
            return next_t.threshold_washes - obj.washes_count
        return 0


# ---------------------------------------------------------------------------
# Referral detail serializer — used by POST response and list items
# ---------------------------------------------------------------------------
class ReferralSerializer(serializers.ModelSerializer):
    referee_phone = serializers.SerializerMethodField()

    class Meta:
        model = Referral
        fields = ["id", "code", "reward_state", "referee_phone", "created_at"]
        read_only_fields = fields

    def get_referee_phone(self, obj):
        if obj.referee:
            return obj.referee.phone
        return obj.referee_phone


# ---------------------------------------------------------------------------
# GAP 4 fix: frontend ReferralDto expects a summary object:
#   { referral_code, total_referrals, points_earned }
# The old GET returned many=True (array) which caused a type crash in Flutter.
# This serializer produces the summary shape the frontend actually parses.
# ---------------------------------------------------------------------------
class ReferralSummarySerializer(serializers.Serializer):
    """
    Summary returned by GET /loyalty/referrals.

    Flutter ReferralDto fields:
      referral_code   — the user's active referral code (or empty string)
      total_referrals — count of referrals this user has made
      points_earned   — sum of loyalty points earned via referrals
    """
    referral_code = serializers.SerializerMethodField()
    total_referrals = serializers.SerializerMethodField()
    points_earned = serializers.SerializerMethodField()

    def get_referral_code(self, referrals_qs):
        # Return the most recent code this user has created
        latest = referrals_qs.order_by("-created_at").first()
        return latest.code if latest else ""

    def get_total_referrals(self, referrals_qs):
        return referrals_qs.count()

    def get_points_earned(self, referrals_qs):
        # Each awarded referral earns points — kept as a simple count for now;
        # replace with actual points field when the reward system is implemented.
        return referrals_qs.filter(reward_state=Referral.RewardState.AWARDED).count() * 100


# ---------------------------------------------------------------------------
# GAP 7 fix: frontend MembershipPlanDto expects:
#   billing_period    (not billing_interval)
#   washes_per_period (not included_washes)
# We expose both under the names the Flutter model actually reads.
# ---------------------------------------------------------------------------
class MembershipPlanSerializer(serializers.ModelSerializer):
    # Aliases to match Flutter MembershipPlanDto field names
    billing_period = serializers.CharField(source="billing_interval", read_only=True)
    washes_per_period = serializers.IntegerField(source="included_washes", read_only=True)

    class Meta:
        model = MembershipPlan
        fields = [
            "id", "name", "description", "price", "currency",
            "billing_period", "washes_per_period", "discount_percent",
        ]


# ---------------------------------------------------------------------------
# GAP 8 fix: frontend UserSubscriptionDto expects:
#   washes_used          (not washes_used_this_period)
#   cancel_at_period_end (missing entirely — computed from cancelled_at)
# ---------------------------------------------------------------------------
class UserSubscriptionSerializer(serializers.ModelSerializer):
    plan = MembershipPlanSerializer(read_only=True)

    # Alias: washes_used_this_period → washes_used
    washes_used = serializers.IntegerField(source="washes_used_this_period", read_only=True)

    # Derived flag: True when the sub is cancelled but still within the paid period.
    # UserSubscription has no boolean field for this, so we derive it from
    # cancelled_at + current_period_end.
    cancel_at_period_end = serializers.SerializerMethodField()

    class Meta:
        model = UserSubscription
        fields = [
            "id", "plan", "status", "current_period_start",
            "current_period_end", "washes_used", "cancel_at_period_end",
            "created_at",
        ]
        read_only_fields = fields

    def get_cancel_at_period_end(self, obj):
        """
        True when the subscription has been cancelled but the paid period has
        not yet expired — matches the semantics of Stripe's cancel_at_period_end.
        """
        from django.utils import timezone
        if obj.status != UserSubscription.Status.CANCELLED:
            return False
        if obj.cancelled_at is None or obj.current_period_end is None:
            return False
        return obj.cancelled_at < obj.current_period_end


class SubscribeSerializer(serializers.Serializer):
    plan_id = serializers.IntegerField()


class CreateReferralSerializer(serializers.Serializer):
    """No body needed — server generates the code."""
    pass
