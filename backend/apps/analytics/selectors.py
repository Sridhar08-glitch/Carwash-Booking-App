"""
Analytics selectors — read-only aggregation queries for the dashboard.

All functions accept tenant_id + a date range; return plain dicts or querysets.
None of these modify data.
"""
from __future__ import annotations

from datetime import date, timedelta
from decimal import Decimal

from django.db.models import Avg, Count, F, Q, Sum
from django.db.models.functions import TruncDate, TruncMonth
from django.utils import timezone


def revenue_summary(*, tenant_id, days: int = 30) -> dict:
    """Gross revenue, booking count, order count for the last N days."""
    from apps.payments.models import Payment

    since = timezone.now() - timedelta(days=days)
    qs = Payment.objects.filter(
        tenant_id=tenant_id,
        status="succeeded",
        created_at__gte=since,
    )
    agg = qs.aggregate(total=Sum("amount"), count=Count("id"))
    return {
        "total_revenue": agg["total"] or Decimal("0"),
        "payment_count": agg["count"] or 0,
        "period_days": days,
    }


def revenue_by_day(*, tenant_id, days: int = 30) -> list:
    """Daily revenue breakdown."""
    from apps.payments.models import Payment

    since = timezone.now() - timedelta(days=days)
    return list(
        Payment.objects.filter(tenant_id=tenant_id, status="succeeded", created_at__gte=since)
        .annotate(day=TruncDate("created_at"))
        .values("day")
        .annotate(revenue=Sum("amount"), count=Count("id"))
        .order_by("day")
    )


def booking_stats(*, tenant_id, days: int = 30) -> dict:
    """Booking counts by status for the period."""
    from apps.scheduling.models import Booking

    since = timezone.now() - timedelta(days=days)
    qs = Booking.objects.filter(tenant_id=tenant_id, created_at__gte=since)
    by_status = dict(qs.values_list("status").annotate(c=Count("id")))
    return {
        "total": qs.count(),
        "by_status": by_status,
        "completion_rate": round(
            by_status.get("completed", 0) / max(qs.count(), 1) * 100, 1
        ),
    }


def top_services(*, tenant_id, days: int = 30, limit: int = 10) -> list:
    """Most booked services with revenue."""
    from apps.scheduling.models import Booking

    since = timezone.now() - timedelta(days=days)
    return list(
        Booking.objects.filter(
            tenant_id=tenant_id,
            status="completed",
            created_at__gte=since,
        )
        .values("service__id", "service__name")
        .annotate(
            booking_count=Count("id"),
            total_revenue=Sum("price_charged"),
        )
        .order_by("-booking_count")[:limit]
    )


def low_stock_products(*, tenant_id) -> list:
    """Products where stock <= low_stock_threshold and track_inventory=True."""
    from apps.shop.models import Product

    return list(
        Product.objects.filter(
            tenant_id=tenant_id,
            is_active=True,
            track_inventory=True,
        )
        .filter(stock__lte=F("low_stock_threshold"))
        .values("id", "name", "sku", "stock", "low_stock_threshold")
        .order_by("stock")
    )


def staff_performance(*, tenant_id, days: int = 30) -> list:
    """Per-staff: jobs completed, avg completion time in minutes."""
    from apps.staff.models import JobAssignment

    since = timezone.now() - timedelta(days=days)
    return list(
        JobAssignment.objects.filter(
            tenant_id=tenant_id,
            status="completed",
            created_at__gte=since,
        )
        .values("staff__id", "staff__phone")
        .annotate(
            jobs_completed=Count("id"),
        )
        .order_by("-jobs_completed")
    )


def orders_summary(*, tenant_id, days: int = 30) -> dict:
    """Shop order counts and revenue."""
    from apps.shop.models import Order

    since = timezone.now() - timedelta(days=days)
    qs = Order.objects.filter(tenant_id=tenant_id, created_at__gte=since)
    paid = qs.filter(status="paid")
    agg = paid.aggregate(revenue=Sum("total"), count=Count("id"))
    return {
        "total_orders": qs.count(),
        "paid_orders": agg["count"] or 0,
        "shop_revenue": agg["revenue"] or Decimal("0"),
    }
