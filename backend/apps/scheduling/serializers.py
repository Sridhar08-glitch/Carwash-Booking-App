from rest_framework import serializers

from apps.catalog.serializers import BranchSerializer, ServiceSerializer

from .models import Booking, BookingSlot, RecurringBookingRule


class BookingSlotSerializer(serializers.ModelSerializer):
    branch = BranchSerializer(read_only=True)
    service = ServiceSerializer(read_only=True)
    is_available = serializers.BooleanField(read_only=True)

    class Meta:
        model = BookingSlot
        fields = ["id", "branch", "service", "date", "start_time", "end_time",
                  "capacity_total", "capacity_left", "is_available"]


class BookingPaymentSummarySerializer(serializers.Serializer):
    """Flat payment summary consumed by the mobile app."""

    id = serializers.IntegerField(read_only=True)
    method = serializers.CharField(read_only=True)
    status = serializers.CharField(read_only=True)
    client_secret = serializers.CharField(source="stripe_client_secret", read_only=True, allow_blank=True)


class BookingSerializer(serializers.ModelSerializer):
    service = ServiceSerializer(read_only=True)
    slot = BookingSlotSerializer(read_only=True)
    # ── Flat fields consumed by the mobile app (see FRONTEND_INTEGRATION.md) ──
    payment = BookingPaymentSummarySerializer(read_only=True)
    service_name = serializers.CharField(source="service.name", read_only=True)
    branch_name = serializers.CharField(source="branch.name", read_only=True, default=None)
    vehicle_plate = serializers.CharField(source="vehicle.plate", read_only=True, default=None)
    slot_date = serializers.DateField(source="slot.date", read_only=True)
    slot_start_time = serializers.TimeField(source="slot.start_time", read_only=True)
    can_cancel = serializers.SerializerMethodField()
    can_reschedule = serializers.SerializerMethodField()

    _NON_CANCELLABLE = {"completed", "cancelled", "no_show"}
    _RESCHEDULABLE = {"pending", "confirmed"}

    class Meta:
        model = Booking
        fields = [
            "id", "service", "slot", "status", "location_type",
            "price_charged", "currency", "scheduled_date", "scheduled_start",
            "vehicle_id", "address_id", "assigned_staff_id",
            "cancellation_reason", "cancelled_at", "created_at", "updated_at",
            "payment", "service_name", "branch_name", "vehicle_plate",
            "slot_date", "slot_start_time", "can_cancel", "can_reschedule",
        ]
        read_only_fields = fields

    def get_can_cancel(self, obj) -> bool:
        return obj.status not in self._NON_CANCELLABLE

    def get_can_reschedule(self, obj) -> bool:
        return obj.status in self._RESCHEDULABLE


class BookingCreateSerializer(serializers.Serializer):
    service_id = serializers.IntegerField()
    slot_id = serializers.IntegerField()
    vehicle_id = serializers.IntegerField(required=False, allow_null=True)
    location_type = serializers.ChoiceField(choices=Booking.LocationType.choices, default="branch")
    address_id = serializers.IntegerField(required=False, allow_null=True)
    mobile_lat = serializers.DecimalField(max_digits=9, decimal_places=6, required=False, allow_null=True)
    mobile_lng = serializers.DecimalField(max_digits=9, decimal_places=6, required=False, allow_null=True)
    payment_method = serializers.ChoiceField(
        choices=["card", "wallet", "cash"], default="cash"
    )
    idempotency_key = serializers.CharField(max_length=255, required=False, default="")


class BookingCancelSerializer(serializers.Serializer):
    reason = serializers.CharField(max_length=500, required=False, default="", allow_blank=True)


class BookingRescheduleSerializer(serializers.Serializer):
    slot_id = serializers.IntegerField()


class RecurringRuleSerializer(serializers.ModelSerializer):
    service = ServiceSerializer(read_only=True)
    branch = BranchSerializer(read_only=True)

    class Meta:
        model = RecurringBookingRule
        fields = [
            "id", "service", "branch", "frequency", "preferred_weekday",
            "preferred_time", "location_type", "address_id", "vehicle_id",
            "default_payment_method", "is_active", "last_booking_date",
            "created_at", "updated_at",
        ]
        read_only_fields = ["id", "service", "branch", "last_booking_date", "created_at", "updated_at"]


class RecurringRuleCreateSerializer(serializers.Serializer):
    service_id = serializers.IntegerField()
    branch_id = serializers.IntegerField(required=False, allow_null=True)
    frequency = serializers.ChoiceField(choices=RecurringBookingRule.Frequency.choices)
    preferred_weekday = serializers.IntegerField(min_value=0, max_value=6)
    preferred_time = serializers.TimeField()
    location_type = serializers.ChoiceField(choices=["branch", "mobile"], default="branch")
    address_id = serializers.IntegerField(required=False, allow_null=True)
    vehicle_id = serializers.IntegerField(required=False, allow_null=True)
    default_payment_method = serializers.ChoiceField(
        choices=["wallet", "card", "cash"], default="wallet"
    )
