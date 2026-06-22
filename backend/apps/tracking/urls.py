from django.urls import path

from .views import TrackView

urlpatterns = [
    path("track/<int:booking_id>/", TrackView.as_view(), name="track"),
]
