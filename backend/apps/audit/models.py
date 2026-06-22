"""
Audit models.

AuditLog          — immutable record of every state-change on key business objects.
IdempotencyRecord — deduplication table for idempotent endpoints.
"""
from django.conf import settings
from django.db import models


class AuditLog(models.Model):
    """
    Immutable audit trail.

    One row per create/state-change on: Booking, Order, Payment, Subscription.
    Written by Django signals in apps.audit.signals.
    Never soft-deleted — these records are compliance data.
    """

    actor = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="audit_logs",
    )
    action = models.CharField(max_length=100, db_index=True)  # e.g. "booking.created"
    target_type = models.CharField(max_length=50, db_index=True)  # e.g. "booking"
    target_id = models.BigIntegerField(db_index=True)
    before = models.JSONField(null=True, blank=True)  # state before change
    after = models.JSONField(null=True, blank=True)   # state after change
    meta = models.JSONField(null=True, blank=True)    # extra context (IP, request_id, etc.)
    timestamp = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "audit_log"
        ordering = ["-timestamp"]
        indexes = [
            models.Index(fields=["target_type", "target_id"]),
            models.Index(fields=["actor", "timestamp"]),
        ]

    def __str__(self) -> str:
        return f"AuditLog({self.action}, target={self.target_type}#{self.target_id})"


class IdempotencyRecord(models.Model):
    """
    Stores the original response for idempotent requests.

    Key uniqueness: (key, endpoint).
    Replay: return stored response without re-executing.
    TTL: cleaned up by `expire_idempotency_records` Celery task (Phase 2).
    """

    key = models.CharField(max_length=255, db_index=True)
    endpoint = models.CharField(max_length=500)
    response_payload = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "audit_idempotency_record"
        unique_together = [("key", "endpoint")]

    def __str__(self) -> str:
        return f"IdempotencyRecord({self.key[:20]}, {self.endpoint})"
