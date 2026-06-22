"""
Celery tenant-context helpers.

After the RLS NULL-bypass was removed in migration 0003, any Celery task
that queries tenant-scoped tables MUST set the app.current_tenant Postgres
session variable before issuing any SQL — otherwise zero rows are returned.

Usage (per-tenant fan-out pattern)
-----------------------------------
    from apps.common.celery_tenant import for_each_tenant, with_tenant_context

    # Option A — decorator: iterates all active tenants, calls your task once per tenant
    @shared_task
    @for_each_tenant
    def my_task(tenant_id: str):
        # All DB queries here see only this tenant's rows
        ...

    # Option B — context manager: set tenant context manually
    @shared_task
    def my_other_task(tenant_id: str):
        with with_tenant_context(tenant_id):
            ...

    # Option C — function call inside an already-open transaction
    from apps.common.celery_tenant import set_tenant_context
    set_tenant_context(str(tenant_id))   # must be inside transaction.atomic()

IMPORTANT
---------
* Use transaction-local set_config (is_local=TRUE) so the context is
  automatically cleared at transaction end — no risk of bleed between tasks.
* Each shared_task call in Celery runs inside its own DB connection; context
  set here cannot leak to concurrent tasks.
"""
from __future__ import annotations

import functools
import logging
from contextlib import contextmanager

from django.db import connection, transaction

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Low-level: set within an open transaction
# ---------------------------------------------------------------------------

def set_tenant_context(tenant_id: str) -> None:
    """
    Set app.current_tenant as a *transaction-local* Postgres variable.
    Must be called inside an active transaction (transaction.atomic()).
    The value is cleared automatically when the transaction commits/rolls back.
    """
    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT set_config('app.current_tenant', %s, TRUE)",
            [tenant_id],
        )


# ---------------------------------------------------------------------------
# Context manager: wraps a block in a transaction + sets tenant context
# ---------------------------------------------------------------------------

@contextmanager
def with_tenant_context(tenant_id: str):
    """
    Context manager that opens a transaction and sets the tenant context.

    Example::

        with with_tenant_context(str(tenant.id)):
            Booking.objects.filter(status='pending').count()
    """
    with transaction.atomic():
        set_tenant_context(str(tenant_id))
        yield


# ---------------------------------------------------------------------------
# Decorator: fan-out — calls the decorated task once per active tenant
# ---------------------------------------------------------------------------

def for_each_tenant(func):
    """
    Decorator for Celery tasks that should run once per active tenant.

    The decorated task receives ``tenant_id: str`` as its first argument
    and runs inside a transaction with the tenant context already set.

    Example::

        @shared_task
        @for_each_tenant
        def send_reminders(tenant_id: str):
            Booking.objects.filter(...).update(...)
    """
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        from apps.common.models import Tenant  # avoid circular import at module load

        tenants = Tenant.objects.filter(is_active=True).values_list("id", flat=True)
        results = []
        for tenant_id in tenants:
            try:
                with with_tenant_context(str(tenant_id)):
                    result = func(str(tenant_id), *args, **kwargs)
                    results.append({"tenant_id": str(tenant_id), "result": result})
            except Exception as exc:
                logger.exception(
                    "Task %s failed for tenant %s: %s",
                    func.__name__,
                    tenant_id,
                    exc,
                )
                results.append({"tenant_id": str(tenant_id), "error": str(exc)})
        return results

    return wrapper
