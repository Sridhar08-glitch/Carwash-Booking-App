"""
Catalog models: services the business offers + branch configuration.
"""
from django.contrib.postgres.fields import ArrayField
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models

from apps.common.models import TenantScopedModel


class ServiceCategory(TenantScopedModel):
    """Top-level grouping for services (e.g. Interior, Exterior, Full Detail)."""

    name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=100)
    description = models.TextField(blank=True)
    ordering = models.PositiveSmallIntegerField(default=0)
    is_active = models.BooleanField(default=True, db_index=True)

    class Meta:
        db_table = "catalog_service_category"
        unique_together = [("tenant", "slug")]
        ordering = ["ordering", "name"]

    def __str__(self) -> str:
        return self.name


class Service(TenantScopedModel):
    """
    A single wash/detail service offered by the business.

    `tags` are free-form strings used by the rule engine (Phase 4)
    to recommend services (e.g. "pet_hair", "stain", "interior", "express").
    """

    category = models.ForeignKey(
        ServiceCategory, on_delete=models.PROTECT, related_name="services"
    )
    name = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200)
    description = models.TextField(blank=True)
    # Money — stored as Decimal, never float
    base_price = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default="SAR")
    duration_minutes = models.PositiveSmallIntegerField(default=60)
    image = models.ImageField(upload_to="services/", null=True, blank=True)
    # Array of tag strings for recommendations / dynamic pricing (Phase 4)
    tags = ArrayField(models.CharField(max_length=50), default=list, blank=True)
    is_active = models.BooleanField(default=True, db_index=True)
    # Controls whether this service is available for at-home/mobile bookings
    is_mobile_available = models.BooleanField(default=True)

    class Meta:
        db_table = "catalog_service"
        unique_together = [("tenant", "slug")]
        indexes = [
            models.Index(fields=["tenant", "is_active"]),
            models.Index(fields=["category", "is_active"]),
        ]

    def __str__(self) -> str:
        return self.name


class Branch(TenantScopedModel):
    """
    A physical car-wash location.
    Phase 1: single branch.
    Phase 4: multi-branch (add per-branch pricing, staff assignment, etc.).
    """

    name = models.CharField(max_length=200)
    address = models.CharField(max_length=500)
    city = models.CharField(max_length=100)
    lat = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    lng = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    # IANA timezone (e.g. "Asia/Riyadh") — all slot times are in this tz
    timezone = models.CharField(max_length=50, default="Asia/Riyadh")
    phone = models.CharField(max_length=20, blank=True)
    is_active = models.BooleanField(default=True, db_index=True)

    class Meta:
        db_table = "catalog_branch"
        indexes = [models.Index(fields=["tenant", "is_active"])]

    def __str__(self) -> str:
        return self.name


class BranchHours(models.Model):
    """
    Opening hours for a branch per day of the week.
    weekday: 0=Monday … 6=Sunday (Python convention).
    """

    branch = models.ForeignKey(Branch, on_delete=models.CASCADE, related_name="hours")
    weekday = models.PositiveSmallIntegerField(
        validators=[MinValueValidator(0), MaxValueValidator(6)]
    )
    open_time = models.TimeField()
    close_time = models.TimeField()
    is_closed = models.BooleanField(default=False)  # explicit holiday / closure

    class Meta:
        db_table = "catalog_branch_hours"
        unique_together = [("branch", "weekday")]
        ordering = ["weekday"]

    def __str__(self) -> str:
        days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return f"{self.branch.name} {days[self.weekday]} {self.open_time}-{self.close_time}"
