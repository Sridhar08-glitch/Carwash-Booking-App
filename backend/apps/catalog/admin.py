from django.contrib import admin

from .models import Branch, BranchHours, Service, ServiceCategory


class BranchHoursInline(admin.TabularInline):
    model = BranchHours
    extra = 7  # one row per day of week
    fields = ["weekday", "open_time", "close_time", "is_closed"]


@admin.register(Branch)
class BranchAdmin(admin.ModelAdmin):
    list_display = ["name", "city", "timezone", "is_active", "tenant"]
    list_filter = ["is_active", "tenant"]
    search_fields = ["name", "city"]
    inlines = [BranchHoursInline]


@admin.register(ServiceCategory)
class ServiceCategoryAdmin(admin.ModelAdmin):
    list_display = ["name", "slug", "ordering", "is_active", "tenant"]
    list_filter = ["is_active", "tenant"]
    prepopulated_fields = {"slug": ("name",)}
    search_fields = ["name"]


@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ["name", "category", "base_price", "currency", "duration_minutes", "is_active", "tenant"]
    list_filter = ["is_active", "category", "tenant"]
    search_fields = ["name", "description"]
    prepopulated_fields = {"slug": ("name",)}
    readonly_fields = ["created_at", "updated_at"]

    def get_fields(self, request, obj=None):
        fields = super().get_fields(request, obj)
        return fields
