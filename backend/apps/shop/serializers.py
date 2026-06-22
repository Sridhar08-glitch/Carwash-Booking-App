from rest_framework import serializers

from .models import Cart, CartItem, Category, Order, OrderItem, Product, ProductImage


class ProductImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImage
        fields = ["id", "url", "alt_text", "ordering", "is_primary"]


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ["id", "name", "slug", "description", "image", "ordering"]


class ProductListSerializer(serializers.ModelSerializer):
    primary_image = serializers.SerializerMethodField()
    category = CategorySerializer(read_only=True)
    # ── Flat aliases consumed by the mobile app ───────────────────────────────
    description = serializers.CharField(read_only=True)
    short_description = serializers.SerializerMethodField()
    image_url = serializers.SerializerMethodField()
    in_stock = serializers.BooleanField(source="is_in_stock", read_only=True)
    stock_quantity = serializers.IntegerField(source="stock", read_only=True)

    class Meta:
        model = Product
        fields = [
            "id", "name", "slug", "category", "price", "compare_at_price",
            "currency", "brand", "sku", "stock", "is_in_stock", "is_low_stock",
            "is_featured", "primary_image",
            "description", "short_description", "image_url", "in_stock", "stock_quantity",
        ]

    def get_primary_image(self, obj):
        img = next((i for i in obj.images.all() if i.is_primary), None)
        if img:
            return ProductImageSerializer(img).data
        return None

    def get_short_description(self, obj) -> str:
        text = obj.description or ""
        return text[:140]

    def get_image_url(self, obj):
        img = next((i for i in obj.images.all() if i.is_primary), None)
        if img is None:
            img = next(iter(obj.images.all()), None)
        return img.url if img else None


class ProductDetailSerializer(ProductListSerializer):
    images = ProductImageSerializer(many=True, read_only=True)

    class Meta(ProductListSerializer.Meta):
        fields = ProductListSerializer.Meta.fields + ["description", "car_type_tags", "weight_grams", "images"]


class CartItemSerializer(serializers.ModelSerializer):
    product = ProductListSerializer(read_only=True)
    line_total = serializers.DecimalField(max_digits=12, decimal_places=2, read_only=True)
    # ── Flat aliases consumed by the mobile app ───────────────────────────────
    product_id = serializers.IntegerField(read_only=True)
    product_name = serializers.CharField(source="product.name", read_only=True)
    product_image = serializers.SerializerMethodField()
    unit_price = serializers.DecimalField(
        source="product.price", max_digits=12, decimal_places=2, read_only=True
    )
    currency = serializers.CharField(source="product.currency", read_only=True)

    class Meta:
        model = CartItem
        fields = [
            "id", "product", "quantity", "line_total", "added_at",
            "product_id", "product_name", "product_image", "unit_price", "currency",
        ]
        read_only_fields = ["id", "added_at"]

    def get_product_image(self, obj):
        img = next((i for i in obj.product.images.all() if i.is_primary), None)
        if img is None:
            img = next(iter(obj.product.images.all()), None)
        return img.url if img else None


class CartItemCreateSerializer(serializers.Serializer):
    product_id = serializers.IntegerField()
    quantity = serializers.IntegerField(min_value=1, default=1)


class CartItemUpdateSerializer(serializers.Serializer):
    quantity = serializers.IntegerField(min_value=0)


class PromoCodeApplySerializer(serializers.Serializer):
    code = serializers.CharField(max_length=50)


class CartSerializer(serializers.ModelSerializer):
    items = CartItemSerializer(many=True, read_only=True)
    subtotal = serializers.DecimalField(max_digits=12, decimal_places=2, read_only=True)
    promo_code = serializers.CharField(source="promo_code.code", read_only=True, default=None)
    # ── Flat aliases consumed by the mobile app ───────────────────────────────
    discount_amount = serializers.SerializerMethodField()
    total = serializers.SerializerMethodField()
    currency = serializers.SerializerMethodField()

    class Meta:
        model = Cart
        fields = [
            "id", "items", "subtotal", "promo_code", "last_activity",
            "discount_amount", "total", "currency",
        ]
        read_only_fields = fields

    def _discount(self, obj):
        from decimal import Decimal

        promo = obj.promo_code
        subtotal = obj.subtotal
        if promo is None:
            return Decimal("0.00")
        if promo.discount_type == "percent":
            return (subtotal * promo.value / Decimal("100")).quantize(Decimal("0.01"))
        return min(promo.value, subtotal)

    def get_discount_amount(self, obj) -> str:
        return str(self._discount(obj))

    def get_total(self, obj) -> str:
        return str(obj.subtotal - self._discount(obj))

    def get_currency(self, obj) -> str:
        first = next(iter(obj.items.all()), None)
        return first.product.currency if first else "SAR"


class OrderItemSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True)
    line_total = serializers.DecimalField(max_digits=12, decimal_places=2, read_only=True)
    product_image = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = [
            "id", "product_id", "product_name", "product_image",
            "quantity", "unit_price", "line_total",
        ]
        read_only_fields = fields

    def get_product_image(self, obj):
        if obj.product is None:
            return None
        img = next((i for i in obj.product.images.all() if i.is_primary), None)
        if img is None:
            img = next(iter(obj.product.images.all()), None)
        return img.url if img else None


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)
    item_count = serializers.SerializerMethodField()

    class Meta:
        model = Order
        fields = [
            "id", "status", "delivery_method",
            "subtotal", "discount", "shipping_fee", "total", "currency",
            "tracking_number", "shipped_at", "delivered_at",
            "created_at", "updated_at", "items", "item_count",
        ]
        read_only_fields = fields

    def get_item_count(self, obj) -> int:
        return sum(i.quantity for i in obj.items.all())


class CheckoutSerializer(serializers.Serializer):
    delivery_method = serializers.ChoiceField(choices=["pickup", "delivery"], default="pickup")
    shipping_address_id = serializers.IntegerField(required=False, allow_null=True)
    idempotency_key = serializers.CharField(max_length=255, required=False, default="")
