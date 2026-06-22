"""
Shop service layer.

cart_add_item       -- add or update an item in the cart.
cart_remove_item    -- remove an item.
cart_apply_promo    -- validate and attach a promo code.
checkout            -- create an Order from the cart, compute totals (server-side),
                       create a Payment record; stock decremented on payment success.

Stock-decrement invariant
-------------------------
Stock is decremented ONLY when the payment succeeds (webhook handler in payments/services.py
calls confirm_order_payment). The checkout service creates the Order in PENDING state
without touching stock. This avoids holding inventory against unpaid carts.
"""
from __future__ import annotations

import logging
from decimal import Decimal

from django.db import models as dj_models
from django.db import transaction
from django.utils import timezone

from apps.common.errors import ConflictError, NotFoundError

logger = logging.getLogger(__name__)


# -- Cart -----------------------------------------------------------------------

@transaction.atomic
def cart_add_item(*, user, product_id: int, quantity: int = 1):
    from .models import Cart, CartItem, Product

    product = Product.objects.filter(pk=product_id, tenant=user.tenant, is_active=True).first()
    if product is None:
        raise NotFoundError("Product not found.")

    cart, _ = Cart.objects.get_or_create(
        user=user, defaults={"tenant": user.tenant}
    )

    item, created = CartItem.objects.get_or_create(
        cart=cart, product=product, defaults={"quantity": quantity}
    )
    if not created:
        item.quantity += quantity
        item.save(update_fields=["quantity"])
    return item


@transaction.atomic
def cart_update_item(*, user, item_id: int, quantity: int):
    from .models import Cart, CartItem

    cart = Cart.objects.filter(user=user).first()
    if cart is None:
        raise NotFoundError("Cart not found.")
    item = CartItem.objects.filter(cart=cart, pk=item_id).first()
    if item is None:
        raise NotFoundError("Cart item not found.")
    if quantity <= 0:
        item.delete()
        return item
    item.quantity = quantity
    item.save(update_fields=["quantity"])
    return item


@transaction.atomic
def cart_remove_item(*, user, item_id: int) -> None:
    from .models import Cart, CartItem

    cart = Cart.objects.filter(user=user).first()
    if cart is None:
        return
    CartItem.objects.filter(cart=cart, pk=item_id).delete()


@transaction.atomic
def cart_apply_promo(*, user, code: str):
    from apps.payments.models import PromoCode
    from .models import Cart

    cart = Cart.objects.filter(user=user).prefetch_related("items__product").first()
    if cart is None:
        raise NotFoundError("Cart is empty.")

    promo = PromoCode.objects.filter(
        tenant=user.tenant, code=code.upper(), is_active=True
    ).first()
    if promo is None:
        raise ConflictError("Promo code not found or expired.", code="PROMO_INVALID")

    now = timezone.now()
    if now < promo.valid_from or now > promo.valid_until:
        raise ConflictError("Promo code is not currently valid.", code="PROMO_EXPIRED")

    if promo.usage_limit and promo.used_count >= promo.usage_limit:
        raise ConflictError("Promo code usage limit reached.", code="PROMO_EXHAUSTED")

    subtotal = cart.subtotal
    if subtotal < promo.min_spend:
        raise ConflictError(
            f"Minimum spend of {promo.min_spend} required.",
            code="PROMO_MIN_SPEND",
        )

    cart.promo_code = promo
    cart.save(update_fields=["promo_code"])
    return cart


# -- Checkout ------------------------------------------------------------------

@transaction.atomic
def checkout(
    *,
    user,
    delivery_method: str = "pickup",
    shipping_address_id: int | None = None,
    idempotency_key: str = "",
):
    """
    Create an Order from the user's cart.

    1. Validate cart is not empty.
    2. Compute totals server-side (never trust client).
    3. Apply promo discount.
    4. Create Order + OrderItems (status=pending, stock NOT yet decremented).
    5. Create Payment record.
    6. Stock decremented later inside confirm_order_payment() on Stripe webhook.
    """
    from apps.payments.models import Payment
    from .models import Cart, Order, OrderItem

    # Idempotency
    if idempotency_key:
        existing = Order.all_objects.filter(idempotency_key=idempotency_key, user=user).first()
        if existing:
            return existing

    cart = (
        Cart.objects.filter(user=user)
        .prefetch_related("items__product", "promo_code")
        .first()
    )
    if not cart or not cart.items.exists():
        raise ConflictError("Your cart is empty.", code="CART_EMPTY")

    items = list(cart.items.select_related("product"))
    for ci in items:
        if not ci.product.is_active:
            raise ConflictError(f"Item '{ci.product.name}' is no longer available.")

    # Compute totals server-side
    subtotal = sum(ci.line_total for ci in items)
    currency = items[0].product.currency

    discount = Decimal("0")
    if cart.promo_code:
        promo = cart.promo_code
        if promo.discount_type == "percent":
            discount = (subtotal * promo.value / Decimal("100")).quantize(Decimal("0.01"))
        else:
            discount = min(promo.value, subtotal)

    shipping_fee = Decimal("0")
    if delivery_method == "delivery":
        shipping_fee = Decimal("15.00")  # configurable per branch/zone in Phase 4

    total = subtotal - discount + shipping_fee

    shipping_address = None
    if delivery_method == "delivery":
        if not shipping_address_id:
            raise ConflictError("A shipping address is required for home delivery.")
        from apps.accounts.models import Address
        shipping_address = Address.objects.filter(pk=shipping_address_id, user=user).first()
        if shipping_address is None:
            raise NotFoundError("Shipping address not found.")

    payment = Payment.objects.create(
        tenant=user.tenant,
        user=user,
        amount=total,
        currency=currency,
        method=Payment.Method.CARD,
        status=Payment.Status.PENDING,
        idempotency_key=idempotency_key,
    )

    order = Order.objects.create(
        tenant=user.tenant,
        user=user,
        status=Order.Status.PENDING,
        delivery_method=delivery_method,
        shipping_address=shipping_address,
        subtotal=subtotal,
        discount=discount,
        shipping_fee=shipping_fee,
        total=total,
        currency=currency,
        promo_code=cart.promo_code,
        payment=payment,
        idempotency_key=idempotency_key,
    )

    OrderItem.objects.bulk_create([
        OrderItem(
            order=order,
            product=ci.product,
            quantity=ci.quantity,
            unit_price=ci.product.price,  # snapshot -- never recomputed
        )
        for ci in items
    ])

    if cart.promo_code:
        from apps.payments.models import PromoCode
        PromoCode.objects.filter(pk=cart.promo_code_id).update(
            used_count=dj_models.F("used_count") + 1
        )

    logger.info("Order created: id=%s user=%s total=%s", order.pk, user.pk, total)
    return order


@transaction.atomic
def confirm_order_payment(*, order_id: int):
    """
    Called by the Stripe webhook on payment_intent.succeeded.

    Atomically:
    1. Mark Order PAID.
    2. Decrement stock for each OrderItem under select_for_update() -- no oversell.
    3. Clear the user's cart.

    Idempotent: if order is already PAID returns without re-processing.
    """
    from .models import Cart, Order, OrderItem, Product

    order = (
        Order.objects.select_for_update()
        .filter(pk=order_id, status=Order.Status.PENDING)
        .first()
    )
    if order is None:
        return Order.objects.filter(pk=order_id).first()

    items = OrderItem.objects.filter(order=order).select_related("product")
    for item in items:
        product = Product.objects.select_for_update().get(pk=item.product_id)
        if product.track_inventory:
            if product.stock < item.quantity:
                logger.error(
                    "Stock insufficient for product %s at confirmation: have=%s need=%s",
                    product.pk, product.stock, item.quantity,
                )
            product.stock = max(0, product.stock - item.quantity)
            product.save(update_fields=["stock", "updated_at"])

    order.status = Order.Status.PAID
    order.save(update_fields=["status", "updated_at"])

    Cart.objects.filter(user_id=order.user_id).delete()

    logger.info("Order confirmed (paid): id=%s", order.pk)
    return order
