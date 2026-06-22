from django.contrib import admin

from .models import Booking, BookingSlot, SlotTemplate


@admin.register(SlotTemplate)
class SlotTemplateAdmin(admin.ModelAdmin):
    list_display = ["branch", "service", "slot_minutes", "capacity_per_slot", "active_weekdays", "is_active"]
    list_filter = ["is_active", "branch", "tenant"]
    raw_id_fields = ["branch", "service"]


@admin.register(BookingSlot)
class BookingSlotAdmin(admin.ModelAdmin):
    list_display = ["branch", "service", "date", "start_time", "end_time", "capacity_total", "capacity_left", "is_active"]
    list_filter = ["is_active", "branch", "date"]
    date_hierarchy = "date"
    search_fields = ["branch__name"]
    raw_id_fields = ["branch", "service"]


@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ["pk", "user", "service", "status", "scheduled_date", "scheduled_start", "price_charged", "location_type"]
    list_filter = ["status", "location_type", "tenant"]
    search_fields = ["user__phone", "service__name"]
    date_hierarchy = "scheduled_date"
    raw_id_fields = ["user", "service", "branch", "slot", "vehicle", "address", "assigned_staff", "payment"]
    readonly_fields = ["created_at", "updated_at", "cancelled_at"]
