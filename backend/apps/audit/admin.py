from django.contrib import admin

from .models import AuditLog, IdempotencyRecord


@admin.register(AuditLog)
class AuditLogAdmin(admin.ModelAdmin):
    list_display = ["action", "target_type", "target_id", "actor", "timestamp"]
    list_filter = ["action", "target_type"]
    search_fields = ["action", "target_type", "actor__phone"]
    date_hierarchy = "timestamp"
    readonly_fields = ["actor", "action", "target_type", "target_id", "before", "after", "meta", "timestamp"]

    def has_add_permission(self, request):
        return False  # Audit logs are immutable

    def has_change_permission(self, request, obj=None):
        return False


@admin.register(IdempotencyRecord)
class IdempotencyRecordAdmin(admin.ModelAdmin):
    list_display = ["key", "endpoint", "created_at"]
    search_fields = ["key", "endpoint"]
    readonly_fields = ["key", "endpoint", "response_payload", "created_at"]
