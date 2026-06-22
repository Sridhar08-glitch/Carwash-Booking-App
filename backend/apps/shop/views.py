"""Shop views."""
from django.core.cache import cache
from drf_spectacular.utils import OpenApiParameter, extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError

from . import services
from .selectors import get_cart, get_order_by_id, get_products, get_product_by_id, get_user_orders
from .serializers import (
    CartItemCreateSerializer, CartItemUpdateSerializer, CartSerializer,
    CheckoutSerializer, OrderSerializer, ProductDetailSerializer,
    ProductListSerializer, PromoCodeApplySerializer,
)


# ── Products ──────────────────────────────────────────────────────────────────

class ProductListView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        parameters=[
            OpenApiParameter("search", str),
            OpenApiParameter("brand", str),
            OpenApiParameter("category", str),
            OpenApiParameter("min_price", float),
            OpenApiParameter("max_price", float),
        ],
        responses={200: ProductListSerializer(many=True)},
        tags=["shop"],
        summary="List products",
    )
    def get(self, request: Request) -> Response:
        q = request.query_params
        qs = get_products(
            tenant_id=request.user.tenant_id,
            search=q.get("search"),
            brand=q.get("brand"),
            car_type=q.get("car_type"),
            category_slug=q.get("category"),
            min_price=q.get("min_price"),
            max_price=q.get("max_price"),
        )
        return Response(ProductListSerializer(qs, many=True).data)


class ProductDetailView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: ProductDetailSerializer}, tags=["shop"])
    def get(self, request: Request, pk: int) -> Response:
        product = get_product_by_id(tenant_id=request.user.tenant_id, product_id=pk)
        if not product:
            raise NotFoundError("Product not found.")
        return Response(ProductDetailSerializer(product).data)


# ── Cart ──────────────────────────────────────────────────────────────────────

class CartView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: CartSerializer}, tags=["cart"])
    def get(self, request: Request) -> Response:
        cart = get_cart(user=request.user)
        if not cart:
            # Shape must match CartSerializer — the app requires id/total.
            return Response({
                "id": 0,
                "items": [],
                "subtotal": "0.00",
                "discount_amount": "0.00",
                "total": "0.00",
                "currency": "SAR",
                "promo_code": None,
                "last_activity": None,
            })
        return Response(CartSerializer(cart).data)


class CartItemView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(request=CartItemCreateSerializer, responses={201: CartSerializer}, tags=["cart"])
    def post(self, request: Request) -> Response:
        s = CartItemCreateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        services.cart_add_item(user=request.user, **s.validated_data)
        return Response(CartSerializer(get_cart(user=request.user)).data, status=status.HTTP_201_CREATED)

    @extend_schema(request=CartItemUpdateSerializer, responses={200: CartSerializer}, tags=["cart"])
    def patch(self, request: Request, item_id: int) -> Response:
        s = CartItemUpdateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        services.cart_update_item(user=request.user, item_id=item_id, **s.validated_data)
        return Response(CartSerializer(get_cart(user=request.user)).data)

    @extend_schema(responses={200: CartSerializer}, tags=["cart"])
    def delete(self, request: Request, item_id: int) -> Response:
        services.cart_remove_item(user=request.user, item_id=item_id)
        return Response(CartSerializer(get_cart(user=request.user)).data)


class CartPromoView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(request=PromoCodeApplySerializer, responses={200: CartSerializer}, tags=["cart"])
    def post(self, request: Request) -> Response:
        s = PromoCodeApplySerializer(data=request.data)
        s.is_valid(raise_exception=True)
        services.cart_apply_promo(user=request.user, code=s.validated_data["code"])
        return Response(CartSerializer(get_cart(user=request.user)).data)


# ── Orders ────────────────────────────────────────────────────────────────────

class OrderCheckoutView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=CheckoutSerializer,
        responses={201: OrderSerializer},
        tags=["shop"],
        summary="Checkout — create order + payment intent",
    )
    def post(self, request: Request) -> Response:
        idempotency_key = request.headers.get("Idempotency-Key", "")
        s = CheckoutSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        if idempotency_key:
            s.validated_data["idempotency_key"] = idempotency_key

        order = services.checkout(user=request.user, **s.validated_data)

        # Create Stripe PaymentIntent and attach client_secret to response.
        # Skipped when Stripe is not configured (local dev / cash flows) —
        # the app can request an intent later via POST /payments/intent.
        client_secret = None
        from django.conf import settings as dj_settings
        if dj_settings.STRIPE_SECRET_KEY:
            import logging

            from apps.payments.stripe_service import create_payment_intent
            try:
                client_secret = create_payment_intent(payment=order.payment)
            except Exception:  # noqa: BLE001 — Stripe outage must not lose the order
                logging.getLogger(__name__).warning(
                    "Stripe intent creation failed for order %s; "
                    "client can retry via /payments/intent", order.pk,
                )

        data = OrderSerializer(order).data
        data["client_secret"] = client_secret
        return Response(data, status=status.HTTP_201_CREATED)


class OrderListView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: OrderSerializer(many=True)}, tags=["shop"])
    def get(self, request: Request) -> Response:
        return Response(OrderSerializer(
            get_user_orders(user=request.user, status=request.query_params.get("status")),
            many=True,
        ).data)


class OrderDetailView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: OrderSerializer}, tags=["shop"])
    def get(self, request: Request, pk: int) -> Response:
        order = get_order_by_id(user=request.user, order_id=pk)
        if not order:
            raise NotFoundError()
        return Response(OrderSerializer(order).data)


class OrderTrackView(APIView):
    """
    GET /api/v1/orders/<pk>/track

    Returns shipping / fulfillment status for an order.
    For pickup orders: shows branch address and estimated ready time.
    For delivery orders: shows carrier, tracking_number, and status.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: {"type": "object", "properties": {
            "order_id":        {"type": "integer"},
            "status":          {"type": "string"},
            "delivery_method": {"type": "string"},
            "tracking_number": {"type": "string"},
            "shipped_at":      {"type": "string", "format": "date-time"},
            "delivered_at":    {"type": "string", "format": "date-time"},
        }}},
        tags=["shop"],
        summary="Track an order (shipping / fulfillment status)",
    )
    def get(self, request: Request, pk: int) -> Response:
        order = get_order_by_id(user=request.user, order_id=pk)
        if not order:
            raise NotFoundError("Order not found.")
        return Response({
            "order_id":        order.pk,
            "status":          order.status,
            "delivery_method": order.delivery_method,
            "tracking_number": order.tracking_number or None,
            "shipped_at":      order.shipped_at.isoformat() if order.shipped_at else None,
            "delivered_at":    order.delivered_at.isoformat() if order.delivered_at else None,
        })
