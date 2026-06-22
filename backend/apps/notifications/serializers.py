from rest_framework import serializers

from .models import Notification, NotificationPreference


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ["id", "title", "body", "type", "data", "is_read", "created_at"]
        read_only_fields = fields


class NotificationPreferenceSerializer(serializers.ModelSerializer):
    # Aliases used by the mobile app (FRONTEND_INTEGRATION.md):
    # booking_updates ↔ booking_reminders, loyalty ↔ loyalty_updates.
    booking_updates = serializers.BooleanField(source="booking_reminders", required=False)
    loyalty = serializers.BooleanField(source="loyalty_updates", required=False)

    class Meta:
        model = NotificationPreference
        fields = [
            "booking_reminders",
            "order_updates",
            "promotions",
            "loyalty_updates",
            "push_enabled",
            "booking_updates",
            "loyalty",
        ]
        extra_kwargs = {
            "booking_reminders": {"required": False},
            "loyalty_updates": {"required": False},
        }


class FCMTokenUpdateSerializer(serializers.Serializer):
    fcm_token = serializers.CharField(max_length=500)
