"""Read-only queries for the catalog app."""
from __future__ import annotations

import math

from django.db.models import Prefetch, QuerySet

from .models import Branch, BranchHours, Service, ServiceCategory


def get_active_services(*, tenant_id, category: str | None = None) -> QuerySet:
    """`category` accepts either a slug or a numeric category id."""
    qs = (
        Service.objects.filter(tenant_id=tenant_id, is_active=True)
        .select_related("category")
        .order_by("category__ordering", "name")
    )
    if category:
        if str(category).isdigit():
            qs = qs.filter(category_id=int(category))
        else:
            qs = qs.filter(category__slug=category)
    return qs


def get_service_by_id(*, tenant_id, service_id: int) -> Service | None:
    return Service.objects.filter(tenant_id=tenant_id, pk=service_id, is_active=True).first()


def get_active_branches(*, tenant_id) -> QuerySet:
    return (
        Branch.objects.filter(tenant_id=tenant_id, is_active=True)
        .prefetch_related(
            Prefetch("hours", queryset=BranchHours.objects.order_by("weekday"))
        )
        .order_by("name")
    )


def get_branch_by_id(*, tenant_id, branch_id: int) -> Branch | None:
    return Branch.objects.filter(tenant_id=tenant_id, pk=branch_id, is_active=True).first()


def nearest_branch(*, tenant_id, lat: float, lng: float) -> Branch | None:
    """
    Return the nearest active branch using the Haversine formula.
    GEO_ENABLED=False version (no PostGIS required).
    """
    branches = Branch.objects.filter(tenant_id=tenant_id, is_active=True).exclude(
        lat=None, lng=None
    )
    if not branches:
        return None

    def haversine(b: Branch) -> float:
        R = 6371  # km
        lat1, lon1 = math.radians(float(lat)), math.radians(float(lng))
        lat2, lon2 = math.radians(float(b.lat)), math.radians(float(b.lng))
        dlat = lat2 - lat1
        dlon = lon2 - lon1
        a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
        return R * 2 * math.asin(math.sqrt(a))

    return min(branches, key=haversine)


def get_service_categories(*, tenant_id) -> QuerySet:
    return ServiceCategory.objects.filter(tenant_id=tenant_id, is_active=True).order_by("ordering", "name")
