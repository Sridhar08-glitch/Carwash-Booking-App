"""
Geo models.

ServiceArea — polygon (JSON lat/lng array) defining coverage zones per branch.
When GEO_ENABLED=False, PostGIS is off; we use Haversine distance checks instead.
When GEO_ENABLED=True, use PostGIS PolygonField and .contains() for accuracy.
"""
from __future__ import annotations

import math
from typing import List, Tuple

from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class ServiceArea(TenantScopedModel):
    """
    Coverage polygon for a branch.

    Without PostGIS: stored as a JSON array of [lat, lng] pairs.
    Containment is checked via the ray-casting algorithm (Haversine fallback).

    With PostGIS (GEO_ENABLED=True): use PolygonField for DB-level spatial queries.
    Switch the field below when upgrading.
    """

    branch = models.ForeignKey("catalog.Branch", on_delete=models.CASCADE, related_name="service_areas")
    name = models.CharField(max_length=100, blank=True)
    # JSON polygon — list of [lat, lng] pairs forming a closed polygon
    polygon_coords = models.JSONField(
        default=list,
        help_text="List of [lat, lng] coordinate pairs forming a closed polygon."
    )
    # Radius fallback (km) — used when polygon_coords is empty
    radius_km = models.DecimalField(max_digits=6, decimal_places=2, default=10)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = "geo_service_area"

    def __str__(self) -> str:
        return f"ServiceArea({self.branch_id}, radius={self.radius_km}km)"

    def contains_point(self, lat: float, lng: float) -> bool:
        """
        Return True if (lat, lng) falls inside this service area.
        Uses ray-casting if polygon_coords is set, otherwise radius check.
        """
        if self.polygon_coords and len(self.polygon_coords) >= 3:
            return _ray_cast(lat, lng, self.polygon_coords)
        # Radius fallback
        branch_lat = float(self.branch.lat)
        branch_lng = float(self.branch.lng)
        dist = _haversine_km(branch_lat, branch_lng, lat, lng)
        return dist <= float(self.radius_km)


# ── Geo helpers ────────────────────────────────────────────────────────────────

def _haversine_km(lat1: float, lng1: float, lat2: float, lng2: float) -> float:
    """Great-circle distance in kilometres between two points."""
    R = 6371.0
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    d_phi = math.radians(lat2 - lat1)
    d_lambda = math.radians(lng2 - lng1)
    a = math.sin(d_phi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(d_lambda / 2) ** 2
    return R * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def _ray_cast(lat: float, lng: float, polygon: list) -> bool:
    """Point-in-polygon ray casting algorithm."""
    n = len(polygon)
    inside = False
    j = n - 1
    for i in range(n):
        xi, yi = polygon[i][1], polygon[i][0]  # lng, lat
        xj, yj = polygon[j][1], polygon[j][0]
        if ((yi > lat) != (yj > lat)) and (lng < (xj - xi) * (lat - yi) / (yj - yi) + xi):
            inside = not inside
        j = i
    return inside
