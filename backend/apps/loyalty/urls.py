from django.urls import path

from .views import (
    LoyaltyStatusView,
    LoyaltyTierListView,
    MembershipCancelView,
    MembershipPlanListView,
    MembershipSubscribeView,
    MySubscriptionView,
    ReferralListCreateView,
)

urlpatterns = [
    path("loyalty/status", LoyaltyStatusView.as_view(), name="loyalty-status"),
    path("loyalty/tiers", LoyaltyTierListView.as_view(), name="loyalty-tiers"),
    path("loyalty/referrals", ReferralListCreateView.as_view(), name="loyalty-referrals"),
    path("memberships/plans", MembershipPlanListView.as_view(), name="membership-plans"),
    path("memberships/subscribe", MembershipSubscribeView.as_view(), name="membership-subscribe"),
    path("memberships/cancel", MembershipCancelView.as_view(), name="membership-cancel"),
    path("memberships/my", MySubscriptionView.as_view(), name="membership-my"),
]
