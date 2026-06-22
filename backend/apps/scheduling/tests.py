"""
Scheduling tests.

Critical tests
--------------
* Slot booking happy path
* No oversell: concurrent requests for last slot → only one succeeds
* Cancel booking restores capacity
* Idempotency: same key → same booking returned
* Cannot cancel a completed booking
"""
import datetime
import threading

import pytest
from django.test import TestCase, TransactionTestCase
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.common.models import Tenant
from apps.accounts.models import CustomUser
from apps.catalog.models import Branch, Service, ServiceCategory
from apps.scheduling.models import Booking, BookingSlot
from apps.scheduling import services


def make_base():
    tenant, _ = Tenant.objects.get_or_create(slug="sched-test", defaults={"name": "SchedTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone="+966521111111",
        defaults={"username": "+966521111111", "tenant": tenant, "role": "customer", "is_phone_verified": True},
    )
    cat, _ = ServiceCategory.objects.get_or_create(
        tenant=tenant, slug="sched-ext", defaults={"name": "Exterior", "is_active": True}
    )
    svc, _ = Service.objects.get_or_create(
        tenant=tenant, slug="sched-basic",
        defaults={"category": cat, "name": "Sched Wash", "base_price": "80.00", "currency": "SAR", "duration_minutes": 60},
    )
    branch, _ = Branch.objects.get_or_create(
        tenant=tenant, name="Sched Branch",
        defaults={"address": "Test Rd", "city": "Riyadh", "is_active": True},
    )
    return tenant, user, svc, branch


def make_slot(tenant, branch, svc, capacity=2):
    return BookingSlot.objects.create(
        tenant=tenant, branch=branch, service=svc,
        date=datetime.date.today() + datetime.timedelta(days=1),
        start_time=datetime.time(10, 0),
        end_time=datetime.time(11, 0),
        capacity_total=capacity,
        capacity_left=capacity,
        is_active=True,
    )


def auth_client(user):
    c = APIClient()
    c.credentials(HTTP_AUTHORIZATION=f"Bearer {str(RefreshToken.for_user(user).access_token)}")
    return c


class BookingCreationTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.svc, self.branch = make_base()

    def test_create_booking_decrements_slot_capacity(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=2)
        services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
        )
        slot.refresh_from_db()
        assert slot.capacity_left == 1

    def test_create_booking_via_api_returns_201(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=1)
        c = auth_client(self.user)
        r = c.post("/api/v1/bookings", {
            "service_id": self.svc.pk,
            "slot_id": slot.pk,
            "location_type": "branch",
        }, format="json")
        assert r.status_code == 201
        assert r.data["status"] == "confirmed"

    def test_full_slot_returns_409(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=1)
        services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
        )
        from apps.common.errors import ConflictError
        with pytest.raises(ConflictError):
            # Second user tries to book same full slot
            u2, _ = CustomUser.objects.get_or_create(
                phone="+966522222222",
                defaults={"username": "+966522222222", "tenant": self.tenant, "role": "customer", "is_phone_verified": True},
            )
            services.create_booking(
                user=u2, service_id=self.svc.pk, slot_id=slot.pk,
                vehicle_id=None, location_type="branch", address_id=None,
            )

    def test_idempotency_key_returns_same_booking(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=5)
        key = "test-idem-key-123"
        b1 = services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
            idempotency_key=key,
        )
        b2 = services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
            idempotency_key=key,
        )
        assert b1.pk == b2.pk
        slot.refresh_from_db()
        assert slot.capacity_left == 4  # only decremented once


class BookingCancelTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.svc, self.branch = make_base()

    def test_cancel_booking_restores_capacity(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=1)
        booking = services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
        )
        slot.refresh_from_db()
        assert slot.capacity_left == 0

        services.cancel_booking(user=self.user, booking_id=booking.pk, reason="Changed mind")
        slot.refresh_from_db()
        assert slot.capacity_left == 1

    def test_cannot_cancel_completed_booking(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=1)
        booking = services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
        )
        booking.status = Booking.Status.COMPLETED
        booking.save()
        from apps.common.errors import ConflictError
        with pytest.raises(ConflictError):
            services.cancel_booking(user=self.user, booking_id=booking.pk)

    def test_cancel_via_api(self):
        slot = make_slot(self.tenant, self.branch, self.svc, capacity=1)
        booking = services.create_booking(
            user=self.user, service_id=self.svc.pk, slot_id=slot.pk,
            vehicle_id=None, location_type="branch", address_id=None,
        )
        c = auth_client(self.user)
        r = c.post(f"/api/v1/bookings/{booking.pk}/cancel", {"reason": "test"}, format="json")
        assert r.status_code == 200
        assert r.data["status"] == "cancelled"


class SlotOversellTest(TransactionTestCase):
    """
    Concurrency test: two threads race for the last slot.
    Only one should succeed.
    """

    def test_no_oversell_under_concurrent_requests(self):
        tenant, _ = Tenant.objects.get_or_create(slug="oversell-test", defaults={"name": "Oversell"})
        u1, _ = CustomUser.objects.get_or_create(
            phone="+966531111111",
            defaults={"username": "+966531111111", "tenant": tenant, "role": "customer", "is_phone_verified": True},
        )
        u2, _ = CustomUser.objects.get_or_create(
            phone="+966532222222",
            defaults={"username": "+966532222222", "tenant": tenant, "role": "customer", "is_phone_verified": True},
        )
        cat, _ = ServiceCategory.objects.get_or_create(
            tenant=tenant, slug="ov-ext", defaults={"name": "OvExt", "is_active": True}
        )
        svc, _ = Service.objects.get_or_create(
            tenant=tenant, slug="ov-svc",
            defaults={"category": cat, "name": "OvSvc", "base_price": "50.00", "currency": "SAR", "duration_minutes": 60},
        )
        branch, _ = Branch.objects.get_or_create(
            tenant=tenant, name="OvBranch",
            defaults={"address": "Ov Rd", "city": "Riyadh", "is_active": True},
        )
        slot = BookingSlot.objects.create(
            tenant=tenant, branch=branch, service=svc,
            date=datetime.date.today() + datetime.timedelta(days=2),
            start_time=datetime.time(9, 0), end_time=datetime.time(10, 0),
            capacity_total=1, capacity_left=1, is_active=True,
        )

        results = []
        errors = []

        def try_book(user):
            try:
                b = services.create_booking(
                    user=user, service_id=svc.pk, slot_id=slot.pk,
                    vehicle_id=None, location_type="branch", address_id=None,
                )
                results.append(b.pk)
            except Exception as e:
                errors.append(str(e))

        t1 = threading.Thread(target=try_book, args=(u1,))
        t2 = threading.Thread(target=try_book, args=(u2,))
        t1.start(); t2.start()
        t1.join(); t2.join()

        # Exactly one should have succeeded, one should have got a ConflictError
        assert len(results) == 1
        assert len(errors) == 1
        slot.refresh_from_db()
        assert slot.capacity_left == 0
