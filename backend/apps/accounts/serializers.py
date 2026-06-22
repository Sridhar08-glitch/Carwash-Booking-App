"""Accounts serializers — validate input, never compute totals."""
from rest_framework import serializers

from .models import Address, CustomUser, Vehicle


# ── OTP ───────────────────────────────────────────────────────────────────────

class OTPRequestSerializer(serializers.Serializer):
    phone = serializers.RegexField(
        r"^\+?[1-9]\d{7,14}$",
        error_messages={"invalid": "Enter a valid international phone number (e.g. +966501234567)."},
    )


class OTPVerifySerializer(serializers.Serializer):
    phone = serializers.RegexField(r"^\+?[1-9]\d{7,14}$")
    code = serializers.RegexField(r"^\d{4,8}$", error_messages={"invalid": "OTP must be 4-8 digits."})


# ── Auth ──────────────────────────────────────────────────────────────────────

class TokenPairSerializer(serializers.Serializer):
    access = serializers.CharField(read_only=True)
    refresh = serializers.CharField(read_only=True)


class AuthResponseSerializer(serializers.Serializer):
    tokens = TokenPairSerializer()
    user = serializers.DictField()
    is_new = serializers.BooleanField()


class RefreshTokenSerializer(serializers.Serializer):
    refresh = serializers.CharField()


# ── Profile ───────────────────────────────────────────────────────────────────

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = [
            "id", "phone", "email", "role",
            "is_phone_verified", "locale", "date_of_birth",
            "fcm_token",
        ]
        read_only_fields = ["id", "phone", "role", "is_phone_verified"]


class UpdateProfileSerializer(serializers.Serializer):
    email = serializers.EmailField(required=False, allow_null=True)
    locale = serializers.CharField(max_length=10, required=False)
    date_of_birth = serializers.DateField(required=False, allow_null=True)
    fcm_token = serializers.CharField(required=False, allow_blank=True)


# ── Vehicles ──────────────────────────────────────────────────────────────────

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = [
            "id", "make", "model", "year", "plate", "colour",
            "vehicle_type", "notes", "is_default", "created_at",
        ]
        read_only_fields = ["id", "created_at"]

    def validate_plate(self, value):
        return value.upper().strip()


class VehicleCreateSerializer(VehicleSerializer):
    class Meta(VehicleSerializer.Meta):
        read_only_fields = ["id", "created_at"]


# ── Addresses ─────────────────────────────────────────────────────────────────

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = [
            "id", "label", "line1", "line2", "city", "state",
            "postal_code", "country", "lat", "lng", "is_default", "created_at",
        ]
        read_only_fields = ["id", "created_at"]


class AddressCreateSerializer(AddressSerializer):
    lat = serializers.DecimalField(max_digits=9, decimal_places=6, required=False, allow_null=True)
    lng = serializers.DecimalField(max_digits=9, decimal_places=6, required=False, allow_null=True)
