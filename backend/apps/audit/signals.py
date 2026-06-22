"""
Django signals that write AuditLog rows.

Wired on: Booking, Payment, Order.
Every create/state-change creates one immutable AuditLog entry.
"""
import logging

from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver

logger = logging.getLogger(__name__)


def _log(*, actor_id, action, target_type, target_id, before=None, after=None):
    from apps.audit.models import AuditLog
    try:
        AuditLog.objects.create(
            actor_id=actor_id,
            action=action,
            target_type=target_type,
            target_id=target_id,
            before=before,
            after=after,
        )
    except Exception as exc:
        logger.exception("AuditLog write failed: %s", exc)


# -- Booking ------------------------------------------------------------------

@receiver(pre_save, sender="scheduling.Booking")
def booking_pre_save(sender, instance, **kwargs):
    if instance.pk:
        try:
            old = sender.objects.only("status").get(pk=instance.pk)
            instance._old_status = old.status
        except sender.DoesNotExist:
            instance._old_status = None
    else:
        instance._old_status = None


@receiver(post_save, sender="scheduling.Booking")
def booking_post_save(sender, instance, created, **kwargs):
    old_status = getattr(instance, "_old_status", None)
    if created:
        _log(
            actor_id=instance.user_id,
            action="booking.created",
            target_type="booking",
            target_id=instance.pk,
            after={"status": instance.status, "slot_id": instance.slot_id, "price": str(instance.price_charged)},
        )
    elif old_status and old_status != instance.status:
        _log(
            actor_id=getattr(instance, "_actor_id", instance.user_id),
            action=f"booking.status_changed.{instance.status}",
            target_type="booking",
            target_id=instance.pk,
            before={"status": old_status},
            after={"status": instance.status},
        )


# -- Payment ------------------------------------------------------------------

@receiver(pre_save, sender="payments.Payment")
def payment_pre_save(sender, instance, **kwargs):
    if instance.pk:
        try:
            old = sender.objects.only("status").get(pk=instance.pk)
            instance._old_payment_status = old.status
        except sender.DoesNotExist:
            instance._old_payment_status = None
    else:
        instance._old_payment_status = None


@receiver(post_save, sender="payments.Payment")
def payment_post_save(sender, instance, created, **kwargs):
    old_status = getattr(instance, "_old_payment_status", None)
    if created:
        _log(
            actor_id=instance.user_id,
            action="payment.created",
            target_type="payment",
            target_id=instance.pk,
            after={"status": instance.status, "amount": str(instance.amount), "method": instance.method},
        )
    elif old_status and old_status != instance.status:
        _log(
            actor_id=instance.user_id,
            action=f"payment.status_changed.{instance.status}",
            target_type="payment",
            target_id=instance.pk,
            before={"status": old_status},
            after={"status": instance.status},
        )


# -- Order --------------------------------------------------------------------

@receiver(pre_save, sender="shop.Order")
def order_pre_save(sender, instance, **kwargs):
    if instance.pk:
        try:
            old = sender.objects.only("status").get(pk=instance.pk)
            instance._old_order_status = old.status
        except sender.DoesNotExist:
            instance._old_order_status = None
    else:
        instance._old_order_status = None


@receiver(post_save, sender="shop.Order")
def order_post_save(sender, instance, created, **kwargs):
    old_status = getattr(instance, "_old_order_status", None)
    if created:
        _log(
            actor_id=instance.user_id,
            action="order.created",
            target_type="order",
            target_id=instance.pk,
            after={
                "status": instance.status,
                "total": str(instance.total),
                "currency": instance.currency,
                "delivery_method": instance.delivery_method,
            },
        )
    elif old_status and old_status != instance.status:
        _log(
            actor_id=getattr(instance, "_actor_id", instance.user_id),
            action=f"order.status_changed.{instance.status}",
            target_type="order",
            target_id=instance.pk,
            before={"status": old_status},
            after={"status": instance.status},
        )


# -- UserSubscription ---------------------------------------------------------

@receiver(pre_save, sender="loyalty.UserSubscription")
def subscription_pre_save(sender, instance, **kwargs):
    if instance.pk:
        try:
            old = sender.objects.only("status").get(pk=instance.pk)
            instance._old_sub_status = old.status
        except sender.DoesNotExist:
            instance._old_sub_status = None
    else:
        instance._old_sub_status = None


@receiver(post_save, sender="loyalty.UserSubscription")
def subscription_post_save(sender, instance, created, **kwargs):
    old_status = getattr(instance, "_old_sub_status", None)
    if created:
        _log(
            actor_id=instance.user_id,
            action="subscription.created",
            target_type="subscription",
            target_id=instance.pk,
            after={
                "status": instance.status,
                "plan_id": instance.plan_id,
                "stripe_subscription_id": instance.stripe_subscription_id,
            },
        )
    elif old_status and old_status != instance.status:
        _log(
            actor_id=instance.user_id,
            action=f"subscription.status_changed.{instance.status}",
            target_type="subscription",
            target_id=instance.pk,
            before={"status": old_status},
            after={"status": instance.status},
        )
