from django.urls import path

from .views import (
    BookingCancelView,
    BookingDetailView,
    BookingListCreateView,
    BookingRescheduleView,
    RecurringRuleDetailView,
    RecurringRuleListCreateView,
    SlotListView,
)

urlpatterns = [
    path("slots", SlotListView.as_view(), name="slot-list"),
    path("bookings", BookingListCreateView.as_view(), name="booking-list-create"),
    path("bookings/<int:pk>", BookingDetailView.as_view(), name="booking-detail"),
    path("bookings/<int:pk>/cancel", BookingCancelView.as_view(), name="booking-cancel"),
    path("bookings/<int:pk>/reschedule", BookingRescheduleView.as_view(), name="booking-reschedule"),
    path("recurring/", RecurringRuleListCreateView.as_view(), name="recurring-list-create"),
    path("recurring/<int:pk>", RecurringRuleDetailView.as_view(), name="recurring-detail"),
]
