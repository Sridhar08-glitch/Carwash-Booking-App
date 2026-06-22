"""
Analytics dashboard API — admin-only.

DashboardView        GET /api/v1/admin-api/analytics/dashboard
RevenueByDayView     GET /api/v1/admin-api/analytics/revenue-by-day
BookingStatsView     GET /api/v1/admin-api/analytics/bookings
TopServicesView      GET /api/v1/admin-api/analytics/top-services
LowStockView         GET /api/v1/admin-api/analytics/low-stock
StaffPerformanceView GET /api/v1/admin-api/analytics/staff
"""
from drf_spectacular.utils import OpenApiParameter, extend_schema
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.permissions import IsAdmin

from .selectors import (
    booking_stats,
    low_stock_products,
    orders_summary,
    revenue_by_day,
    revenue_summary,
    staff_performance,
    top_services,
)


class DashboardView(APIView):
    """GET /api/v1/admin-api/analytics/dashboard — full summary in one call."""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(
        parameters=[OpenApiParameter("days", int, description="Lookback window in days (default 30)")],
        tags=["analytics"],
        summary="[Admin] Full dashboard summary",
    )
    def get(self, request: Request) -> Response:
        days = int(request.query_params.get("days", 30))
        tid = request.user.tenant_id
        return Response({
            "revenue": revenue_summary(tenant_id=tid, days=days),
            "bookings": booking_stats(tenant_id=tid, days=days),
            "orders": orders_summary(tenant_id=tid, days=days),
            "top_services": top_services(tenant_id=tid, days=days, limit=5),
            "low_stock": low_stock_products(tenant_id=tid),
        })


class RevenueByDayView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(
        parameters=[OpenApiParameter("days", int)],
        tags=["analytics"],
        summary="[Admin] Daily revenue breakdown",
    )
    def get(self, request: Request) -> Response:
        days = int(request.query_params.get("days", 30))
        return Response(revenue_by_day(tenant_id=request.user.tenant_id, days=days))


class BookingStatsView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["analytics"], summary="[Admin] Booking stats by status")
    def get(self, request: Request) -> Response:
        days = int(request.query_params.get("days", 30))
        return Response(booking_stats(tenant_id=request.user.tenant_id, days=days))


class TopServicesView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["analytics"], summary="[Admin] Top services by booking count")
    def get(self, request: Request) -> Response:
        days = int(request.query_params.get("days", 30))
        limit = int(request.query_params.get("limit", 10))
        return Response(top_services(tenant_id=request.user.tenant_id, days=days, limit=limit))


class LowStockView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["analytics"], summary="[Admin] Low stock product alerts")
    def get(self, request: Request) -> Response:
        return Response(low_stock_products(tenant_id=request.user.tenant_id))


class StaffPerformanceView(APIView):
    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["analytics"], summary="[Admin] Staff performance summary")
    def get(self, request: Request) -> Response:
        days = int(request.query_params.get("days", 30))
        return Response(staff_performance(tenant_id=request.user.tenant_id, days=days))
