"""
Scheduling service layer — all write operations.

Critical invariant: no slot oversell, ever.
All slot capacity mutations use select_for_update() inside transaction.atomic().
"""
from __future__ import annotations

import logging
from datetime import date, datetime, time, timedelta

from django.conf import settings
from django.db import transaction
from django.utils import timezone

from apps.common.errors import ConflictError, NotFoundError
from apps.common.models import Tenant

from .models import Booking, BookingSlot, RecurringBookingRule, SlotTemplate

logger = logging.getLogger(__name__)

# ── Slot generation (called by Celery Beat) ───────────────────────────────────

def generate_slots_for_tenant(*, tenant: Tenant, days_ahead: int = 14) -> int:
    """
    Materialise BookingSlots from SlotTemplates for the next `days_ahead` days.
    Returns the number of slots created.
    Called nightly by `apps.scheduling.tasks.generate_booking_slots`.
    """
    from apps.catalog.models import BranchHours

    created = 0
    today = timezone.now().date()

    templates = SlotTemplate.objects.filter(
        tenant=tenant, is_active=True
    ).select_related("branch", "service")

    for tmpl in templates:
        branch = tmpl.branch
        for day_offset in range(days_ahead + 1):
            target_date = today + timedelta(days=day_offset)
            weekday = target_date.weekday()  # 0=Mon...6=Sun

            if weekday not in tmpl.active_weekdays:
                continue

            try:
                branch_hours = BranchHours.objects.get(branch=branch, weekday=weekday)
            except BranchHours.DoesNotExist:
                continue
            if branch_hours.is_closed:
                continue

            created += _generate_slots_for_day(
                tenant=tenant,
                template=tmpl,
                target_date=target_date,
                open_time=branch_hours.open_time,
                close_time=branch_hours.close_time,
            )

    return created


def _generate_slots_for_day(
    *,
    tenant: Tenant,
    template: SlotTemplate,
    target_date: date,
    open_time: time,
    close_time: time,
) -> int:
    """Generate time-sliced BookingSlots between open/close for a single day."""
    created = 0
    slot_delta = timedelta(minutes=template.slot_minutes)

    cursor = datetime.combine(target_date, open_time)
    end = datetime.combine(target_date, close_time)

    while cursor + slot_delta <= end:
        start_t = cursor.time()
        end_t = (cursor + slot_delta).time()

        _, was_created = BookingSlot.objects.get_or_create(
            tenant=tenant,
            branch=template.branch,
            service=template.service,
            date=target_date,
            start_time=start_t,
            defaults={
                "end_time": end_t,
                "capacity_total": template.capacity_per_slot,
                "capacity_left": template.capacity_per_slot,
                "is_active": True,
            },
        )
        if was_created:
            created += 1
        cursor += slot_delta

    return created


# ── Booking create ─────────────────────────────────────────────────────────────

@transaction.atomic
def create_booking(
    *,
    user,
    service_id: int,
    slot_id: int,
    vehicle_id: int | None = None,
    location_type: str = "branch",
    address_id: int | None = None,
    mobile_lat=None,
    mobile_lng=None,
    payment_method: str = "cash",
    idempotency_key: str = "",
) -> Booking:
    """
    Reserve a slot for a user.

    Concurrency: the slot row is locked with select_for_update().
    If capacity_left == 0 when we acquire the lock, raise ConflictError.
    """
    from apps.catalog.models import Service

    # Idempotency check
    if idempotency_key:
        existing = Booking.all_objects.filter(idempotency_key=idempotency_key).first()
        if existing:
            return existing

    service = Service.objects.filter(pk=service_id, tenant=user.tenant, is_active=True).first()
    if service is None:
        raise NotFoundError("Service not found.")

    slot = (
        BookingSlot.objects.select_for_update()
        .filter(pk=slot_id, tenant=user.tenant, is_active=True)
        .first()
    )
    if slot is None:
        raise NotFoundError("Slot not found.")
    if slot.capacity_left <= 0:
        raise ConflictError("This time slot is fully booked. Please choose another slot.")

    vehicle = None
    if vehicle_id:
        from apps.accounts.models import Vehicle
        vehicle = Vehicle.objects.filter(pk=vehicle_id, user=user).first()
        if vehicle is None:
            raise NotFoundError("Vehicle not found.")

    address = None
    if location_type == Booking.LocationType.MOBILE:
        if address_id:
            from apps.accounts.models import Address
            address = Address.objects.filter(pk=address_id, user=user).first()
        if address is None and not (mobile_lat and mobile_lng):
            raise ConflictError("Mobile bookings require an address or coordinates.")

    slot.capacity_left -= 1
    slot.save(update_fields=["capacity_left", "updated_at"])

    from apps.payments.models import Payment
    valid_methods = {choice for choice, _ in Payment.Method.choices}
    payment = Payment.objects.create(
        tenant=user.tenant,
        user=user,
        amount=service.base_price,
        currency=service.currency,
        method=payment_method if payment_method in valid_methods else Payment.Method.CASH,
        status=Payment.Status.PENDING,
    )

    booking = Booking.objects.create(
        tenant=user.tenant,
        user=user,
        service=service,
        branch=slot.branch,
        slot=slot,
        vehicle=vehicle,
        status=Booking.Status.CONFIRMED,
        location_type=location_type,
        address=address,
        mobile_lat=mobile_lat,
        mobile_lng=mobile_lng,
        payment=payment,
        price_charged=service.base_price,
        currency=service.currency,
        idempotency_key=idempotency_key,
        scheduled_date=slot.date,
        scheduled_start=slot.start_time,
    )

    logger.info("Booking created: id=%s user=%s slot=%s", booking.pk, user.pk, slot.pk)
    return booking


@transaction.atomic
def cancel_booking(*, user, booking_id: int, reason: str = "") -> Booking:
    """
    Cancel a booking and return the slot capacity.
    Only the booking owner or an admin can cancel.
    Non-cancellable statuses: completed, cancelled, no_show.
    """
    booking = (
        Booking.objects.select_for_update()
        .filter(pk=booking_id, tenant=user.tenant)
        .first()
    )
    if booking is None:
        raise NotFoundError("Booking not found.")

    if booking.user_id != user.pk and user.role != "admin":
        from apps.common.errors import PermissionError as AppPermErr
        raise AppPermErr("You do not have permission to cancel this booking.")

    terminal = {Booking.Status.COMPLETED, Booking.Status.CANCELLED, Booking.Status.NO_SHOW}
    if booking.status in terminal:
        raise ConflictError(f"Cannot cancel a booking with status '{booking.status}'.")

    slot = BookingSlot.objects.select_for_update().get(pk=booking.slot_id)
    slot.capacity_left = min(slot.capacity_left + 1, slot.capacity_total)
    slot.save(update_fields=["capacity_left", "updated_at"])

    booking.status = Booking.Status.CANCELLED
    booking.cancellation_reason = reason
    booking.cancelled_at = timezone.now()
    booking.save(update_fields=["status", "cancellation_reason", "cancelled_at", "updated_at"])

    return booking


@transaction.atomic
def reschedule_booking(*, user, booking_id: int, slot_id: int) -> Booking:
    """
    Move a booking to a different slot.
    Returns capacity to the old slot and claims it from the new one.
    Only confirmed/pending bookings can be rescheduled.
    """
    booking = (
        Booking.objects.select_for_update()
        .filter(pk=booking_id, tenant=user.tenant)
        .first()
    )
    if not booking:
        raise NotFoundError("Booking not found.")
    if booking.user_id != user.pk and user.role != "admin":
        from apps.common.errors import PermissionError as AppPermErr
        raise AppPermErr("Cannot reschedule another user's booking.")
    if booking.status not in (Booking.Status.PENDING, Booking.Status.CONFIRMED):
        raise ConflictError(f"Cannot reschedule a booking in status '{booking.status}'.")

    new_slot = BookingSlot.objects.select_for_update().filter(
        pk=slot_id, tenant=user.tenant, is_active=True
    ).first()
    if not new_slot:
        raise NotFoundError("Slot not found.")
    if new_slot.capacity_left <= 0:
        raise ConflictError("New slot is fully booked.")

    old_slot = BookingSlot.objects.select_for_update().get(pk=booking.slot_id)
    old_slot.capacity_left = min(old_slot.capacity_left + 1, old_slot.capacity_total)
    old_slot.save(update_fields=["capacity_left", "updated_at"])

    new_slot.capacity_left -= 1
    new_slot.save(update_fields=["capacity_left", "updated_at"])

    booking.slot = new_slot
    booking.branch = new_slot.branch
    booking.scheduled_date = new_slot.date
    booking.scheduled_start = new_slot.start_time
    booking.save(update_fields=["slot", "branch", "scheduled_date", "scheduled_start", "updated_at"])
    logger.info("Booking rescheduled: id=%s new_slot=%s", booking.pk, new_slot.pk)
    return booking


# ── Recurring rules ────────────────────────────────────────────────────────────

@transaction.atomic
def create_recurring_rule(
    *,
    user,
    service_id: int,
    branch_id: int | None,
    frequency: str,
    preferred_weekday: int,
    preferred_time,
    location_type: str = "branch",
    address_id: int | None = None,
    vehicle_id: int | None = None,
    default_payment_method: str = "wallet",
) -> RecurringBookingRule:
    from apps.catalog.models import Service
    service = Service.objects.filter(pk=service_id, tenant=user.tenant, is_active=True).first()
    if not service:
        raise NotFoundError("Service not found.")

    branch = None
    if branch_id:
        from apps.catalog.models import Branch
        branch = Branch.objects.filter(pk=branch_id, tenant=user.tenant, is_active=True).first()
        if not branch:
            raise NotFoundError("Branch not found.")

    return RecurringBookingRule.objects.create(
        tenant=user.tenant,
        user=user,
        service=service,
        branch=branch,
        frequency=frequency,
        preferred_weekday=preferred_weekday,
        preferred_time=preferred_time,
        location_type=location_type,
        address_id=address_id,
        vehicle_id=vehicle_id,
        default_payment_method=default_payment_method,
    )


def process_all_recurring_rules(*, lead_days: int = 7) -> dict:
    """
    Called nightly by Celery Beat.
    For each active RecurringBookingRule, create an upcoming Booking if one
    does not already exist within the lead window.
    """
    from apps.common.models import Tenant

    total_created = 0
    for tenant in Tenant.objects.filter(is_active=True):
        created = _process_tenant_recurring_rules(tenant=tenant, lead_days=lead_days)
        total_created += created
    return {"total_created": total_created}


def _process_tenant_recurring_rules(*, tenant, lead_days: int) -> int:
    created = 0
    today = timezone.now().date()
    horizon = today + timedelta(days=lead_days)

    rules = RecurringBookingRule.objects.filter(
        tenant=tenant, is_active=True
    ).select_related("user", "service", "branch", "address", "vehicle")

    for rule in rules:
        try:
            created += _process_rule(rule=rule, today=today, horizon=horizon)
        except Exception as exc:
            logger.exception("process_rule failed for rule %s: %s", rule.pk, exc)
    return created


def _process_rule(*, rule: RecurringBookingRule, today: date, horizon: date) -> int:
    """
    Determine the next occurrence date for this rule and create a Booking if needed.
    Returns 1 if a booking was created, 0 otherwise.
    """
    candidate = _next_weekday_date(from_date=today, weekday=rule.preferred_weekday)
    created = 0

    while candidate <= horizon:
        if rule.last_booking_date and candidate <= rule.last_booking_date:
            candidate = _advance_by_frequency(candidate, rule.frequency)
            continue

        slot = BookingSlot.objects.select_for_update().filter(
            tenant=rule.tenant,
            branch=rule.branch,
            date=candidate,
            start_time__lte=rule.preferred_time,
            is_active=True,
            capacity_left__gt=0,
        ).order_by("start_time").last()

        if slot is None:
            candidate = _advance_by_frequency(candidate, rule.frequency)
            continue

        exists = Booking.objects.filter(
            user=rule.user,
            service=rule.service,
            scheduled_date=candidate,
            status__in=["pending", "confirmed", "assigned"],
        ).exists()
        if exists:
            candidate = _advance_by_frequency(candidate, rule.frequency)
            continue

        try:
            _create_booking_from_rule(rule=rule, slot=slot, target_date=candidate)
            rule.last_booking_date = candidate
            rule.save(update_fields=["last_booking_date"])
            created += 1
        except Exception as exc:
            logger.warning("Auto-booking failed for rule %s date %s: %s", rule.pk, candidate, exc)

        candidate = _advance_by_frequency(candidate, rule.frequency)

    return created


def _create_booking_from_rule(*, rule: RecurringBookingRule, slot: BookingSlot, target_date) -> Booking:
    """Create a Booking from a RecurringBookingRule using wallet or cash payment."""
    from apps.payments.models import Payment

    slot.capacity_left -= 1
    slot.save(update_fields=["capacity_left", "updated_at"])

    payment_method = rule.default_payment_method
    payment_status = Payment.Status.PENDING

    if payment_method == "wallet":
        try:
            from apps.payments.services import deduct_wallet
            from apps.payments.models import WalletTransaction
            deduct_wallet(
                user=rule.user,
                amount=rule.service.base_price,
                reason=WalletTransaction.Reason.BOOKING_PAYMENT,
                reference=f"recurring-rule#{rule.pk}",
            )
            payment_status = Payment.Status.SUCCEEDED
        except Exception:
            payment_method = "cash"
            payment_status = Payment.Status.PENDING

    payment = Payment.objects.create(
        tenant=rule.tenant,
        user=rule.user,
        amount=rule.service.base_price,
        currency=rule.service.currency,
        method=payment_method,
        status=payment_status,
    )

    booking = Booking.objects.create(
        tenant=rule.tenant,
        user=rule.user,
        service=rule.service,
        branch=rule.branch or slot.branch,
        slot=slot,
        vehicle=rule.vehicle,
        status=Booking.Status.CONFIRMED if payment_status == Payment.Status.SUCCEEDED else Booking.Status.PENDING,
        location_type=rule.location_type,
        address=rule.address,
        payment=payment,
        price_charged=rule.service.base_price,
        currency=rule.service.currency,
        scheduled_date=slot.date,
        scheduled_start=slot.start_time,
    )
    logger.info("Auto-booking created from rule %s: booking=%s date=%s", rule.pk, booking.pk, target_date)
    return booking


def _next_weekday_date(*, from_date: date, weekday: int) -> date:
    """Return the next occurrence of `weekday` (0=Mon) on or after `from_date`."""
    days_ahead = weekday - from_date.weekday()
    if days_ahead < 0:
        days_ahead += 7
    return from_date + timedelta(days=days_ahead)


def _advance_by_frequency(d: date, frequency: str) -> date:
    if frequency == "weekly":
        return d + timedelta(weeks=1)
    elif frequency == "biweekly":
        return d + timedelta(weeks=2)
    else:  # monthly
        return d + timedelta(days=30)
