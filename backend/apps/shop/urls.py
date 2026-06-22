from django.urls import path

from .views import (
    CartItemView, CartPromoView, CartView,
    OrderCheckoutView, OrderDetailView, OrderListView, OrderTrackView,
    ProductDetailView, ProductListView,
)

urlpatterns = [
    path("products", ProductListView.as_view(), name="product-list"),
    path("products/<int:pk>", ProductDetailView.as_view(), name="product-detail"),
    path("cart", CartView.as_view(), name="cart"),
    path("cart/items", CartItemView.as_view(), name="cart-items"),
    path("cart/items/<int:item_id>", CartItemView.as_view(), name="cart-item-detail"),
    path("cart/apply-promo", CartPromoView.as_view(), name="cart-promo"),
    path("orders/checkout", OrderCheckoutView.as_view(), name="order-checkout"),
    path("orders", OrderListView.as_view(), name="order-list"),
    path("orders/<int:pk>", OrderDetailView.as_view(), name="order-detail"),
    path("orders/<int:pk>/track", OrderTrackView.as_view(), name="order-track"),
]
