"""
Admin API views — /api/v1/admin-api/

Promo management, inventory, home layout, booking/order management.
All endpoints require role=admin.
"""
from __future__ import annotations

from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError
from apps.common.permissions import IsAdmin


# ── Promo codes ────────────────────────────────────────────────────────────────

class AdminPromoListCreateView(APIView):
    """GET/POST /api/v1/admin-api/promos"""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["admin"], summary="[Admin] List promo codes")
    def get(self, request: Request) -> Response:
        from apps.payments.models import PromoCode
        from apps.payments.serializers import PromoCodeSerializer
        qs = PromoCode.objects.filter(tenant=request.user.tenant).order_by("-created_at")
        return Response(PromoCodeSerializer(qs, many=True).data)

    @extend_schema(tags=["admin"], summary="[Admin] Create promo code")
    def post(self, request: Request) -> Response:
        from apps.payments.models import PromoCode
        from apps.payments.serializers import PromoCodeSerializer
        s = PromoCodeSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        promo = PromoCode.objects.create(tenant=request.user.tenant, **s.validated_data)
        return Response(PromoCodeSerializer(promo).data, status=status.HTTP_201_CREATED)


class AdminPromoDetailView(APIView):
    """GET/PATCH/DELETE /api/v1/admin-api/promos/{id}"""

    permission_classes = [IsAuthenticated, IsAdmin]

    def _get(self, request, pk):
        from apps.payments.models import PromoCode
        p = PromoCode.objects.filter(pk=pk, tenant=request.user.tenant).first()
        if not p:
            raise NotFoundError("Promo not found.")
        return p

    @extend_schema(tags=["admin"])
    def get(self, request, pk):
        from apps.payments.serializers import PromoCodeSerializer
        return Response(PromoCodeSerializer(self._get(request, pk)).data)

    @extend_schema(tags=["admin"])
    def patch(self, request, pk):
        from apps.payments.serializers import PromoCodeSerializer
        p = self._get(request, pk)
        s = PromoCodeSerializer(p, data=request.data, partial=True)
        s.is_valid(raise_exception=True)
        s.save()
        return Response(s.data)

    @extend_schema(tags=["admin"])
    def delete(self, request, pk):
        p = self._get(request, pk)
        p.is_active = False
        p.save(update_fields=["is_active"])
        return Response(status=status.HTTP_204_NO_CONTENT)


# ── Inventory (product stock) ──────────────────────────────────────────────────

class AdminInventoryView(APIView):
    """PATCH /api/v1/admin-api/inventory/{product_id} — adjust stock level"""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["admin"], summary="[Admin] Adjust product stock")
    def patch(self, request: Request, pk: int) -> Response:
        from apps.shop.models import Product
        from rest_framework import serializers as drf_serializers

        product = Product.objects.filter(pk=pk, tenant=request.user.tenant).first()
        if not product:
            raise NotFoundError("Product not found.")

        class StockAdjustSerializer(drf_serializers.Serializer):
            stock = drf_serializers.IntegerField(min_value=0)

        s = StockAdjustSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        product.stock = s.validated_data["stock"]
        product.save(update_fields=["stock", "updated_at"])
        return Response({"id": product.pk, "stock": product.stock})


# ── Home layout ────────────────────────────────────────────────────────────────

class HomeLayoutView(APIView):
    """
    GET  /api/v1/home/layout        — customer app reads this
    GET  /api/v1/admin-api/home-layout  — admin reads same
    PUT  /api/v1/admin-api/home-layout  — admin updates layout
    """

    def get_permissions(self):
        if self.request.method in ("PUT", "PATCH"):
            return [IsAuthenticated(), IsAdmin()]
        return [IsAuthenticated()]

    @extend_schema(tags=["home"], summary="Get home screen layout sections")
    def get(self, request: Request) -> Response:
        from django.core.cache import cache
        layout = cache.get(f"home_layout_{request.user.tenant_id}")
        if not layout:
            layout = _default_layout()
        return Response(layout)

    @extend_schema(tags=["admin"], summary="[Admin] Update home screen layout")
    def put(self, request: Request) -> Response:
        from django.core.cache import cache
        layout = request.data
        cache.set(f"home_layout_{request.user.tenant_id}", layout, timeout=None)
        return Response(layout)


def _default_layout() -> list:
    """Default home layout used until admin customises it."""
    return [
        {"type": "hero_banner", "title": "Car Wash at Your Doorstep", "cta": "Book Now", "image": None},
        {"type": "offer_strip", "text": "Use WELCOME10 for 10% off your first wash"},
        {"type": "service_rail", "title": "Our Services", "source": "services"},
        {"type": "product_rail", "title": "Shop Car Care Products", "source": "featured_products"},
    ]


# ── Admin booking management ───────────────────────────────────────────────────

class AdminBookingListView(APIView):
    """GET /api/v1/admin-api/bookings — all bookings with filters"""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["admin"], summary="[Admin] List all bookings")
    def get(self, request: Request) -> Response:
        from apps.scheduling.models import Booking
        from apps.scheduling.serializers import BookingSerializer

        qs = (
            Booking.objects.filter(tenant=request.user.tenant)
            .select_related("user", "service", "branch", "slot", "assigned_staff")
            .order_by("-scheduled_date", "-scheduled_start")
        )
        if s := request.query_params.get("status"):
            qs = qs.filter(status=s)
        if d := request.query_params.get("date"):
            qs = qs.filter(scheduled_date=d)
        return Response(BookingSerializer(qs[:100], many=True).data)


# ── Admin order management ─────────────────────────────────────────────────────

class AdminOrderStatusView(APIView):
    """PATCH /api/v1/admin-api/orders/{id}/status — advance order status"""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(tags=["admin"], summary="[Admin] Update order status")
    def patch(self, request: Request, pk: int) -> Response:
        from apps.shop.models import Order
        from apps.shop.serializers import OrderSerializer
        from rest_framework import serializers as drf_s

        order = Order.objects.filter(pk=pk, tenant=request.user.tenant).first()
        if not order:
            raise NotFoundError("Order not found.")

        class StatusSerializer(drf_s.Serializer):
            status = drf_s.ChoiceField(choices=Order.Status.choices)
            tracking_number = drf_s.CharField(max_length=100, required=False, allow_blank=True)

        s = StatusSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        order.status = s.validated_data["status"]
        if tn := s.validated_data.get("tracking_number"):
            order.tracking_number = tn
        order.save()
        return Response(OrderSerializer(order).data)
