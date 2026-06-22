"""
Celery tasks for the scheduling app.

generate_booking_slots  -- nightly; materialise slots N days ahead.
process_recurring_rules -- nightly; auto-create bookings from RecurringBookingRules.
"""
import logging

from celery import shared_task

logger = logging.getLogger(__name__)


@shared_task(name="scheduling.generate_booking_slots", bind=True, max_retries=3)
def generate_booking_slots(self, days_ahead: int = 14):
    """Nightly: generate BookingSlots from SlotTemplates for all active tenants."""
    from apps.common.models import Tenant
    from apps.scheduling.services import generate_slots_for_tenant

    total = 0
    for tenant in Tenant.objects.filter(is_active=True):
        try:
            n = generate_slots_for_tenant(tenant=tenant, days_ahead=days_ahead)
            total += n
            logger.info("generate_booking_slots: tenant=%s created=%s", tenant.slug, n)
        except Exception as exc:
            logger.exception("generate_booking_slots failed for tenant %s: %s", tenant.slug, exc)
    return {"total_created": total}


@shared_task(name="scheduling.process_recurring_rules", bind=True, max_retries=3)
def process_recurring_rules(self, lead_days: int = 7):
    """
    Nightly: scan all active RecurringBookingRules and auto-create upcoming
    bookings within the lead window.
    Idempotent -- safe to re-run.
    """
    from apps.scheduling.services import process_all_recurring_rules

    try:
        result = process_all_recurring_rules(lead_days=lead_days)
        logger.info("process_recurring_rules: %s", result)
        return result
    except Exception as exc:
        logger.exception("process_recurring_rules failed: %s", exc)
        raise self.retry(exc=exc, countdown=300)
