"""
Shared base models.

BaseModel  — soft-delete + timestamps; all business models inherit this.
Tenant     — top-level isolation unit; every business model has a tenant FK.
            Postgres RLS enforces isolation at the DB level (see rls.py).
"""
import uuid

from django.db import models
from django.utils import timezone


class BaseModel(models.Model):
    """
    Abstract base for all business models.

    Fields
    ------
    created_at  : datetime  — set on INSERT, never updated
    updated_at  : datetime  — updated on every SAVE
    is_deleted  : bool      — soft-delete flag; filtered by SoftDeleteManager
    deleted_at  : datetime  — timestamp of soft-delete
    """

    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_deleted = models.BooleanField(default=False, db_index=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        abstract = True

    def soft_delete(self, *, commit: bool = True) -> None:
        """Mark the record as deleted without removing it from the DB."""
        self.is_deleted = True
        self.deleted_at = timezone.now()
        if commit:
            self.save(update_fields=["is_deleted", "deleted_at", "updated_at"])

    def restore(self, *, commit: bool = True) -> None:
        """Reverse a soft-delete."""
        self.is_deleted = False
        self.deleted_at = None
        if commit:
            self.save(update_fields=["is_deleted", "deleted_at", "updated_at"])


class SoftDeleteManager(models.Manager):
    """Default manager that excludes soft-deleted records."""

    def get_queryset(self):
        return super().get_queryset().filter(is_deleted=False)


class AllObjectsManager(models.Manager):
    """Manager that includes soft-deleted records (for admin / audit)."""

    def get_queryset(self):
        return super().get_queryset()


# ── Tenant ────────────────────────────────────────────────────────────────────

class Tenant(models.Model):
    """
    Top-level isolation unit for multi-tenant RLS.

    Each deployment starts with a single Tenant row.
    Postgres RLS policies (in migrations) enforce that app queries
    only see rows where tenant_id = current_setting('app.current_tenant').

    Design notes
    ------------
    * id is a UUID so tenant IDs in DB session variables are unguessable.
    * Tenant itself is NOT tenant-scoped (it lives outside RLS).
    * The app-DB user has no BYPASSRLS privilege; admin uses a separate
      migration/superuser connection to manage tenants.
    """

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    slug = models.SlugField(unique=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "common_tenant"

    def __str__(self) -> str:
        return self.name


class TenantScopedModel(BaseModel):
    """
    Abstract base for models that belong to a Tenant.

    All child models get:
    - tenant FK (indexed)
    - Standard SoftDelete behaviour from BaseModel
    - RLS enforcement via TenantMiddleware + DB policies
    """

    tenant = models.ForeignKey(
        Tenant,
        on_delete=models.CASCADE,
        related_name="+",
        db_index=True,
    )

    class Meta:
        abstract = True

    # Use SoftDelete as default; AllObjects available as .all_objects
    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()
