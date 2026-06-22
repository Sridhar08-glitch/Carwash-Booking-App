"""
Reusable ViewSet mixins.

SoftDeleteMixin       — overrides destroy() to call obj.soft_delete()
TenantQuerySetMixin   — scopes every queryset to request.user.tenant
IdempotencyMixin      — dedupes create requests via Idempotency-Key header
"""
import hashlib
import json
import logging

from django.utils import timezone
from rest_framework import status
from rest_framework.response import Response

logger = logging.getLogger(__name__)


class SoftDeleteMixin:
    """
    Replace the default hard-delete destroy() with a soft-delete.
    The object's `soft_delete()` method (from BaseModel) is called.
    """

    def perform_destroy(self, instance):
        instance.soft_delete()


class TenantQuerySetMixin:
    """
    Auto-scope querysets to the current user's tenant.

    The view must define `queryset` normally; this mixin filters it to
    the authenticated user's tenant_id before any other filtering.

    Defence-in-depth: RLS already handles this at the DB level; this mixin
    provides application-layer protection and clearer error messages.
    """

    def get_queryset(self):
        qs = super().get_queryset()
        user = self.request.user
        if user.is_authenticated and hasattr(user, "tenant_id"):
            return qs.filter(tenant_id=user.tenant_id)
        return qs.none()


class IdempotencyMixin:
    """
    Dedupe POST create requests using the Idempotency-Key header.

    If a stored response for (key, endpoint) is found, return it
    immediately without re-executing the create logic.

    The view must call `self.check_idempotency()` as the first line of
    `create()`, and `self.store_idempotency(key, response)` before returning.
    """

    IDEMPOTENCY_HEADER = "Idempotency-Key"

    def _get_idempotency_key(self) -> str | None:
        return self.request.headers.get(self.IDEMPOTENCY_HEADER)

    def check_idempotency(self):
        """
        Return a cached Response if the key has been seen, else None.
        Import here to avoid circular imports.
        """
        key = self._get_idempotency_key()
        if not key:
            return None

        from apps.audit.models import IdempotencyRecord

        endpoint = self.request.path
        record = IdempotencyRecord.objects.filter(key=key, endpoint=endpoint).first()
        if record:
            logger.info("Idempotency replay: key=%s endpoint=%s", key, endpoint)
            return Response(record.response_payload, status=status.HTTP_200_OK)
        return None

    def store_idempotency(self, response: Response) -> None:
        """Persist the response for future replays."""
        key = self._get_idempotency_key()
        if not key:
            return

        from apps.audit.models import IdempotencyRecord

        endpoint = self.request.path
        IdempotencyRecord.objects.get_or_create(
            key=key,
            endpoint=endpoint,
            defaults={"response_payload": response.data},
        )
