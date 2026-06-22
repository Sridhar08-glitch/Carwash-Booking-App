from django.urls import path

from .views import (
    PaymentConfirmView,
    PaymentDetailView,
    PaymentIntentView,
    PaymentListView,
    StripeWebhookView,
    WalletTopUpView,
    WalletView,
)

urlpatterns = [
    path("payments/wallet", WalletView.as_view(), name="wallet"),
    path("payments/wallet/top-up", WalletTopUpView.as_view(), name="wallet-top-up"),
    path("payments/intent", PaymentIntentView.as_view(), name="payment-intent"),
    path("payments/confirm", PaymentConfirmView.as_view(), name="payment-confirm"),
    path("payments/webhook", StripeWebhookView.as_view(), name="stripe-webhook"),
    path("payments/", PaymentListView.as_view(), name="payment-list"),
    path("payments/<int:pk>", PaymentDetailView.as_view(), name="payment-detail"),
]
