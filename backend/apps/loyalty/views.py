"""
Loyalty views.

LoyaltyStatusView      GET  /api/v1/loyalty/status
LoyaltyTierListView    GET  /api/v1/loyalty/tiers
ReferralListCreateView GET/POST /api/v1/loyalty/referrals
MembershipPlanListView GET  /api/v1/memberships/plans
MembershipSubscribeView POST /api/v1/memberships/subscribe
MembershipCancelView   POST /api/v1/memberships/cancel
"""
import uuid

from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import ConflictError, NotFoundError

from .models import CustomerLoyalty, LoyaltyTier, MembershipPlan, Referral, UserSubscription
from .serializers import (
    CustomerLoyaltySerializer,
    LoyaltyTierSerializer,
    MembershipPlanSerializer,
    ReferralSerializer,
    ReferralSummarySerializer,
    SubscribeSerializer,
    UserSubscriptionSerializer,
)


class LoyaltyStatusView(APIView):
    """GET /api/v1/loyalty/status"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: CustomerLoyaltySerializer}, tags=["loyalty"])
    def get(self, request: Request) -> Response:
        loyalty, _ = CustomerLoyalty.objects.get_or_create(
            user=request.user,
            defaults={"tenant": request.user.tenant},
        )
        return Response(CustomerLoyaltySerializer(loyalty).data)


class LoyaltyTierListView(APIView):
    """GET /api/v1/loyalty/tiers"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: LoyaltyTierSerializer(many=True)}, tags=["loyalty"])
    def get(self, request: Request) -> Response:
        tiers = LoyaltyTier.objects.filter(
            tenant=request.user.tenant, is_active=True
        ).order_by("threshold_washes")
        return Response(LoyaltyTierSerializer(tiers, many=True).data)


class ReferralListCreateView(APIView):
    """GET/POST /api/v1/loyalty/referrals"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: ReferralSummarySerializer}, tags=["loyalty"])
    def get(self, request: Request) -> Response:
        # GAP 4 fix: frontend ReferralDto expects a summary object
        # { referral_code, total_referrals, points_earned }, NOT an array.
        # ReferralSummarySerializer accepts the queryset and derives the fields.
        referrals = Referral.objects.filter(referrer=request.user).order_by("-created_at")
        return Response(ReferralSummarySerializer(referrals).data)

    @extend_schema(responses={201: ReferralSerializer}, tags=["loyalty"], summary="Create a referral link")
    def post(self, request: Request) -> Response:
        # Generate unique referral code
        code = str(uuid.uuid4()).replace("-", "")[:10].upper()
        referral = Referral.objects.create(
            tenant=request.user.tenant,
            referrer=request.user,
            code=code,
            # GAP 4 fix: persist referee_phone from request body when provided
            referee_phone=request.data.get("referee_phone", ""),
        )
        return Response(ReferralSerializer(referral).data, status=status.HTTP_201_CREATED)


# ── Memberships ────────────────────────────────────────────────────────────────

class MembershipPlanListView(APIView):
    """GET /api/v1/memberships/plans"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: MembershipPlanSerializer(many=True)}, tags=["memberships"])
    def get(self, request: Request) -> Response:
        plans = MembershipPlan.objects.filter(
            tenant=request.user.tenant, is_active=True
        ).order_by("price")
        return Response(MembershipPlanSerializer(plans, many=True).data)


class MembershipSubscribeView(APIView):
    """POST /api/v1/memberships/subscribe"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=SubscribeSerializer,
        responses={201: UserSubscriptionSerializer},
        tags=["memberships"],
        summary="Subscribe to a membership plan via Stripe Billing",
    )
    def post(self, request: Request) -> Response:
        s = SubscribeSerializer(data=request.data)
        s.is_valid(raise_exception=True)

        plan = MembershipPlan.objects.filter(
            pk=s.validated_data["plan_id"], tenant=request.user.tenant, is_active=True
        ).first()
        if not plan:
            raise NotFoundError("Membership plan not found.")

        # Check no active subscription already
        active_sub = UserSubscription.objects.filter(
            user=request.user,
            status__in=[UserSubscription.Status.ACTIVE, UserSubscription.Status.TRIALING],
        ).first()
        if active_sub:
            raise ConflictError("You already have an active membership.", code="SUBSCRIPTION_EXISTS")

        if not plan.stripe_price_id:
            raise ConflictError("This plan is not yet available for purchase.", code="PLAN_NOT_STRIPE")

        from apps.payments.stripe_service import create_subscription
        stripe_sub = create_subscription(user=request.user, stripe_price_id=plan.stripe_price_id)

        sub = UserSubscription.objects.create(
            tenant=request.user.tenant,
            user=request.user,
            plan=plan,
            stripe_subscription_id=stripe_sub["id"],
            stripe_customer_id=stripe_sub.get("customer", ""),
            status=stripe_sub.get("status", "incomplete"),
        )
        return Response(UserSubscriptionSerializer(sub).data, status=status.HTTP_201_CREATED)


class MembershipCancelView(APIView):
    """POST /api/v1/memberships/cancel"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: UserSubscriptionSerializer},
        tags=["memberships"],
        summary="Cancel active membership (effective at period end)",
    )
    def post(self, request: Request) -> Response:
        sub = UserSubscription.objects.filter(
            user=request.user,
            status__in=[UserSubscription.Status.ACTIVE, UserSubscription.Status.TRIALING],
        ).first()
        if not sub:
            raise NotFoundError("No active membership to cancel.")

        from apps.payments.stripe_service import cancel_subscription
        cancel_subscription(stripe_subscription_id=sub.stripe_subscription_id)

        sub.status = UserSubscription.Status.CANCELLED
        from django.utils import timezone
        sub.cancelled_at = timezone.now()
        sub.save(update_fields=["status", "cancelled_at", "updated_at"])
        return Response(UserSubscriptionSerializer(sub).data)


class MySubscriptionView(APIView):
    """GET /api/v1/memberships/my"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: UserSubscriptionSerializer}, tags=["memberships"])
    def get(self, request: Request) -> Response:
        sub = UserSubscription.objects.filter(
            user=request.user,
            status__in=[UserSubscription.Status.ACTIVE, UserSubscription.Status.TRIALING, UserSubscription.Status.PAST_DUE],
        ).select_related("plan").first()
        if not sub:
            return Response(None)
        return Response(UserSubscriptionSerializer(sub).data)
