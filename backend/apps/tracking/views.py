"""
Tracking HTTP views.

TrackView  GET /api/v1/track/<booking_id>/ — last known position for a booking.
"""
from drf_spectacular.utils import extend_schema
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError

from .models import TrackingPing


class TrackView(APIView):
    """
    GET /api/v1/track/<booking_id>/

    Returns the most recent TrackingPing for a booking,
    so the customer app can show "last known position" even without WebSockets.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: {"type": "object", "properties": {
            "booking_id": {"type": "integer"},
            "lat": {"type": "string"},
            "lng": {"type": "string"},
            "recorded_at": {"type": "string"},
            "booking_status": {"type": "string"},
        }}},
        tags=["tracking"],
        summary="Get last known staff position for a booking",
    )
    def get(self, request: Request, booking_id: int) -> Response:
        from apps.scheduling.models import Booking
        from django.db.models import Q

        # select_related fetches user + assigned_staff in the same query,
        # preventing N+1 if this path is ever called in a loop.
        booking = (
            Booking.objects
            .select_related("user", "assigned_staff", "slot")
            .filter(pk=booking_id)
            .filter(Q(user=request.user) | Q(assigned_staff=request.user))
            .first()
        )
        if not booking:
            raise NotFoundError("Booking not found or access denied.")

        ping = TrackingPing.objects.filter(booking=booking).order_by("-recorded_at").first()
        if not ping:
            return Response({
                "booking_id": booking_id,
                "lat": None,
                "lng": None,
                "recorded_at": None,
                "booking_status": booking.status,
            })

        return Response({
            "booking_id": booking_id,
            "lat": str(ping.lat),
            "lng": str(ping.lng),
            "recorded_at": ping.recorded_at.isoformat(),
            "booking_status": booking.status,
        })
