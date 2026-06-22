"""Read-only queries for the scheduling app."""
from __future__ import annotations

from datetime import date

from django.db.models import Q, QuerySet

from .models import Booking, BookingSlot, RecurringBookingRule


def get_available_slots(
    *,
    tenant_id,
    target_date: date,
    service_id: int | None = None,
    branch_id: int | None = None,
) -> QuerySet:
    qs = (
        BookingSlot.objects.filter(
            tenant_id=tenant_id,
            date=target_date,
            is_active=True,
            capacity_left__gt=0,
        )
        .select_related("branch", "service")
        .order_by("start_time")
    )
    if service_id:
        qs = qs.filter(service_id=service_id)
    if branch_id:
        qs = qs.filter(branch_id=branch_id)
    return qs


def get_user_bookings(*, user, status: str | None = None) -> QuerySet:
    qs = (
        Booking.objects.filter(user=user)
        .select_related("service", "branch", "slot", "vehicle", "payment")
        .order_by("-scheduled_date", "-scheduled_start")
    )
    if status:
        qs = qs.filter(status=status)
    return qs


def get_booking_by_id(*, user, booking_id: int) -> Booking | None:
    return (
        Booking.objects.filter(pk=booking_id)
        .filter(Q(user=user) | Q(assigned_staff=user))
        .select_related("service", "branch", "slot", "vehicle", "payment", "assigned_staff")
        .first()
    )


def get_recurring_rules(*, user) -> QuerySet:
    return (
        RecurringBookingRule.objects.filter(user=user, is_active=True)
        .select_related("service", "branch")
        .order_by("-created_at")
    )


def get_bookings_for_staff(*, staff_user, status: str | None = None) -> QuerySet:
    """All bookings assigned to this staff member."""
    qs = (
        Booking.objects.filter(assigned_staff=staff_user)
        .select_related("service", "branch", "slot", "vehicle", "user")
        .order_by("-scheduled_date", "-scheduled_start")
    )
    if status:
        qs = qs.filter(status=status)
    return qs
