"""Read-only queries for the shop app."""
from __future__ import annotations

from django.db.models import Prefetch, QuerySet

from .models import Cart, Category, Order, Product


def get_products(
    *,
    tenant_id,
    search: str | None = None,
    brand: str | None = None,
    car_type: str | None = None,
    category_slug: str | None = None,
    min_price=None,
    max_price=None,
    is_featured: bool | None = None,
) -> QuerySet:
    qs = (
        Product.objects.filter(tenant_id=tenant_id, is_active=True)
        .select_related("category")
        .prefetch_related(Prefetch("images", queryset=__import__("apps.shop.models", fromlist=["ProductImage"]).ProductImage.objects.filter(is_primary=True)))
        .order_by("-is_featured", "name")
    )
    if search:
        from django.db.models import Q
        qs = qs.filter(Q(name__icontains=search) | Q(description__icontains=search) | Q(brand__icontains=search))
    if brand:
        qs = qs.filter(brand__iexact=brand)
    if category_slug:
        qs = qs.filter(category__slug=category_slug)
    if min_price is not None:
        qs = qs.filter(price__gte=min_price)
    if max_price is not None:
        qs = qs.filter(price__lte=max_price)
    if is_featured is not None:
        qs = qs.filter(is_featured=is_featured)
    return qs


def get_product_by_id(*, tenant_id, product_id: int) -> Product | None:
    return (
        Product.objects.filter(tenant_id=tenant_id, pk=product_id, is_active=True)
        .prefetch_related("images")
        .select_related("category")
        .first()
    )


def get_cart(*, user) -> Cart | None:
    return (
        Cart.objects.filter(user=user)
        .prefetch_related("items__product__images")
        .select_related("promo_code")
        .first()
    )


def get_user_orders(*, user, status: str | None = None) -> QuerySet:
    qs = (
        Order.objects.filter(user=user)
        .select_related("payment", "shipping_address")
        .prefetch_related("items__product")
        .order_by("-created_at")
    )
    if status:
        qs = qs.filter(status=status)
    return qs


def get_order_by_id(*, user, order_id: int) -> Order | None:
    return (
        Order.objects.filter(user=user, pk=order_id)
        .select_related("payment", "shipping_address")
        .prefetch_related("items__product")
        .first()
    )
