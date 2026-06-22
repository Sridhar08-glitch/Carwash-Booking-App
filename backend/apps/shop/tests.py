"""
Shop tests -- Phase 2.

Covers:
- Cart: add, update, remove, promo.
- Checkout: happy path, empty cart, idempotency, promo discount math.
- confirm_order_payment: stock decrement, idempotency.
- Stock oversell: concurrent checkouts must not produce negative stock.
- API: product list/detail, cart CRUD, checkout endpoint.
"""
from decimal import Decimal

from django.test import TestCase, TransactionTestCase
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.common.models import Tenant
from apps.payments.models import PromoCode
from apps.shop import services
from apps.shop.models import Cart, Category, Order, OrderItem, Product


def _make_base():
    tenant, _ = Tenant.objects.get_or_create(slug="shop-test", defaults={"name": "ShopTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone="+966541111111",
        defaults={"username": "+966541111111", "tenant": tenant, "role": "customer", "is_phone_verified": True},
    )
    cat, _ = Category.objects.get_or_create(
        tenant=tenant, slug="shop-cat", defaults={"name": "Cleaning", "is_active": True}
    )
    product, _ = Product.objects.get_or_create(
        tenant=tenant, slug="shampoo",
        defaults={"category": cat, "name": "Car Shampoo", "price": "25.00", "currency": "SAR", "stock": 10},
    )
    return tenant, user, cat, product


def _api_client(user):
    client = APIClient()
    token = RefreshToken.for_user(user)
    client.credentials(HTTP_AUTHORIZATION=f"Bearer {token.access_token}")
    return client


class CartTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.product = _make_base()
        Cart.objects.filter(user=self.user).delete()

    def test_add_item_creates_cart(self):
        item = services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=2)
        self.assertEqual(item.quantity, 2)
        self.assertIsNotNone(item.cart)

    def test_add_item_increments_qty_on_duplicate(self):
        services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
        item = services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=3)
        self.assertEqual(item.quantity, 4)

    def test_update_item_qty(self):
        item = services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=2)
        updated = services.cart_update_item(user=self.user, item_id=item.pk, quantity=5)
        self.assertEqual(updated.quantity, 5)

    def test_update_item_qty_zero_removes_item(self):
        from apps.shop.models import CartItem
        item = services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=2)
        services.cart_update_item(user=self.user, item_id=item.pk, quantity=0)
        self.assertFalse(CartItem.objects.filter(pk=item.pk).exists())

    def test_remove_item(self):
        from apps.shop.models import CartItem
        item = services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
        services.cart_remove_item(user=self.user, item_id=item.pk)
        self.assertFalse(CartItem.objects.filter(pk=item.pk).exists())

    def test_add_inactive_product_raises_not_found(self):
        from apps.common.errors import NotFoundError
        self.product.is_active = False
        self.product.save(update_fields=["is_active"])
        with self.assertRaises(NotFoundError):
            services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
        self.product.is_active = True
        self.product.save(update_fields=["is_active"])

    def test_apply_valid_promo(self):
        from django.utils import timezone
        services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
        promo = PromoCode.objects.create(
            tenant=self.tenant, code="VALIDP",
            discount_type="percent", value=Decimal("10"), min_spend=Decimal("0"),
            valid_from=timezone.now() - timezone.timedelta(hours=1),
            valid_until=timezone.now() + timezone.timedelta(days=1),
            applies_to="shop",
        )
        cart = services.cart_apply_promo(user=self.user, code="VALIDP")
        self.assertEqual(cart.promo_code_id, promo.pk)

    def test_apply_expired_promo_raises(self):
        from apps.common.errors import ConflictError
        from django.utils import timezone
        services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
        PromoCode.objects.create(
            tenant=self.tenant, code="EXPIREDP",
            discount_type="fixed", value=Decimal("5"), min_spend=Decimal("0"),
            valid_from=timezone.now() - timezone.timedelta(days=10),
            valid_until=timezone.now() - timezone.timedelta(days=1),
            applies_to="both",
        )
        with self.assertRaises(ConflictError):
            services.cart_apply_promo(user=self.user, code="EXPIREDP")


class CheckoutTests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.product = _make_base()
        self.product.stock = 10
        self.product.save(update_fields=["stock"])
        Cart.objects.filter(user=self.user).delete()

    def _add(self, qty=2):
        return services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=qty)

    def test_checkout_creates_pending_order(self):
        self._add(2)
        order = services.checkout(user=self.user)
        self.assertEqual(order.status, Order.Status.PENDING)
        self.assertEqual(order.subtotal, Decimal("50.00"))
        self.assertEqual(order.total, Decimal("50.00"))
        self.assertEqual(order.items.count(), 1)

    def test_unit_price_is_snapshot(self):
        self._add(1)
        order = services.checkout(user=self.user)
        self.product.price = Decimal("99.00")
        self.product.save(update_fields=["price"])
        item = order.items.first()
        item.refresh_from_db()
        self.assertEqual(item.unit_price, Decimal("25.00"))

    def test_empty_cart_raises_conflict(self):
        from apps.common.errors import ConflictError
        with self.assertRaises(ConflictError):
            services.checkout(user=self.user)

    def test_idempotency_key_replays_same_order(self):
        self._add(1)
        o1 = services.checkout(user=self.user, idempotency_key="idem-key-xyz")
        o2 = services.checkout(user=self.user, idempotency_key="idem-key-xyz")
        self.assertEqual(o1.pk, o2.pk)

    def test_percent_promo_reduces_total(self):
        from django.utils import timezone
        self._add(2)
        PromoCode.objects.create(
            tenant=self.tenant, code="PCTOFF",
            discount_type="percent", value=Decimal("10"), min_spend=Decimal("0"),
            valid_from=timezone.now() - timezone.timedelta(hours=1),
            valid_until=timezone.now() + timezone.timedelta(days=1),
            applies_to="shop",
        )
        services.cart_apply_promo(user=self.user, code="PCTOFF")
        order = services.checkout(user=self.user)
        self.assertEqual(order.discount, Decimal("5.00"))
        self.assertEqual(order.total, Decimal("45.00"))

    def test_fixed_promo_reduces_total(self):
        from django.utils import timezone
        self._add(2)
        PromoCode.objects.create(
            tenant=self.tenant, code="FIXOFF",
            discount_type="fixed", value=Decimal("7"), min_spend=Decimal("0"),
            valid_from=timezone.now() - timezone.timedelta(hours=1),
            valid_until=timezone.now() + timezone.timedelta(days=1),
            applies_to="both",
        )
        services.cart_apply_promo(user=self.user, code="FIXOFF")
        order = services.checkout(user=self.user)
        self.assertEqual(order.discount, Decimal("7.00"))
        self.assertEqual(order.total, Decimal("43.00"))

    def test_confirm_order_payment_marks_paid_and_decrements_stock(self):
        self._add(3)
        original_stock = self.product.stock
        order = services.checkout(user=self.user)
        services.confirm_order_payment(order_id=order.pk)
        order.refresh_from_db()
        self.product.refresh_from_db()
        self.assertEqual(order.status, Order.Status.PAID)
        self.assertEqual(self.product.stock, original_stock - 3)

    def test_confirm_order_payment_is_idempotent(self):
        self._add(1)
        original_stock = self.product.stock
        order = services.checkout(user=self.user)
        services.confirm_order_payment(order_id=order.pk)
        services.confirm_order_payment(order_id=order.pk)
        self.product.refresh_from_db()
        self.assertEqual(self.product.stock, original_stock - 1)


class StockOversellTest(TransactionTestCase):
    """Two concurrent confirmations of a 1-stock product -- stock never goes negative."""

    def setUp(self):
        tenant, _ = Tenant.objects.get_or_create(slug="stock-test", defaults={"name": "StockTest"})
        self.user, _ = CustomUser.objects.get_or_create(
            phone="+966549999999",
            defaults={"username": "+966549999999", "tenant": tenant, "role": "customer"},
        )
        cat, _ = Category.objects.get_or_create(
            tenant=tenant, slug="conccat", defaults={"name": "Conc", "is_active": True}
        )
        self.product, _ = Product.objects.get_or_create(
            tenant=tenant, slug="concprod",
            defaults={"category": cat, "name": "Concurrent", "price": "10", "stock": 1},
        )

    def test_no_negative_stock_under_concurrent_confirm(self):
        import threading
        errors = []

        def do_confirm():
            try:
                services.cart_add_item(user=self.user, product_id=self.product.pk, quantity=1)
                order = services.checkout(user=self.user)
                services.confirm_order_payment(order_id=order.pk)
            except Exception as exc:
                errors.append(str(exc))

        t1 = threading.Thread(target=do_confirm)
        t2 = threading.Thread(target=do_confirm)
        t1.start(); t2.start()
        t1.join(); t2.join()

        self.product.refresh_from_db()
        self.assertGreaterEqual(self.product.stock, 0, "Stock went negative!")


class ShopAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user, self.cat, self.product = _make_base()
        self.client = _api_client(self.user)
        Cart.objects.filter(user=self.user).delete()

    def test_product_list_200(self):
        resp = self.client.get("/api/v1/products")
        self.assertEqual(resp.status_code, 200)

    def test_product_detail_200(self):
        resp = self.client.get(f"/api/v1/products/{self.product.pk}")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["name"], "Car Shampoo")

    def test_product_detail_404(self):
        resp = self.client.get("/api/v1/products/9999999")
        self.assertEqual(resp.status_code, 404)

    def test_cart_add_and_list(self):
        resp = self.client.post("/api/v1/cart/items", {"product_id": self.product.pk, "quantity": 2})
        self.assertEqual(resp.status_code, 201)
        resp = self.client.get("/api/v1/cart")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["items"][0]["quantity"], 2)

    def test_cart_delete_item(self):
        self.client.post("/api/v1/cart/items", {"product_id": self.product.pk, "quantity": 1})
        cart = self.client.get("/api/v1/cart").json()
        item_id = cart["items"][0]["id"]
        resp = self.client.delete(f"/api/v1/cart/items/{item_id}")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(len(resp.json()["items"]), 0)

    def test_checkout_empty_cart_409(self):
        resp = self.client.post("/api/v1/orders/checkout", {"delivery_method": "pickup"}, format="json")
        self.assertEqual(resp.status_code, 409)

    def test_checkout_creates_order(self):
        self.client.post("/api/v1/cart/items", {"product_id": self.product.pk, "quantity": 1})
        resp = self.client.post("/api/v1/orders/checkout", {"delivery_method": "pickup"}, format="json")
        self.assertIn(resp.status_code, [200, 201])
        self.assertEqual(resp.json()["status"], "pending")

    def test_order_list(self):
        self.client.post("/api/v1/cart/items", {"product_id": self.product.pk, "quantity": 1})
        self.client.post("/api/v1/orders/checkout", {"delivery_method": "pickup"}, format="json")
        resp = self.client.get("/api/v1/orders")
        self.assertEqual(resp.status_code, 200)
        self.assertGreaterEqual(len(resp.json()), 1)

    def test_unauthenticated_rejects(self):
        anon = APIClient()
        resp = anon.get("/api/v1/products")
        self.assertEqual(resp.status_code, 401)
