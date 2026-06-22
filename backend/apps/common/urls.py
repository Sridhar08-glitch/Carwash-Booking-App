from django.urls import path

from apps.common.admin_views import (
    AdminBookingListView,
    AdminInventoryView,
    AdminOrderStatusView,
    AdminPromoDetailView,
    AdminPromoListCreateView,
    HomeLayoutView,
)
from apps.common.views import home_layout

urlpatterns = [
    # ── Customer / staff facing ───────────────────────────────────────────────
    path("home/layout", home_layout, name="home-layout"),

    # ── Admin-API ─────────────────────────────────────────────────────────────
    # Home layout (admin read + write via cache)
    path("admin-api/home-layout", HomeLayoutView.as_view(), name="admin-home-layout"),

    # Promo codes
    path("admin-api/promos", AdminPromoListCreateView.as_view(), name="admin-promo-list"),
    path("admin-api/promos/<int:pk>", AdminPromoDetailView.as_view(), name="admin-promo-detail"),

    # Inventory (stock adjustments)
    path("admin-api/inventory/<int:pk>", AdminInventoryView.as_view(), name="admin-inventory"),

    # Booking management (admin overview — assignment is in staff/urls.py)
    path("admin-api/bookings", AdminBookingListView.as_view(), name="admin-booking-list"),

    # Order status management
    path("admin-api/orders/<int:pk>/status", AdminOrderStatusView.as_view(), name="admin-order-status"),
]
