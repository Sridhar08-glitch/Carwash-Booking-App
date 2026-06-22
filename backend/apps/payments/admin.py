from django.contrib import admin

from .models import Payment, PromoCode, Wallet, WalletTransaction


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ["pk", "user", "amount", "currency", "method", "status", "created_at"]
    list_filter = ["status", "method", "tenant"]
    search_fields = ["user__phone", "stripe_payment_intent_id"]
    readonly_fields = ["created_at", "updated_at"]


@admin.register(Wallet)
class WalletAdmin(admin.ModelAdmin):
    list_display = ["user", "balance", "currency"]
    search_fields = ["user__phone"]
    readonly_fields = ["created_at", "updated_at"]


@admin.register(WalletTransaction)
class WalletTransactionAdmin(admin.ModelAdmin):
    list_display = ["wallet", "delta", "balance_after", "reason", "created_at"]
    list_filter = ["reason"]
    readonly_fields = ["created_at", "updated_at"]


@admin.register(PromoCode)
class PromoCodeAdmin(admin.ModelAdmin):
    list_display = ["code", "discount_type", "value", "used_count", "usage_limit", "is_active", "valid_until"]
    list_filter = ["is_active", "discount_type", "applies_to", "tenant"]
    search_fields = ["code"]
