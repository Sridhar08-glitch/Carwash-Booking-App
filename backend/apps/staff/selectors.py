"""
Staff selectors — read-only queries for the staff app.

All writes are in services.py. These selectors are called from views.
"""
from __future__ import annotations

from django.db.models import QuerySet

from apps.scheduling.models import Booking


def get_jobs_for_staff(*, staff_user) -> QuerySet:
    """
    Return all bookings assigned to this staff member, ordered by scheduled
    date descending. Excludes soft-deleted bookings.

    Prefetches the minimum set of relations needed for the job-list serializer.
    """
    return (
        Booking.objects.filter(assigned_staff=staff_user)
        .select_related("user", "service", "branch", "vehicle", "slot")
        .prefetch_related("job_assignment")
        .order_by("-scheduled_date", "-scheduled_start")
    )


def get_active_jobs_for_staff(*, staff_user) -> QuerySet:
    """
    Return only bookings in active states (assigned, en_route, in_progress).
    These are the jobs the staff member needs to action right now.
    """
    active_statuses = [
        Booking.Status.ASSIGNED,
        Booking.Status.EN_ROUTE,
        Booking.Status.IN_PROGRESS,
    ]
    return get_jobs_for_staff(staff_user=staff_user).filter(status__in=active_statuses)


def get_pending_jobs_for_admin(*, tenant_id) -> QuerySet:
    """
    Return all confirmed bookings with no staff assignment yet.
    Used by the admin assignment view.
    """
    return (
        Booking.objects.filter(
            tenant_id=tenant_id,
            status=Booking.Status.CONFIRMED,
            assigned_staff__isnull=True,
        )
        .select_related("user", "service", "branch", "slot")
        .order_by("scheduled_date", "scheduled_start")
    )


def get_job_detail(*, staff_user, booking_id: int) -> Booking | None:
    """
    Return a single booking for the given staff user, with all relations
    needed for the job-detail serializer. Returns None if not found or
    not assigned to this staff member.
    """
    return (
        Booking.objects.filter(pk=booking_id, assigned_staff=staff_user)
        .select_related(
            "user",
            "service",
            "branch",
            "slot",
            "vehicle",
            "address",
            "job_assignment",
        )
        .prefetch_related("job_assignment__tasks", "job_photos")
        .first()
    )
