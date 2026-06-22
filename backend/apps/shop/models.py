"""
Shop models.

Category        — product taxonomy.
Product         — a physical product (car-care items, accessories, etc.).
ProductImage    — one-to-many images per product.
Cart            — one active cart per customer.
CartItem        — product + qty in a cart.
Order           — a placed order (after checkout).
OrderItem       — snapshot of product + price at purchase time.

Stock invariant
---------------
`Product.stock` is decremented inside a `select_for_update()` transaction
at payment success (not at cart time, to avoid cart-time holds in Phase 1).
`OrderItem.unit_price` is a snapshot; it never changes after the order is placed.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel, SoftDeleteManager, AllObjectsManager


class Category(TenantScopedModel):
    name = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200)
    description = models.TextField(blank=True)
    image = models.ImageField(upload_to="shop/categories/", null=True, blank=True)
    ordering = models.PositiveSmallIntegerField(default=0)
    is_active = models.BooleanField(default=True, db_index=True)
    parent = models.ForeignKey(
        "self", null=True, blank=True, on_delete=models.SET_NULL, related_name="children"
    )

    class Meta:
        db_table = "shop_category"
        unique_together = [("tenant", "slug")]
        ordering = ["ordering", "name"]

    def __str__(self):
        return self.name


class Product(TenantScopedModel):
    """A physical product available in the shop."""

    category = models.ForeignKey(Category, on_delete=models.PROTECT, related_name="products")
    name = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200)
    description = models.TextField(blank=True)
    # Money
    price = models.DecimalField(max_digits=12, decimal_places=2)
    compare_at_price = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True)
    currency = models.CharField(max_length=3, default="SAR")
    # Inventory
    stock = models.PositiveIntegerField(default=0)
    low_stock_threshold = models.PositiveIntegerField(default=5)
    track_inventory = models.BooleanField(default=True)
    # Vehicle compatibility tags (for recommendations)
    car_type_tags = models.JSONField(default=list, blank=True)
    # SEO / display
    brand = models.CharField(max_length=100, blank=True)
    sku = models.CharField(max_length=100, blank=True)
    weight_grams = models.PositiveIntegerField(null=True, blank=True)
    is_active = models.BooleanField(default=True, db_index=True)
    is_featured = models.BooleanField(default=False)

    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()

    class Meta:
        db_table = "shop_product"
        unique_together = [("tenant", "slug")]
        indexes = [
            models.Index(fields=["tenant", "is_active"]),
            models.Index(fields=["category", "is_active"]),
            models.Index(fields=["brand", "is_active"]),
        ]

    def __str__(self):
        return self.name

    @property
    def is_in_stock(self):
        return not self.track_inventory or self.stock > 0

    @property
    def is_low_stock(self):
        return self.track_inventory and 0 < self.stock <= self.low_stock_threshold


class ProductImage(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="images")
    url = models.URLField(max_length=500)
    alt_text = models.CharField(max_length=255, blank=True)
    ordering = models.PositiveSmallIntegerField(default=0)
    is_primary = models.BooleanField(default=False)

    class Meta:
        db_table = "shop_product_image"
        ordering = ["ordering"]

    def __str__(self):
        return f"Image({self.product_id}, {self.ordering})"


class Cart(TenantScopedModel):
    """One active cart per customer. Abandoned carts trigger notifications."""

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="cart"
    )
    promo_code = models.ForeignKey(
        "payments.PromoCode", on_delete=models.SET_NULL, null=True, blank=True
    )
    last_activity = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "shop_cart"

    def __str__(self):
        return f"Cart({self.user_id})"

    @property
    def subtotal(self):
        return sum(item.line_total for item in self.items.select_related("product"))


class CartItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name="items")
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveSmallIntegerField(default=1)
    added_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "shop_cart_item"
        unique_together = [("cart", "product")]

    def __str__(self):
        return f"CartItem({self.product_id}, qty={self.quantity})"

    @property
    def line_total(self):
        return self.product.price * self.quantity


class Order(TenantScopedModel):
    """A placed and (optionally) paid order."""

    class Status(models.TextChoices):
        PENDING = "pending", "Pending"
        PAID = "paid", "Paid"
        PROCESSING = "processing", "Processing"
        SHIPPED = "shipped", "Shipped"
        DELIVERED = "delivered", "Delivered"
        CANCELLED = "cancelled", "Cancelled"
        REFUNDED = "refunded", "Refunded"

    class DeliveryMethod(models.TextChoices):
        PICKUP = "pickup", "Branch Pickup"
        DELIVERY = "delivery", "Home Delivery"

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.PROTECT, related_name="orders"
    )
    status = models.CharField(max_length=15, choices=Status.choices, default=Status.PENDING, db_index=True)
    delivery_method = models.CharField(max_length=10, choices=DeliveryMethod.choices, default=DeliveryMethod.PICKUP)
    shipping_address = models.ForeignKey(
        "accounts.Address", on_delete=models.SET_NULL, null=True, blank=True
    )

    # Money — server-computed, never client-supplied
    subtotal = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    shipping_fee = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    currency = models.CharField(max_length=3, default="SAR")

    promo_code = models.ForeignKey(
        "payments.PromoCode", on_delete=models.SET_NULL, null=True, blank=True
    )
    payment = models.ForeignKey(
        "payments.Payment", on_delete=models.SET_NULL, null=True, blank=True, related_name="orders"
    )
    idempotency_key = models.CharField(max_length=255, blank=True, db_index=True)

    # Shipping
    tracking_number = models.CharField(max_length=100, blank=True)
    shipped_at = models.DateTimeField(null=True, blank=True)
    delivered_at = models.DateTimeField(null=True, blank=True)

    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()

    class Meta:
        db_table = "shop_order"
        indexes = [
            models.Index(fields=["user", "status"]),
            models.Index(fields=["tenant", "status"]),
        ]

    def __str__(self):
        return f"Order#{self.pk}({self.user_id}, {self.status}, {self.total})"


class OrderItem(models.Model):
    """
    Snapshot of a product at purchase time.
    `unit_price` is frozen at checkout — never recomputed from the live Product.
    """

    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name="items")
    product = models.ForeignKey(Product, on_delete=models.PROTECT)
    quantity = models.PositiveSmallIntegerField()
    unit_price = models.DecimalField(max_digits=12, decimal_places=2)  # snapshot

    class Meta:
        db_table = "shop_order_item"

    def __str__(self):
        return f"OrderItem({self.product_id}, qty={self.quantity}, price={self.unit_price})"

    @property
    def line_total(self):
        return self.unit_price * self.quantity
