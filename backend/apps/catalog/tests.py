"""
Catalog tests.

Covers:
- Service list: authenticated, unauthenticated, category filter, inactive excluded
- Service detail: happy path, 404, money fields correct
- Branch list: authenticated, unauthenticated, inactive excluded
- BranchHours: correct weekday data returned
"""
import datetime

import pytest
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.catalog.models import Branch, BranchHours, Service, ServiceCategory
from apps.common.models import Tenant


# ── Fixtures ──────────────────────────────────────────────────────────────────

def make_setup():
    tenant, _ = Tenant.objects.get_or_create(slug="cat-test", defaults={"name": "CatTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone="+966511111111",
        defaults={"username": "+966511111111", "tenant": tenant, "role": "customer", "is_phone_verified": True},
    )
    cat, _ = ServiceCategory.objects.get_or_create(
        tenant=tenant, slug="exterior",
        defaults={"name": "Exterior Wash", "is_active": True},
    )
    svc, _ = Service.objects.get_or_create(
        tenant=tenant, slug="basic-wash",
        defaults={
            "category": cat,
            "name": "Basic Wash",
            "base_price": "50.00",
            "currency": "SAR",
            "duration_minutes": 30,
            "is_active": True,
        },
    )
    branch, _ = Branch.objects.get_or_create(
        tenant=tenant, name="Main Branch",
        defaults={"address": "123 King Road", "city": "Riyadh", "is_active": True, "timezone": "Asia/Riyadh"},
    )
    return tenant, user, cat, svc, branch


def auth_client(user):
    c = APIClient()
    c.credentials(HTTP_AUTHORIZATION=f"Bearer {str(RefreshToken.for_user(user).access_token)}")
    return c


# ── Service list ──────────────────────────────────────────────────────────────

class ServiceListTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.svc, self.branch = make_setup()
        self.client = auth_client(self.user)

    def test_list_services_200(self):
        r = self.client.get("/api/v1/services")
        self.assertEqual(r.status_code, 200)
        names = [s["name"] for s in r.data]
        self.assertIn("Basic Wash", names)

    def test_list_services_unauthenticated_401(self):
        r = APIClient().get("/api/v1/services")
        self.assertEqual(r.status_code, 401)
        self.assertEqual(r.json()["code"], "AUTHENTICATION_FAILED")

    def test_inactive_service_excluded_from_list(self):
        self.svc.is_active = False
        self.svc.save(update_fields=["is_active"])
        r = self.client.get("/api/v1/services")
        self.assertEqual(r.status_code, 200)
        names = [s["name"] for s in r.data]
        self.assertNotIn("Basic Wash", names)
        # Restore
        self.svc.is_active = True
        self.svc.save(update_fields=["is_active"])

    def test_filter_services_by_category_returns_only_that_category(self):
        # Create a second category + service
        cat2, _ = ServiceCategory.objects.get_or_create(
            tenant=self.tenant, slug="interior-cat",
            defaults={"name": "Interior", "is_active": True},
        )
        svc2, _ = Service.objects.get_or_create(
            tenant=self.tenant, slug="interior-detail",
            defaults={"category": cat2, "name": "Interior Detail", "base_price": "120.00",
                      "currency": "SAR", "duration_minutes": 90, "is_active": True},
        )
        r = self.client.get(f"/api/v1/services?category={self.cat.pk}")
        self.assertEqual(r.status_code, 200)
        names = [s["name"] for s in r.data]
        self.assertIn("Basic Wash", names)
        self.assertNotIn("Interior Detail", names)

    def test_service_list_contains_expected_fields(self):
        r = self.client.get("/api/v1/services")
        self.assertEqual(r.status_code, 200)
        first = next(s for s in r.data if s["name"] == "Basic Wash")
        for field in ("id", "name", "base_price", "currency", "duration_minutes", "category"):
            self.assertIn(field, first, f"Missing field: {field}")


# ── Service detail ────────────────────────────────────────────────────────────

class ServiceDetailTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.svc, self.branch = make_setup()
        self.client = auth_client(self.user)

    def test_get_service_detail_200(self):
        r = self.client.get(f"/api/v1/services/{self.svc.pk}")
        self.assertEqual(r.status_code, 200)
        self.assertEqual(r.data["slug"], "basic-wash")

    def test_service_detail_price_is_decimal_string(self):
        """Price must come back as a string (never float) to preserve precision."""
        r = self.client.get(f"/api/v1/services/{self.svc.pk}")
        self.assertEqual(r.status_code, 200)
        # DRF serialises DecimalField as str
        price = r.data["base_price"]
        self.assertIsInstance(price, str)
        self.assertEqual(price, "50.00")

    def test_service_detail_currency_present(self):
        r = self.client.get(f"/api/v1/services/{self.svc.pk}")
        self.assertEqual(r.data["currency"], "SAR")

    def test_get_nonexistent_service_404(self):
        r = self.client.get("/api/v1/services/99999")
        self.assertEqual(r.status_code, 404)
        self.assertEqual(r.json()["code"], "NOT_FOUND")

    def test_inactive_service_returns_404(self):
        self.svc.is_active = False
        self.svc.save(update_fields=["is_active"])
        r = self.client.get(f"/api/v1/services/{self.svc.pk}")
        self.assertEqual(r.status_code, 404)
        # Restore
        self.svc.is_active = True
        self.svc.save(update_fields=["is_active"])

    def test_service_detail_unauthenticated_401(self):
        r = APIClient().get(f"/api/v1/services/{self.svc.pk}")
        self.assertEqual(r.status_code, 401)


# ── Branch list ───────────────────────────────────────────────────────────────

class BranchListTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.svc, self.branch = make_setup()
        self.client = auth_client(self.user)

    def test_list_branches_200(self):
        r = self.client.get("/api/v1/branches")
        self.assertEqual(r.status_code, 200)
        self.assertGreaterEqual(len(r.data), 1)

    def test_list_branches_unauthenticated_401(self):
        r = APIClient().get("/api/v1/branches")
        self.assertEqual(r.status_code, 401)

    def test_inactive_branch_excluded(self):
        self.branch.is_active = False
        self.branch.save(update_fields=["is_active"])
        r = self.client.get("/api/v1/branches")
        self.assertEqual(r.status_code, 200)
        ids = [b["id"] for b in r.data]
        self.assertNotIn(self.branch.pk, ids)
        # Restore
        self.branch.is_active = True
        self.branch.save(update_fields=["is_active"])

    def test_branch_contains_timezone_field(self):
        r = self.client.get("/api/v1/branches")
        self.assertEqual(r.status_code, 200)
        first = next((b for b in r.data if b["id"] == self.branch.pk), None)
        self.assertIsNotNone(first)
        self.assertIn("timezone", first)
        self.assertEqual(first["timezone"], "Asia/Riyadh")


# ── BranchHours ───────────────────────────────────────────────────────────────

class BranchHoursTests(TestCase):
    def setUp(self):
        self.tenant, self.user, _, _, self.branch = make_setup()
        self.client = auth_client(self.user)
        # Create Monday (weekday=0) hours
        BranchHours.objects.get_or_create(
            branch=self.branch, weekday=0,
            defaults={"open_time": datetime.time(8, 0), "close_time": datetime.time(20, 0), "is_closed": False},
        )

    def test_branch_hours_returned_in_branch_detail(self):
        r = self.client.get(f"/api/v1/branches/{self.branch.pk}")
        self.assertEqual(r.status_code, 200)
        self.assertIn("hours", r.data)
        monday = next((h for h in r.data["hours"] if h["weekday"] == 0), None)
        self.assertIsNotNone(monday, "Monday hours not returned")
        self.assertEqual(monday["open_time"], "08:00:00")

    def test_closed_day_is_flagged(self):
        BranchHours.objects.filter(branch=self.branch, weekday=5).delete()
        BranchHours.objects.create(
            branch=self.branch, weekday=5,
            open_time=datetime.time(0, 0), close_time=datetime.time(0, 0), is_closed=True,
        )
        r = self.client.get(f"/api/v1/branches/{self.branch.pk}")
        self.assertEqual(r.status_code, 200)
        saturday = next((h for h in r.data["hours"] if h["weekday"] == 5), None)
        self.assertIsNotNone(saturday)
        self.assertTrue(saturday["is_closed"])
