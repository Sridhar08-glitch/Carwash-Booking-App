"""
Common views.

/healthz   — liveness probe (always 200 if Django is running)
/readyz    — readiness probe (checks DB + Redis)
/api/v1/home/layout — ordered list of home screen sections for the mobile app
"""
import json

from django.conf import settings
from django.core.cache import cache
from django.db import connection
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response


@api_view(["GET"])
@permission_classes([AllowAny])
def health_check(request: Request) -> Response:
    """Liveness: 200 if the process is alive."""
    return Response({"status": "ok"})


@api_view(["GET"])
@permission_classes([AllowAny])
def readiness_check(request: Request) -> Response:
    """
    Readiness: checks DB and Redis.
    Returns 200 with a detailed status dict; 503 if any dependency is down.
    """
    checks: dict[str, str] = {}
    ok = True

    # ── Database ─────────────────────────────────────────────────────────────
    try:
        connection.ensure_connection()
        checks["database"] = "ok"
    except Exception as exc:
        checks["database"] = f"error: {exc}"
        ok = False

    # ── Redis / Cache ─────────────────────────────────────────────────────────
    try:
        cache.set("readyz_probe", "1", timeout=5)
        assert cache.get("readyz_probe") == "1"
        checks["cache"] = "ok"
    except Exception as exc:
        checks["cache"] = f"error: {exc}"
        ok = False

    http_status = 200 if ok else 503
    return Response({"status": "ok" if ok else "degraded", "checks": checks}, status=http_status)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def home_layout(request: Request) -> Response:
    """
    Return an ordered list of home-screen sections for the mobile app.

    Shape
    -----
    [
      {"type": "hero_banner",  "title": "...", "cta": "...", "image": null},
      {"type": "offer_strip",  "text": "..."},
      {"type": "service_rail", "title": "...", "source": "services"},
      {"type": "product_rail", "title": "...", "source": "featured_products"},
    ]

    The layout is managed via PUT /api/v1/admin-api/home-layout (stored in Redis
    with no TTL). Falls back to a sensible default if no admin layout has been set.
    Cache key is per-tenant so multi-tenant deployments stay isolated.
    """
    from apps.common.admin_views import _default_layout

    tenant_id = getattr(request.user, "tenant_id", None)
    # Same key as admin_views.HomeLayoutView so PUT/GET are consistent
    cache_key = f"home_layout_{tenant_id}"
    data = cache.get(cache_key)
    if data is None:
        data = _default_layout()
    return Response(data)
