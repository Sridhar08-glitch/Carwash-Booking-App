"""
Loyalty tests — Phase 3.

Covers:
- award_points_for_booking: creates CustomerLoyalty, increments washes_count + points.
- Tier promotion: customer crosses threshold → current_tier updated.
- award_points_for_order: points from shop order.
- sync_stripe_subscription: status synced from Stripe payload.
- handle_invoice_payment_succeeded: resets washes_used_this_period.
- API: GET loyalty/status, GET loyalty/tiers, GET/POST loyalty/referrals.
- Membership: GET /memberships/plans, POST /memberships/subscribe (mocked Stripe),
              POST /memberships/cancel, GET /memberships/my.
"""
from decimal import Decimal
from unittest.mock import MagicMock, patch

from django.test import TestCase
from rest_framework import status as http_status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.common.models import Tenant
from apps.loyalty import services
from apps.loyalty.models import (
    CustomerLoyalty,
    LoyaltyTier,
    MembershipPlan,
    Referral,
    UserSubscription,
)


# ── Fixtures ──────────────────────────────────────────────────────────────────

def _make_base():
    tenant, _ = Tenant.objects.get_or_create(slug="loyalty-test", defaults={"name": "LoyaltyTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone="+966570000001",
        defaults={"username": "+966570000001", "tenant": tenant, "role": "customer"},
    )
    return tenant, user


def _api_client(user):
    c = APIClient()
    c.credentials(HTTP_AUTHORIZATION=f"Bearer {str(RefreshToken.for_user(user).access_token)}")
    return c


def _make_booking(tenant, user, price="80.00"):
    """Minimal Booking-like object for award_points_for_booking."""
    from apps.catalog.models import Branch, Service, ServiceCategory
    from apps.scheduling.models import Booking, BookingSlot
    from apps.payments.models import Payment
    import datetime

    cat, _ = ServiceCategory.objects.get_or_create(
        tenant=tenant, slug="loyalty-ext", defaults={"name": "Exterior", "is_active": True}
    )
    svc, _ = Service.objects.get_or_create(
        tenant=tenant, slug="loyalty-basic",
        defaults={"category": cat, "name": "Loyalty Wash", "base_price": price, "currency": "SAR", "duration_minutes": 60},
    )
    branch, _ = Branch.objects.get_or_create(
        tenant=tenant, name="Loyalty Branch",
        defaults={"address": "Main St", "city": "Riyadh", "is_active": True},
    )
    slot, _ = BookingSlot.objects.get_or_create(
        tenant=tenant, branch=branch, service=svc,
        date=datetime.date.today() + datetime.timedelta(days=1),
        start_time=datetime.time(9, 0),
        defaults={
            "end_time": datetime.time(10, 0),
            "capacity_total": 5, "capacity_left": 5, "is_active": True,
        },
    )
    payment = Payment.objects.create(
        tenant=tenant, user=user, amount=price, currency="SAR",
        method=Payment.Method.CASH, status=Payment.Status.PENDING,
    )
    return Booking.objects.create(
        tenant=tenant, user=user, service=svc, branch=branch, slot=slot,
        status=Booking.Status.CONFIRMED, location_type="branch",
        price_charged=Decimal(price), currency="SAR", payment=payment,
        scheduled_date=slot.date, scheduled_start=slot.start_time,
    )


def _make_order(tenant, user, total="150.00"):
    from apps.shop.models import Order
    return Order.objects.create(
        tenant=tenant, user=user, status="paid",
        subtotal=Decimal(total), total=Decimal(total), currency="SAR",
    )


# ── Loyalty service unit tests ─────────────────────────────────────────────────

class LoyaltyPointsTests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_base()
        CustomerLoyalty.objects.filter(user=self.user).delete()

    def test_award_points_creates_loyalty_record(self):
        booking = _make_booking(self.tenant, self.user, "100.00")
        services.award_points_for_booking(booking=booking)
        loyalty = CustomerLoyalty.objects.get(user=self.user)
        self.assertEqual(loyalty.washes_count, 1)
        self.assertEqual(loyalty.points, 100)

    def test_award_points_accumulates(self):
        b1 = _make_booking(self.tenant, self.user, "80.00")
        b2 = _make_booking(self.tenant, self.user, "120.00")
        services.award_points_for_booking(booking=b1)
        services.award_points_for_booking(booking=b2)
        loyalty = CustomerLoyalty.objects.get(user=self.user)
        self.assertEqual(loyalty.washes_count, 2)
        self.assertEqual(loyalty.points, 200)

    def test_award_points_for_order(self):
        order = _make_order(self.tenant, self.user, "200.00")
        services.award_points_for_order(order=order)
        loyalty = CustomerLoyalty.objects.get(user=self.user)
        self.assertEqual(loyalty.points, 200)
        # washes_count not incremented for shop orders
        self.assertEqual(loyalty.washes_count, 0)


class LoyaltyTierTests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_base()
        CustomerLoyalty.objects.filter(user=self.user).delete()
        LoyaltyTier.objects.filter(tenant=self.tenant).delete()
        self.silver = LoyaltyTier.objects.create(
            tenant=self.tenant, name="Silver", threshold_washes=5, discount_percent=5
        )
        self.gold = LoyaltyTier.objects.create(
            tenant=self.tenant, name="Gold", threshold_washes=10, discount_percent=10
        )

    def test_tier_promoted_at_threshold(self):
        loyalty = CustomerLoyalty.objects.create(
            tenant=self.tenant, user=self.user, washes_count=4, points=0
        )
        # One more wash → reaches Silver threshold (5)
        booking = _make_booking(self.tenant, self.user)
        services.award_points_for_booking(booking=booking)
        loyalty.refresh_from_db()
        self.assertEqual(loyalty.current_tier, self.silver)

    def test_tier_stays_at_gold_past_threshold(self):
        loyalty = CustomerLoyalty.objects.create(
            tenant=self.tenant, user=self.user, washes_count=9, points=0, current_tier=self.silver
        )
        booking = _make_booking(self.tenant, self.user)
        services.award_points_for_booking(booking=booking)
        loyalty.refresh_from_db()
        self.assertEqual(loyalty.current_tier, self.gold)


# ── Stripe subscription sync tests ────────────────────────────────────────────

class SubscriptionSyncTests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_base()
        plan, _ = MembershipPlan.objects.get_or_create(
            tenant=self.tenant, name="Basic",
            defaults={
                "price": "99.00", "currency": "SAR",
                "billing_interval": "month", "included_washes": 4,
            },
        )
        self.sub = UserSubscription.objects.create(
            tenant=self.tenant, user=self.user, plan=plan,
            stripe_subscription_id="sub_test123",
            status=UserSubscription.Status.ACTIVE,
        )

    def test_sync_cancels_subscription(self):
        services.sync_stripe_subscription(subscription={
            "id": "sub_test123",
            "status": "canceled",
        })
        self.sub.refresh_from_db()
        self.assertEqual(self.sub.status, UserSubscription.Status.CANCELLED)

    def test_sync_unknown_subscription_is_noop(self):
        # Should not raise
        services.sync_stripe_subscription(subscription={
            "id": "sub_nonexistent",
            "status": "canceled",
        })

    def test_invoice_payment_resets_washes(self):
        self.sub.washes_used_this_period = 3
        self.sub.save()
        services.handle_invoice_payment_succeeded(invoice={"subscription": "sub_test123"})
        self.sub.refresh_from_db()
        self.assertEqual(self.sub.washes_used_this_period, 0)


# ── API endpoint tests ─────────────────────────────────────────────────────────

class LoyaltyAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_base()
        self.client = _api_client(self.user)
        LoyaltyTier.objects.filter(tenant=self.tenant).delete()
        LoyaltyTier.objects.create(
            tenant=self.tenant, name="Bronze", threshold_washes=0, discount_percent=0
        )
        LoyaltyTier.objects.create(
            tenant=self.tenant, name="Silver", threshold_washes=5, discount_percent=5
        )

    def test_loyalty_status_200(self):
        resp = self.client.get("/api/v1/loyalty/status")
        self.assertEqual(resp.status_code, http_status.HTTP_200_OK)
        self.assertIn("washes_count", resp.data)

    def test_loyalty_tiers_200(self):
        resp = self.client.get("/api/v1/loyalty/tiers")
        self.assertEqual(resp.status_code, http_status.HTTP_200_OK)
        self.assertGreaterEqual(len(resp.data), 2)

    def test_referral_create_and_list(self):
        resp = self.client.post("/api/v1/loyalty/referrals")
        self.assertEqual(resp.status_code, http_status.HTTP_201_CREATED)
        self.assertIn("code", resp.data)

        resp2 = self.client.get("/api/v1/loyalty/referrals")
        self.assertEqual(resp2.status_code, http_status.HTTP_200_OK)
        self.assertEqual(len(resp2.data), 1)

    def test_unauthenticated_loyalty_status_401(self):
        anon = APIClient()
        resp = anon.get("/api/v1/loyalty/status")
        self.assertEqual(resp.status_code, http_status.HTTP_401_UNAUTHORIZED)


class MembershipAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_base()
        self.client = _api_client(self.user)
        MembershipPlan.objects.filter(tenant=self.tenant).delete()
        self.plan = MembershipPlan.objects.create(
            tenant=self.tenant, name="Monthly Pro",
            price="199.00", currency="SAR",
            billing_interval="month", included_washes=8,
            stripe_price_id="price_test_abc",
        )

    def test_membership_plans_list(self):
        resp = self.client.get("/api/v1/memberships/plans")
        self.assertEqual(resp.status_code, http_status.HTTP_200_OK)
        self.assertEqual(len(resp.data), 1)
        self.assertEqual(resp.data[0]["name"], "Monthly Pro")

    @patch("apps.payments.stripe_service.create_subscription")
    def test_subscribe_creates_user_subscription(self, mock_create):
        mock_create.return_value = {
            "id": "sub_mock123",
            "customer": "cus_mock456",
            "status": "active",
        }
        resp = self.client.post(
            "/api/v1/memberships/subscribe",
            {"plan_id": self.plan.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, http_status.HTTP_201_CREATED)
        self.assertTrue(UserSubscription.objects.filter(user=self.user).exists())

    @patch("apps.payments.stripe_service.create_subscription")
    @patch("apps.payments.stripe_service.cancel_subscription")
    def test_cancel_subscription(self, mock_cancel, mock_create):
        mock_create.return_value = {"id": "sub_xyz", "customer": "cus_xyz", "status": "active"}
        mock_cancel.return_value = {}

        # Subscribe first
        self.client.post("/api/v1/memberships/subscribe", {"plan_id": self.plan.pk}, format="json")

        # Now cancel
        resp = self.client.post("/api/v1/memberships/cancel")
        self.assertEqual(resp.status_code, http_status.HTTP_200_OK)
        self.assertEqual(resp.data["status"], "cancelled")

    @patch("apps.payments.stripe_service.create_subscription")
    def test_cannot_subscribe_twice(self, mock_create):
        mock_create.return_value = {"id": "sub_dup", "customer": "cus_dup", "status": "active"}
        self.client.post("/api/v1/memberships/subscribe", {"plan_id": self.plan.pk}, format="json")

        # Second subscribe → 409 conflict
        resp = self.client.post("/api/v1/memberships/subscribe", {"plan_id": self.plan.pk}, format="json")
        self.assertEqual(resp.status_code, http_status.HTTP_409_CONFLICT)

    def test_subscribe_inactive_plan_not_found(self):
        self.plan.stripe_price_id = ""  # no stripe price → 409
        self.plan.save()
        resp = self.client.post(
            "/api/v1/memberships/subscribe", {"plan_id": self.plan.pk}, format="json"
        )
        self.assertEqual(resp.status_code, http_status.HTTP_409_CONFLICT)

    def test_my_subscription_empty(self):
        resp = self.client.get("/api/v1/memberships/my")
        self.assertEqual(resp.status_code, http_status.HTTP_200_OK)
