from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from .models import Address, CustomerProfile, CustomUser, OTPCode, StaffProfile, Vehicle


@admin.register(CustomUser)
class CustomUserAdmin(BaseUserAdmin):
    list_display = ["phone", "email", "role", "tenant", "is_phone_verified", "is_active", "date_joined"]
    list_filter = ["role", "is_phone_verified", "is_active", "is_deleted", "tenant"]
    search_fields = ["phone", "email", "username"]
    fieldsets = BaseUserAdmin.fieldsets + (  # type: ignore[operator]
        (
            "App Fields",
            {
                "fields": (
                    "tenant", "phone", "role", "is_phone_verified",
                    "fcm_token", "locale", "date_of_birth",
                    "is_deleted", "deleted_at",
                )
            },
        ),
    )
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("phone", "username", "tenant", "role", "password1", "password2"),
            },
        ),
    )
    ordering = ["-date_joined"]


@admin.register(CustomerProfile)
class CustomerProfileAdmin(admin.ModelAdmin):
    list_display = ["user", "referral_code", "points_cache"]
    search_fields = ["user__phone", "referral_code"]
    raw_id_fields = ["user", "default_address"]


@admin.register(StaffProfile)
class StaffProfileAdmin(admin.ModelAdmin):
    list_display = ["user", "branch", "is_available", "rating_avg", "jobs_completed"]
    list_filter = ["is_available", "branch"]
    raw_id_fields = ["user", "branch"]


@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ["user", "make", "model", "year", "plate", "vehicle_type", "is_default"]
    search_fields = ["plate", "user__phone", "make", "model"]
    list_filter = ["vehicle_type", "is_deleted"]
    raw_id_fields = ["user"]


@admin.register(Address)
class AddressAdmin(admin.ModelAdmin):
    list_display = ["user", "label", "city", "is_default", "is_deleted"]
    search_fields = ["user__phone", "city", "line1"]
    list_filter = ["country", "is_default", "is_deleted"]
    raw_id_fields = ["user"]


@admin.register(OTPCode)
class OTPCodeAdmin(admin.ModelAdmin):
    list_display = ["phone", "used", "attempts", "expires_at", "created_at"]
    list_filter = ["used"]
    search_fields = ["phone"]
    readonly_fields = ["code_hash", "created_at"]
