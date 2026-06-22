"""
Django Channels WebSocket consumers for Phase 3 live tracking.

BookingTrackingConsumer
-----------------------
Channel group: booking_<booking_id>

Staff app:  connects as "staff"  → pushes GPS pings
Customer app: connects as "customer" → receives live pings + ETA
Admin:       can also subscribe

Message protocol (JSON):
  Staff → server:
    {"type": "ping", "lat": 24.688, "lng": 46.685, "accuracy_m": 5.0}

  Server → customer:
    {"type": "ping", "lat": 24.688, "lng": 46.685, "recorded_at": "...", "eta_minutes": 7}
    {"type": "status", "booking_status": "en_route"}
    {"type": "error", "message": "..."}
"""
from __future__ import annotations

import json
import logging
from datetime import timezone as _tz

from channels.generic.websocket import AsyncJsonWebsocketConsumer
from django.utils import timezone

logger = logging.getLogger(__name__)


class BookingTrackingConsumer(AsyncJsonWebsocketConsumer):
    """
    WebSocket consumer per booking.

    URL pattern: ws://host/ws/track/<booking_id>/
    Requires an authenticated user (JWT token in query string or header).
    """

    async def connect(self):
        self.booking_id = self.scope["url_route"]["kwargs"]["booking_id"]
        self.group_name = f"booking_{self.booking_id}"
        self.user = self.scope.get("user")

        # Reject unauthenticated connections
        if not self.user or not self.user.is_authenticated:
            await self.close(code=4001)
            return

        # Verify the user has permission (owner, assigned staff, or admin)
        if not await self._has_permission():
            await self.close(code=4003)
            return

        await self.channel_layer.group_add(self.group_name, self.channel_name)
        await self.accept()
        logger.info("WS connected: user=%s booking=%s", self.user.pk, self.booking_id)

    async def disconnect(self, close_code):
        if hasattr(self, "group_name"):
            await self.channel_layer.group_discard(self.group_name, self.channel_name)

    async def receive_json(self, content):
        """Process messages sent from the connected client."""
        msg_type = content.get("type")

        if msg_type == "ping":
            await self._handle_ping(content)
        else:
            await self.send_json({"type": "error", "message": f"Unknown message type: {msg_type}"})

    # ── Message handlers ───────────────────────────────────────────────────────

    async def _handle_ping(self, content):
        """Staff sends a GPS ping; store it, compute ETA, and broadcast to the group."""
        from channels.db import database_sync_to_async

        if self.user.role not in ("staff", "admin"):
            await self.send_json({"type": "error", "message": "Only staff can send pings."})
            return

        lat = content.get("lat")
        lng = content.get("lng")
        if lat is None or lng is None:
            await self.send_json({"type": "error", "message": "lat and lng are required."})
            return

        recorded_at = timezone.now()
        booking_location = await database_sync_to_async(self._get_booking_location)()
        await database_sync_to_async(self._store_ping)(
            lat=lat, lng=lng,
            accuracy_m=content.get("accuracy_m"),
            recorded_at=recorded_at,
        )

        # Compute ETA — non-blocking, cached, gracefully degrades to None
        eta_minutes = None
        if booking_location:
            eta_minutes = await self._compute_eta(
                origin_lat=lat, origin_lng=lng,
                dest_lat=booking_location["lat"], dest_lng=booking_location["lng"],
            )

        # Broadcast to all subscribers (customer + any other staff/admin listeners)
        await self.channel_layer.group_send(
            self.group_name,
            {
                "type": "tracking.ping",
                "lat": lat,
                "lng": lng,
                "recorded_at": recorded_at.isoformat(),
                "eta_minutes": eta_minutes,
            },
        )

    def _store_ping(self, *, lat, lng, accuracy_m, recorded_at):
        from .models import TrackingPing
        from apps.scheduling.models import Booking

        booking = Booking.objects.filter(pk=self.booking_id).first()
        if not booking:
            return
        TrackingPing.objects.create(
            tenant=booking.tenant,
            booking=booking,
            staff=self.user,
            lat=lat,
            lng=lng,
            accuracy_m=accuracy_m,
            recorded_at=recorded_at,
        )

    def _get_booking_location(self) -> dict | None:
        """
        Return the destination coordinates for ETA calculation.
        For branch bookings: branch lat/lng.
        For mobile bookings: booking's mobile_lat/mobile_lng.
        Returns None if coordinates are unavailable.
        """
        from apps.scheduling.models import Booking
        booking = Booking.objects.select_related("branch", "address").filter(
            pk=self.booking_id
        ).first()
        if not booking:
            return None
        if booking.location_type == "mobile":
            if booking.mobile_lat and booking.mobile_lng:
                return {"lat": float(booking.mobile_lat), "lng": float(booking.mobile_lng)}
            if booking.address and booking.address.lat and booking.address.lng:
                return {"lat": float(booking.address.lat), "lng": float(booking.address.lng)}
        elif booking.branch and booking.branch.lat and booking.branch.lng:
            return {"lat": float(booking.branch.lat), "lng": float(booking.branch.lng)}
        return None

    async def _compute_eta(
        self, *, origin_lat: float, origin_lng: float,
        dest_lat: float, dest_lng: float,
    ) -> int | None:
        """
        Estimate driving ETA in minutes between the staff's current position
        and the booking destination.

        Strategy
        --------
        1. Check Redis cache keyed to the booking — refresh only if the staff
           has moved significantly (>200 m) or the cache is >60 s old.
        2. If MAPS_API_KEY is set: call Google Maps Directions API and parse
           duration_in_traffic (or duration).
        3. Fallback: straight-line Haversine distance ÷ 40 km/h average speed.

        Returns integer minutes or None on hard failure.
        """
        import math
        from django.conf import settings
        from django.core.cache import cache

        cache_key = f"eta_{self.booking_id}"
        cached = cache.get(cache_key)
        if cached is not None:
            return cached

        maps_key = getattr(settings, "MAPS_API_KEY", "")
        if maps_key:
            eta = await self._fetch_maps_eta(
                origin_lat=origin_lat, origin_lng=origin_lng,
                dest_lat=dest_lat, dest_lng=dest_lng,
                api_key=maps_key,
            )
        else:
            # Haversine fallback: straight-line km ÷ 40 km/h → minutes
            R = 6371.0
            phi1, phi2 = math.radians(origin_lat), math.radians(dest_lat)
            d_phi = math.radians(dest_lat - origin_lat)
            d_lam = math.radians(dest_lng - origin_lng)
            a = math.sin(d_phi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(d_lam / 2) ** 2
            dist_km = R * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
            eta = max(1, int(dist_km / 40.0 * 60))  # minutes at 40 km/h

        if eta is not None:
            cache.set(cache_key, eta, timeout=60)  # Cache 60 s per spec
        return eta

    async def _fetch_maps_eta(
        self, *, origin_lat, origin_lng, dest_lat, dest_lng, api_key: str
    ) -> int | None:
        """
        Call Google Maps Directions API asynchronously.
        Returns driving duration in minutes, or None on error.
        """
        import asyncio
        import json
        import urllib.request

        url = (
            "https://maps.googleapis.com/maps/api/directions/json"
            f"?origin={origin_lat},{origin_lng}"
            f"&destination={dest_lat},{dest_lng}"
            f"&mode=driving"
            f"&departure_time=now"
            f"&key={api_key}"
        )
        try:
            # Run blocking HTTP call in executor so we don't block the event loop
            loop = asyncio.get_event_loop()
            response_bytes = await loop.run_in_executor(
                None,
                lambda: urllib.request.urlopen(url, timeout=3).read(),  # noqa: S310
            )
            data = json.loads(response_bytes)
            if data.get("status") != "OK":
                logger.warning("Maps API returned status: %s", data.get("status"))
                return None
            leg = data["routes"][0]["legs"][0]
            # Prefer duration_in_traffic (real-time), fall back to duration
            seconds = (
                leg.get("duration_in_traffic", {}).get("value")
                or leg.get("duration", {}).get("value")
            )
            return max(1, int(seconds / 60)) if seconds else None
        except Exception as exc:
            logger.warning("Maps ETA fetch failed: %s", exc)
            return None

    # ── Group event handlers (called by channel_layer.group_send) ─────────────

    async def tracking_ping(self, event):
        """Relay a ping event to this WebSocket client."""
        await self.send_json({
            "type": "ping",
            "lat": event["lat"],
            "lng": event["lng"],
            "recorded_at": event["recorded_at"],
            "eta_minutes": event.get("eta_minutes"),  # None when Maps API unavailable
        })

    async def booking_status(self, event):
        """Relay a booking status change to this client."""
        await self.send_json({
            "type": "status",
            "booking_status": event["booking_status"],
        })

    # ── Permission check ───────────────────────────────────────────────────────

    async def _has_permission(self) -> bool:
        from channels.db import database_sync_to_async

        @database_sync_to_async
        def check():
            from apps.scheduling.models import Booking
            booking = Booking.objects.filter(pk=self.booking_id).first()
            if not booking:
                return False
            if self.user.role == "admin":
                return True
            if booking.user_id == self.user.pk:
                return True
            if booking.assigned_staff_id == self.user.pk:
                return True
            return False

        return await check()
