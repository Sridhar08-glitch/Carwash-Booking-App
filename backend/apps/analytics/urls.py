from django.urls import path

from .views import (
    BookingStatsView,
    DashboardView,
    LowStockView,
    RevenueByDayView,
    StaffPerformanceView,
    TopServicesView,
)

urlpatterns = [
    path("admin-api/analytics/dashboard", DashboardView.as_view(), name="analytics-dashboard"),
    path("admin-api/analytics/revenue-by-day", RevenueByDayView.as_view(), name="analytics-revenue"),
    path("admin-api/analytics/bookings", BookingStatsView.as_view(), name="analytics-bookings"),
    path("admin-api/analytics/top-services", TopServicesView.as_view(), name="analytics-top-services"),
    path("admin-api/analytics/low-stock", LowStockView.as_view(), name="analytics-low-stock"),
    path("admin-api/analytics/staff", StaffPerformanceView.as_view(), name="analytics-staff"),
]
