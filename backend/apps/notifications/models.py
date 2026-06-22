"""
Notification models.

Notification           -- in-app + push notification record per user.
NotificationTrigger    -- event -> delay -> template rule.
NotificationPreference -- per-user opt-in/out per notification type.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class Notification(TenantScopedModel):
    """
    One row per notification sent to a user.
    Written by services.py; read by the notifications list endpoint.
    """

    class Type(models.TextChoices):
        BOOKING_CONFIRMED = "booking_confirmed", "Booking Confirmed"
        BOOKING_REMINDER_24H = "booking_reminder_24h", "Booking Reminder 24h"
        BOOKING_REMINDER_1H = "booking_reminder_1h", "Booking Reminder 1h"
        BOOKING_CANCELLED = "booking_cancelled", "Booking Cancelled"
        BOOKING_COMPLETED = "booking_completed", "Booking Completed"
        ORDER_CONFIRMED = "order_confirmed", "Order Confirmed"
        ORDER_SHIPPED = "order_shipped", "Order Shipped"
        ORDER_DELIVERED = "order_delivered", "Order Delivered"
        ABANDONED_CART = "abandoned_cart", "Abandoned Cart"
        BIRTHDAY = "birthday", "Birthday"
        MEMBERSHIP_RENEWAL = "membership_renewal", "Membership Renewal"
        WEATHER_ALERT = "weather_alert", "Weather Alert"
        LOYALTY_POINTS = "loyalty_points", "Loyalty Points Earned"
        GENERAL = "general", "General"

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="notifications"
    )
    title = models.CharField(max_length=255)
    body = models.TextField()
    type = models.CharField(max_length=30, choices=Type.choices, default=Type.GENERAL, db_index=True)
    data = models.JSONField(default=dict, blank=True)
    is_read = models.BooleanField(default=False, db_index=True)
    fcm_message_id = models.CharField(max_length=200, blank=True)

    class Meta:
        db_table = "notifications_notification"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["user", "is_read"]),
            models.Index(fields=["tenant", "type"]),
        ]

    def __str__(self):
        return f"Notification({self.user_id}, {self.type}, read={self.is_read})"


class NotificationTrigger(TenantScopedModel):
    """
    Defines when and what to send for a given event.
    Evaluated by the send_due_notifications Celery task.
    """

    class Event(models.TextChoices):
        BOOKING_REMINDER_24H = "booking_reminder_24h", "Booking Reminder 24h Before"
        BOOKING_REMINDER_1H = "booking_reminder_1h", "Booking Reminder 1h Before"
        ABANDONED_CART = "abandoned_cart", "Abandoned Cart"
        BIRTHDAY = "birthday", "Birthday"
        MEMBERSHIP_RENEWAL = "membership_renewal", "Membership Renewal"
        WEATHER_ALERT = "weather_alert", "Weather Alert"

    event = models.CharField(max_length=30, choices=Event.choices, db_index=True)
    offset_hours = models.IntegerField(default=0)
    title_template = models.CharField(max_length=255)
    body_template = models.TextField()
    is_active = models.BooleanField(default=True, db_index=True)

    class Meta:
        db_table = "notifications_trigger"
        unique_together = [("tenant", "event")]

    def __str__(self):
        return f"NotificationTrigger({self.event}, offset={self.offset_hours}h)"


class NotificationPreference(TenantScopedModel):
    """Per-user opt-in/out settings. Defaults: all ON if no row exists."""

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="notification_prefs",
    )
    booking_reminders = models.BooleanField(default=True)
    order_updates = models.BooleanField(default=True)
    promotions = models.BooleanField(default=True)
    loyalty_updates = models.BooleanField(default=True)
    push_enabled = models.BooleanField(default=True)

    class Meta:
        db_table = "notifications_preference"

    def __str__(self):
        return f"NotificationPreference(user={self.user_id})"
