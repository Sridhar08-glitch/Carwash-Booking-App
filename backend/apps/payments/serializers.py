from decimal import Decimal

from rest_framework import serializers

from .models import Payment, PromoCode, Wallet, WalletTransaction


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = [
            "id", "amount", "currency", "method", "status",
            "stripe_payment_intent_id", "refunded_amount", "created_at",
        ]
        read_only_fields = fields


class WalletTransactionSerializer(serializers.ModelSerializer):
    # Flat aliases consumed by the mobile app: type (credit/debit),
    # amount (absolute value as string), description (human-readable reason).
    type = serializers.SerializerMethodField()
    amount = serializers.SerializerMethodField()
    description = serializers.SerializerMethodField()

    class Meta:
        model = WalletTransaction
        fields = [
            "id", "delta", "balance_after", "reason", "reference", "created_at",
            "type", "amount", "description",
        ]
        read_only_fields = fields

    def get_type(self, obj) -> str:
        return "credit" if obj.delta >= 0 else "debit"

    def get_amount(self, obj) -> str:
        return str(abs(obj.delta))

    def get_description(self, obj) -> str:
        return (obj.reason or "").replace("_", " ").capitalize() or "Transaction"


class WalletSerializer(serializers.ModelSerializer):
    recent_transactions = serializers.SerializerMethodField()

    class Meta:
        model = Wallet
        fields = ["id", "balance", "currency", "recent_transactions"]
        read_only_fields = fields

    def get_recent_transactions(self, obj):
        txns = obj.transactions.order_by("-created_at")[:20]
        return WalletTransactionSerializer(txns, many=True).data


class WalletTopUpSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()
    amount = serializers.DecimalField(
        max_digits=12, decimal_places=2, min_value=Decimal("0.01")
    )
    reference = serializers.CharField(max_length=200, required=False, default="")


class PaymentIntentRequestSerializer(serializers.Serializer):
    payment_id = serializers.IntegerField()


class PromoCodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromoCode
        fields = [
            "id", "code", "discount_type", "value", "min_spend",
            "usage_limit", "used_count", "valid_from", "valid_until",
            "applies_to", "is_active",
        ]
        read_only_fields = ["used_count"]
