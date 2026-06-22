"""
Geo selectors — spatial queries without PostGIS (Haversine fallback).
"""
from __future__ import annotations

import math
from typing import Optional

from .models import ServiceArea, _haversine_km


def point_in_service_area(*, tenant_id, lat: float, lng: float) -> bool:
    """Return True if (lat, lng) is within any active service area for this tenant."""
    areas = ServiceArea.objects.filter(tenant_id=tenant_id, is_active=True).select_related("branch")
    return any(area.contains_point(lat, lng) for area in areas)


def nearest_branch(*, tenant_id, lat: float, lng: float):
    """Return the nearest active Branch to (lat, lng), or None if no branches."""
    from apps.catalog.models import Branch

    branches = Branch.objects.filter(tenant_id=tenant_id, is_active=True)
    if not branches.exists():
        return None

    return min(
        branches,
        key=lambda b: _haversine_km(float(b.lat), float(b.lng), lat, lng),
    )


def distance_km_to_branch(*, branch, lat: float, lng: float) -> float:
    """Return Haversine distance in km between a point and a branch."""
    return _haversine_km(float(branch.lat), float(branch.lng), lat, lng)
