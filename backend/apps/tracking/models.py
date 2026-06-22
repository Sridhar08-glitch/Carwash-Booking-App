"""
Tracking models.

TrackingPing — GPS coordinate emitted by the staff app during a mobile job.
Stored for audit / replay; live updates broadcast over WebSocket.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class TrackingPing(TenantScopedModel):
    """
    A single GPS ping from a staff device during an active booking.

    Staff app pushes pings via WebSocket → consumer stores + broadcasts to
    the booking channel `booking_<booking_id>` so customers see live ETA.
    """

    booking = models.ForeignKey(
        "scheduling.Booking",
        on_delete=models.CASCADE,
        related_name="tracking_pings",
    )
    staff = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        related_name="tracking_pings",
    )
    lat = models.DecimalField(max_digits=9, decimal_places=6)
    lng = models.DecimalField(max_digits=9, decimal_places=6)
    accuracy_m = models.FloatField(null=True, blank=True)  # GPS accuracy radius in metres
    recorded_at = models.DateTimeField(db_index=True)

    class Meta:
        db_table = "tracking_ping"
        ordering = ["-recorded_at"]
        indexes = [
            models.Index(fields=["booking", "recorded_at"]),
        ]

    def __str__(self) -> str:
        return f"TrackingPing(booking={self.booking_id}, {self.lat},{self.lng})"
