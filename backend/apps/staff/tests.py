"""
Staff tests — Phase 3.

Covers:
- Admin assigns staff to a confirmed booking → creates JobAssignment + seeds JobTasks.
- Staff accepts job → status transitions.
- Staff advances status: en_route → in_progress → completed (mirrors Booking status).
- Invalid transition rejected.
- Toggle task done/undone.
- Presign URL returned (dev mode fallback).
- Record photo saves JobPhoto.
- API endpoints: happy path + permission failures.
"""
import datetime
import itertools

from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.catalog.models import Branch, Service, ServiceCategory
from apps.common.errors import ConflictError, NotFoundError
from apps.common.models import Tenant
from apps.scheduling.models import Booking, BookingSlot
from apps.staff import services
from apps.staff.models import JobAssignment, JobTask, TaskTemplate


# ── Shared fixtures ────────────────────────────────────────────────────────────

def _make_base():
    tenant, _ = Tenant.objects.get_or_create(slug="staff-test", defaults={"name": "StaffTest"})

    customer, _ = CustomUser.objects.get_or_create(
        phone="+966560000001",
        defaults={"username": "+966560000001", "tenant": tenant, "role": "customer"},
    )
    staff_user, _ = CustomUser.objects.get_or_create(
        phone="+966560000002",
        defaults={"username": "+966560000002", "tenant": tenant, "role": "staff"},
    )
    admin_user, _ = CustomUser.objects.get_or_create(
        phone="+966560000003",
        defaults={"username": "+966560000003", "tenant": tenant, "role": "admin", "is_staff": True},
    )

    cat, _ = ServiceCategory.objects.get_or_create(
        tenant=tenant, slug="staff-ext", defaults={"name": "Exterior", "is_active": True}
    )
    service, _ = Service.objects.get_or_create(
        tenant=tenant, slug="staff-basic",
        defaults={
            "category": cat, "name": "Basic Wash", "base_price": "80.00",
            "currency": "SAR", "duration_minutes": 60,
        },
    )
    branch, _ = Branch.objects.get_or_create(
        tenant=tenant, name="Staff Test Branch",
        defaults={"address": "Test Rd", "city": "Riyadh", "is_active": True},
    )
    return tenant, customer, staff_user, admin_user, service, branch


_slot_seq = itertools.count()


def _make_slot(tenant, branch, service):
    # Unique start_time per call — the slot table has a uniqueness constraint
    # on (branch, service, date, start_time).
    minute = next(_slot_seq) % 60
    return BookingSlot.objects.create(
        tenant=tenant, branch=branch, service=service,
        date=datetime.date.today() + datetime.timedelta(days=1),
        start_time=datetime.time(10, minute),
        end_time=datetime.time(11, 0),
        capacity_total=3, capacity_left=3, is_active=True,
    )


def _make_booking(tenant, customer, service, branch, slot):
    from apps.payments.models import Payment
    payment = Payment.objects.create(
        tenant=tenant, user=customer, amount="80.00", currency="SAR",
        method=Payment.Method.CASH, status=Payment.Status.PENDING,
    )
    return Booking.objects.create(
        tenant=tenant, user=customer, service=service, branch=branch, slot=slot,
        status=Booking.Status.CONFIRMED, location_type=Booking.LocationType.BRANCH,
        price_charged="80.00", currency="SAR", payment=payment,
        scheduled_date=slot.date, scheduled_start=slot.start_time,
    )


def _api_client(user):
    c = APIClient()
    c.credentials(HTTP_AUTHORIZATION=f"Bearer {str(RefreshToken.for_user(user).access_token)}")
    return c


# ── Unit tests: service layer ──────────────────────────────────────────────────

class AssignStaffTests(TestCase):
    def setUp(self):
        self.tenant, self.customer, self.staff_user, self.admin, self.service, self.branch = _make_base()
        self.slot = _make_slot(self.tenant, self.branch, self.service)
        self.booking = _make_booking(self.tenant, self.customer, self.service, self.branch, self.slot)

    def test_assign_creates_job_assignment(self):
        assignment = services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )
        self.assertEqual(assignment.staff, self.staff_user)
        self.assertEqual(assignment.status, JobAssignment.AssignmentStatus.PENDING)
        self.booking.refresh_from_db()
        self.assertEqual(self.booking.status, Booking.Status.ASSIGNED)

    def test_assign_seeds_tasks_from_template(self):
        TaskTemplate.objects.create(
            tenant=self.tenant, service=self.service,
            steps=["Pre-rinse", "Foam cannon", "Hand wash", "Dry"],
        )
        assignment = services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )
        tasks = JobTask.objects.filter(assignment=assignment).order_by("ordering")
        self.assertEqual(tasks.count(), 4)
        self.assertEqual(tasks.first().step_name, "Pre-rinse")

    def test_assign_unknown_booking_raises(self):
        with self.assertRaises(NotFoundError):
            services.assign_staff_to_booking(
                admin_user=self.admin, booking_id=99999, staff_user_id=self.staff_user.pk
            )

    def test_assign_completed_booking_raises(self):
        self.booking.status = Booking.Status.COMPLETED
        self.booking.save()
        with self.assertRaises(ConflictError):
            services.assign_staff_to_booking(
                admin_user=self.admin,
                booking_id=self.booking.pk,
                staff_user_id=self.staff_user.pk,
            )


class JobStatusTests(TestCase):
    def setUp(self):
        self.tenant, self.customer, self.staff_user, self.admin, self.service, self.branch = _make_base()
        self.slot = _make_slot(self.tenant, self.branch, self.service)
        self.booking = _make_booking(self.tenant, self.customer, self.service, self.branch, self.slot)
        self.assignment = services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )

    def test_accept_job_transitions_to_accepted(self):
        assignment = services.accept_job(staff_user=self.staff_user, booking_id=self.booking.pk)
        self.assertEqual(assignment.status, JobAssignment.AssignmentStatus.ACCEPTED)
        self.assertIsNotNone(assignment.accepted_at)

    def test_accept_already_accepted_raises(self):
        services.accept_job(staff_user=self.staff_user, booking_id=self.booking.pk)
        with self.assertRaises(ConflictError):
            services.accept_job(staff_user=self.staff_user, booking_id=self.booking.pk)

    def test_full_lifecycle(self):
        """PENDING → ACCEPTED → EN_ROUTE → IN_PROGRESS → COMPLETED, Booking mirrors."""
        services.accept_job(staff_user=self.staff_user, booking_id=self.booking.pk)

        a = services.update_job_status(
            staff_user=self.staff_user, booking_id=self.booking.pk, new_status="en_route"
        )
        self.assertEqual(a.status, "en_route")
        self.booking.refresh_from_db()
        self.assertEqual(self.booking.status, Booking.Status.EN_ROUTE)

        a = services.update_job_status(
            staff_user=self.staff_user, booking_id=self.booking.pk, new_status="in_progress"
        )
        self.assertEqual(a.status, "in_progress")

        a = services.update_job_status(
            staff_user=self.staff_user, booking_id=self.booking.pk, new_status="completed"
        )
        self.assertEqual(a.status, "completed")
        self.assertIsNotNone(a.finished_at)
        self.booking.refresh_from_db()
        self.assertEqual(self.booking.status, Booking.Status.COMPLETED)

    def test_invalid_transition_raises(self):
        services.accept_job(staff_user=self.staff_user, booking_id=self.booking.pk)
        with self.assertRaises(ConflictError):
            # Can't skip en_route
            services.update_job_status(
                staff_user=self.staff_user, booking_id=self.booking.pk, new_status="in_progress"
            )


class TaskToggleTests(TestCase):
    def setUp(self):
        self.tenant, self.customer, self.staff_user, self.admin, self.service, self.branch = _make_base()
        TaskTemplate.objects.filter(service=self.service).delete()
        TaskTemplate.objects.create(
            tenant=self.tenant, service=self.service, steps=["Step A", "Step B"]
        )
        self.slot = _make_slot(self.tenant, self.branch, self.service)
        self.booking = _make_booking(self.tenant, self.customer, self.service, self.branch, self.slot)
        self.assignment = services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )

    def test_toggle_task_done(self):
        task = JobTask.objects.filter(assignment=self.assignment).first()
        self.assertFalse(task.is_done)
        toggled = services.toggle_task(
            staff_user=self.staff_user, booking_id=self.booking.pk, task_id=task.pk
        )
        self.assertTrue(toggled.is_done)
        self.assertIsNotNone(toggled.done_at)

    def test_toggle_task_undone(self):
        task = JobTask.objects.filter(assignment=self.assignment).first()
        # Toggle twice → back to undone
        services.toggle_task(staff_user=self.staff_user, booking_id=self.booking.pk, task_id=task.pk)
        toggled = services.toggle_task(
            staff_user=self.staff_user, booking_id=self.booking.pk, task_id=task.pk
        )
        self.assertFalse(toggled.is_done)
        self.assertIsNone(toggled.done_at)


class PhotoPresignTests(TestCase):
    def setUp(self):
        self.tenant, self.customer, self.staff_user, self.admin, self.service, self.branch = _make_base()
        self.slot = _make_slot(self.tenant, self.branch, self.service)
        self.booking = _make_booking(self.tenant, self.customer, self.service, self.branch, self.slot)
        services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )

    def test_presign_returns_upload_url_dev_fallback(self):
        result = services.generate_photo_presign(
            staff_user=self.staff_user, booking_id=self.booking.pk, kind="before"
        )
        self.assertIn("upload_url", result)
        self.assertIn("s3_key", result)
        self.assertEqual(result["expires_in"], 3600)

    def test_record_photo_saves_job_photo(self):
        from apps.staff.models import JobPhoto
        presign = services.generate_photo_presign(
            staff_user=self.staff_user, booking_id=self.booking.pk, kind="before"
        )
        photo = services.record_photo(
            staff_user=self.staff_user,
            booking_id=self.booking.pk,
            kind="before",
            s3_key=presign["s3_key"],
            caption="Before wash",
        )
        self.assertEqual(photo.kind, JobPhoto.Kind.BEFORE)
        self.assertEqual(photo.booking, self.booking)
        self.assertEqual(photo.staff, self.staff_user)


# ── API endpoint tests ─────────────────────────────────────────────────────────

class StaffAPITests(TestCase):
    def setUp(self):
        self.tenant, self.customer, self.staff_user, self.admin, self.service, self.branch = _make_base()
        self.slot = _make_slot(self.tenant, self.branch, self.service)
        self.booking = _make_booking(self.tenant, self.customer, self.service, self.branch, self.slot)
        self.assignment = services.assign_staff_to_booking(
            admin_user=self.admin,
            booking_id=self.booking.pk,
            staff_user_id=self.staff_user.pk,
        )
        self.staff_client = _api_client(self.staff_user)
        self.customer_client = _api_client(self.customer)

    def test_staff_job_list_returns_200(self):
        resp = self.staff_client.get("/api/v1/staff/jobs")
        self.assertEqual(resp.status_code, status.HTTP_200_OK)
        self.assertEqual(len(resp.data), 1)

    def test_customer_cannot_access_staff_jobs(self):
        resp = self.customer_client.get("/api/v1/staff/jobs")
        self.assertEqual(resp.status_code, status.HTTP_403_FORBIDDEN)

    def test_staff_accept_job_via_api(self):
        resp = self.staff_client.post(f"/api/v1/staff/jobs/{self.booking.pk}/accept")
        self.assertEqual(resp.status_code, status.HTTP_200_OK)
        self.assertEqual(resp.data["status"], "accepted")

    def test_admin_assign_endpoint(self):
        admin_client = _api_client(self.admin)
        # Create a second staff user
        staff2, _ = CustomUser.objects.get_or_create(
            phone="+966560000099",
            defaults={"username": "+966560000099", "tenant": self.tenant, "role": "staff"},
        )
        # Create a fresh booking for reassignment
        slot2 = _make_slot(self.tenant, self.branch, self.service)
        booking2 = _make_booking(self.tenant, self.customer, self.service, self.branch, slot2)
        resp = admin_client.post(
            f"/api/v1/admin-api/bookings/{booking2.pk}/assign",
            {"staff_user_id": self.staff_user.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, status.HTTP_200_OK)

    def test_status_advance_en_route(self):
        self.staff_client.post(f"/api/v1/staff/jobs/{self.booking.pk}/accept")
        resp = self.staff_client.post(
            f"/api/v1/staff/jobs/{self.booking.pk}/status",
            {"status": "en_route"},
            format="json",
        )
        self.assertEqual(resp.status_code, status.HTTP_200_OK)
        self.assertEqual(resp.data["status"], "en_route")

    def test_photo_presign_endpoint(self):
        resp = self.staff_client.post(
            f"/api/v1/staff/jobs/{self.booking.pk}/photos/presign",
            {"kind": "before"},
            format="json",
        )
        self.assertEqual(resp.status_code, status.HTTP_200_OK)
        self.assertIn("upload_url", resp.data)
