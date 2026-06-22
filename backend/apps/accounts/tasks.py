"""
Celery tasks for the accounts app.

cleanup_expired_otps  — hard-delete OTPCode rows that are expired or used,
                        keeping the table lean and preventing index bloat.
"""
from __future__ import annotations

import logging
from datetime import timedelta

from celery import shared_task
from django.utils import timezone

logger = logging.getLogger(__name__)


@shared_task(name="accounts.cleanup_expired_otps", bind=True, max_retries=3)
def cleanup_expired_otps(self):
    """
    Hard-delete OTPCode rows that are either:
      - already used (single-use, no longer needed), or
      - past their expiry time (stale, can never be verified).

    Run weekly (see CELERY_BEAT_SCHEDULE in base.py).

    OTPCodes are never soft-deleted — they have no tenant_id FK and are
    not subject to RLS, so a plain .delete() is safe here.

    Returns the count of deleted rows for logging/monitoring.
    """
    from .models import OTPCode

    cutoff = timezone.now()

    deleted_used, _ = OTPCode.objects.filter(used=True).delete()
    deleted_expired, _ = OTPCode.objects.filter(expires_at__lt=cutoff).delete()

    total = deleted_used + deleted_expired
    logger.info(
        "OTP cleanup: deleted %s used + %s expired = %s total rows",
        deleted_used,
        deleted_expired,
        total,
    )
    return {"deleted_used": deleted_used, "deleted_expired": deleted_expired, "total": total}
