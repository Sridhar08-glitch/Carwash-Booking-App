"""
Payments models.

Payment          — one record per charge attempt (booking or order).
Wallet           — customer balance (loyalty points + loaded funds).
WalletTransaction— double-entry ledger for wallet balance changes.
PromoCode        — discount codes.

Phase 1: cash payments only.
Phase 2: Stripe PaymentIntent + webhook integration.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class Payment(TenantScopedModel):
    """
    Represents a single payment attempt.

    `amount` is always server-computed; clients never supply amounts.
    `stripe_payment_intent_id` is null until Phase 2.
    """

    class Method(models.TextChoices):
        CARD = "card", "Card"
        WALLET = "wallet", "Wallet"
        CASH = "cash", "Cash / COD"
        APPLE_PAY = "apple_pay", "Apple Pay"
        GOOGLE_PAY = "google_pay", "Google Pay"

    class Status(models.TextChoices):
        PENDING = "pending", "Pending"
        REQUIRES_ACTION = "requires_action", "Requires Action"
        SUCCEEDED = "succeeded", "Succeeded"
        FAILED = "failed", "Failed"
        REFUNDED = "refunded", "Refunded"
        PARTIALLY_REFUNDED = "partially_refunded", "Partially Refunded"
        CANCELLED = "cancelled", "Cancelled"

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name="payments")
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default="SAR")
    method = models.CharField(max_length=15, choices=Method.choices, default=Method.CASH)
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING, db_index=True)

    # Stripe (Phase 2)
    stripe_payment_intent_id = models.CharField(max_length=100, blank=True, db_index=True)
    stripe_client_secret = models.CharField(max_length=200, blank=True)

    # Idempotency (Phase 2)
    idempotency_key = models.CharField(max_length=255, blank=True, db_index=True)

    # Refund tracking
    refunded_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0)

    class Meta:
        db_table = "payments_payment"
        indexes = [
            models.Index(fields=["user", "status"]),
            models.Index(fields=["tenant", "status"]),
        ]

    def __str__(self) -> str:
        return f"Payment#{self.pk}({self.amount}{self.currency},{self.status})"


class Wallet(TenantScopedModel):
    """
    Customer wallet — can hold pre-loaded funds and loyalty cashback.

    Balance is never negative (enforced in WalletTransaction.deduct()).
    """

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="wallet"
    )
    balance = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    currency = models.CharField(max_length=3, default="SAR")

    class Meta:
        db_table = "payments_wallet"

    def __str__(self) -> str:
        return f"Wallet({self.user_id}, {self.balance})"


class WalletTransaction(TenantScopedModel):
    """Ledger entry for every wallet balance change."""

    class Reason(models.TextChoices):
        TOP_UP = "top_up", "Top Up"
        BOOKING_PAYMENT = "booking_payment", "Booking Payment"
        ORDER_PAYMENT = "order_payment", "Order Payment"
        REFUND = "refund", "Refund"
        LOYALTY_CREDIT = "loyalty_credit", "Loyalty Credit"
        ADJUSTMENT = "adjustment", "Admin Adjustment"

    wallet = models.ForeignKey(Wallet, on_delete=models.CASCADE, related_name="transactions")
    # Positive = credit, negative = debit
    delta = models.DecimalField(max_digits=12, decimal_places=2)
    balance_after = models.DecimalField(max_digits=12, decimal_places=2)
    reason = models.CharField(max_length=20, choices=Reason.choices)
    reference = models.CharField(max_length=200, blank=True)

    class Meta:
        db_table = "payments_wallet_transaction"
        ordering = ["-created_at"]

    def __str__(self) -> str:
        return f"WalletTx({self.wallet_id}, delta={self.delta}, reason={self.reason})"


class PromoCode(TenantScopedModel):
    """Discount/promo codes."""

    class DiscountType(models.TextChoices):
        PERCENT = "percent", "Percentage"
        FIXED = "fixed", "Fixed Amount"

    class AppliesTo(models.TextChoices):
        WASH = "wash", "Car Wash"
        SHOP = "shop", "Shop"
        BOTH = "both", "Both"

    code = models.CharField(max_length=50, db_index=True)
    discount_type = models.CharField(max_length=10, choices=DiscountType.choices)
    value = models.DecimalField(max_digits=8, decimal_places=2)  # % or fixed amount
    min_spend = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    usage_limit = models.PositiveIntegerField(null=True, blank=True)  # null = unlimited
    used_count = models.PositiveIntegerField(default=0)
    valid_from = models.DateTimeField()
    valid_until = models.DateTimeField()
    applies_to = models.CharField(max_length=5, choices=AppliesTo.choices, default=AppliesTo.BOTH)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = "payments_promo_code"
        unique_together = [("tenant", "code")]

    def __str__(self) -> str:
        return f"Promo({self.code}, {self.discount_type}={self.value})"
