from django.contrib import admin

from .models import Cart, CartItem, Category, Order, OrderItem, Product, ProductImage


class ProductImageInline(admin.TabularInline):
    model = ProductImage
    extra = 1
    fields = ["url", "alt_text", "ordering", "is_primary"]


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ["name", "slug", "ordering", "is_active", "tenant"]
    list_filter = ["is_active", "tenant"]
    prepopulated_fields = {"slug": ("name",)}
    raw_id_fields = ["parent"]


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ["name", "brand", "category", "price", "stock", "is_active", "is_featured", "tenant"]
    list_filter = ["is_active", "is_featured", "category", "tenant"]
    search_fields = ["name", "brand", "sku"]
    prepopulated_fields = {"slug": ("name",)}
    inlines = [ProductImageInline]
    readonly_fields = ["created_at", "updated_at"]


class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 0
    readonly_fields = ["product", "quantity", "unit_price", "line_total"]


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ["pk", "user", "status", "total", "currency", "delivery_method", "created_at"]
    list_filter = ["status", "delivery_method", "tenant"]
    search_fields = ["user__phone"]
    inlines = [OrderItemInline]
    readonly_fields = ["subtotal", "discount", "shipping_fee", "total", "created_at", "updated_at"]
    raw_id_fields = ["user", "shipping_address", "promo_code", "payment"]


@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ["user", "last_activity"]
    raw_id_fields = ["user"]
