"""
Accounts models.

CustomUser      — extends AbstractUser; phone as primary identifier.
CustomerProfile — one-to-one with customer users.
StaffProfile    — one-to-one with staff users.
Vehicle         — a customer's registered vehicles.
Address         — customer saved addresses (for mobile/at-home bookings).
OTPCode         — phone OTP for passwordless auth.
"""
import hashlib
import uuid
from datetime import timedelta

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils import timezone

from apps.common.models import BaseModel, SoftDeleteManager, AllObjectsManager, TenantScopedModel


# ── User ─────────────────────────────────────────────────────────────────────

class CustomUser(AbstractUser):
    """
    Custom user model.

    Phone is the primary identifier (used for OTP login).
    Email is optional but unique when provided.
    Username is kept for Django admin compatibility but not exposed in API.
    """

    class Role(models.TextChoices):
        CUSTOMER = "customer", "Customer"
        STAFF = "staff", "Staff"
        ADMIN = "admin", "Admin"

    # ── Tenant link (all users belong to a tenant) ────────────────────────────
    tenant = models.ForeignKey(
        "common.Tenant",
        on_delete=models.CASCADE,
        null=True,          # null until first login completes tenant resolution
        blank=True,
        db_index=True,
        related_name="users",
    )

    # ── Identity ──────────────────────────────────────────────────────────────
    phone = models.CharField(max_length=20, unique=True)
    email = models.EmailField(blank=True, null=True, unique=True)
    role = models.CharField(max_length=10, choices=Role.choices, default=Role.CUSTOMER)
    is_phone_verified = models.BooleanField(default=False)

    # ── Push notifications ────────────────────────────────────────────────────
    fcm_token = models.TextField(blank=True, default="")

    # ── i18n / personalisation ────────────────────────────────────────────────
    locale = models.CharField(max_length=10, default="en")
    date_of_birth = models.DateField(null=True, blank=True)

    # ── Soft-delete timestamps ────────────────────────────────────────────────
    is_deleted = models.BooleanField(default=False, db_index=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    USERNAME_FIELD = "phone"
    REQUIRED_FIELDS = ["username"]

    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()

    class Meta:
        db_table = "accounts_customuser"
        indexes = [
            models.Index(fields=["tenant", "phone"]),
            models.Index(fields=["tenant", "role"]),
        ]

    def __str__(self) -> str:
        return self.phone

    def soft_delete(self, *, commit: bool = True) -> None:
        self.is_deleted = True
        self.deleted_at = timezone.now()
        self.is_active = False
        if commit:
            self.save(update_fields=["is_deleted", "deleted_at", "is_active"])


# ── Profiles ─────────────────────────────────────────────────────────────────

class CustomerProfile(models.Model):
    """Extended data for customers."""

    user = models.OneToOneField(
        CustomUser, on_delete=models.CASCADE, related_name="customer_profile"
    )
    referral_code = models.CharField(max_length=20, unique=True, blank=True)
    points_cache = models.PositiveIntegerField(default=0)  # denormalised from loyalty
    default_address = models.ForeignKey(
        "accounts.Address",
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="+",
    )

    class Meta:
        db_table = "accounts_customer_profile"

    def __str__(self) -> str:
        return f"CustomerProfile({self.user_id})"

    def save(self, *args, **kwargs):
        if not self.referral_code:
            self.referral_code = self._generate_code()
        super().save(*args, **kwargs)

    @staticmethod
    def _generate_code() -> str:
        # secrets.token_urlsafe uses os.urandom — cryptographically secure.
        # 6 bytes → 8 base64url characters (uppercase-safe after conversion).
        import secrets
        # token_urlsafe(6) returns an 8-char base64url string; make uppercase
        # and strip padding to keep the format consistent with the old codes.
        return secrets.token_urlsafe(6).upper()[:8]


class StaffProfile(models.Model):
    """Extended data for staff members."""

    user = models.OneToOneField(
        CustomUser, on_delete=models.CASCADE, related_name="staff_profile"
    )
    branch = models.ForeignKey(
        "catalog.Branch",
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="staff_members",
    )
    is_available = models.BooleanField(default=True)
    rating_avg = models.DecimalField(max_digits=3, decimal_places=2, default=0)
    jobs_completed = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = "accounts_staff_profile"

    def __str__(self) -> str:
        return f"StaffProfile({self.user_id})"


# ── Vehicles ──────────────────────────────────────────────────────────────────

class Vehicle(BaseModel):
    """A customer's registered vehicle."""

    class VehicleType(models.TextChoices):
        SEDAN = "sedan", "Sedan"
        SUV = "suv", "SUV"
        TRUCK = "truck", "Truck"
        VAN = "van", "Van"
        HATCHBACK = "hatchback", "Hatchback"
        COUPE = "coupe", "Coupe"
        CONVERTIBLE = "convertible", "Convertible"
        OTHER = "other", "Other"

    user = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name="vehicles"
    )
    make = models.CharField(max_length=100)
    model = models.CharField(max_length=100)
    year = models.PositiveSmallIntegerField(null=True, blank=True)
    plate = models.CharField(max_length=20)
    colour = models.CharField(max_length=50, blank=True)
    vehicle_type = models.CharField(
        max_length=15, choices=VehicleType.choices, default=VehicleType.SEDAN
    )
    notes = models.TextField(blank=True)
    is_default = models.BooleanField(default=False)

    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()

    class Meta:
        db_table = "accounts_vehicle"
        unique_together = [("user", "plate")]
        indexes = [models.Index(fields=["user", "is_deleted"])]

    def __str__(self) -> str:
        return f"{self.year} {self.make} {self.model} ({self.plate})"


# ── Addresses ─────────────────────────────────────────────────────────────────

class Address(BaseModel):
    """Customer's saved addresses for mobile/at-home bookings."""

    user = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name="addresses"
    )
    label = models.CharField(max_length=100, blank=True, default="Home")
    line1 = models.CharField(max_length=255)
    line2 = models.CharField(max_length=255, blank=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100, blank=True)
    postal_code = models.CharField(max_length=20, blank=True)
    country = models.CharField(max_length=2, default="SA")  # ISO 3166-1 alpha-2
    # Coordinates (optional; used for distance calculations without PostGIS)
    lat = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    lng = models.DecimalField(max_digits=9, decimal_places=6, null=True, blank=True)
    is_default = models.BooleanField(default=False)

    objects = SoftDeleteManager()
    all_objects = AllObjectsManager()

    class Meta:
        db_table = "accounts_address"
        indexes = [models.Index(fields=["user", "is_deleted"])]

    def __str__(self) -> str:
        return f"{self.label}: {self.line1}, {self.city}"


# ── OTP ───────────────────────────────────────────────────────────────────────

class OTPCode(models.Model):
    """
    Phone OTP for passwordless login / registration.

    The raw code is NEVER stored — only its SHA-256 hash.
    An OTP is consumed on first successful verify (single-use).
    """

    phone = models.CharField(max_length=20, db_index=True)
    code_hash = models.CharField(max_length=64)  # SHA-256 hex
    expires_at = models.DateTimeField()
    attempts = models.PositiveSmallIntegerField(default=0)
    used = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "accounts_otp_code"
        indexes = [models.Index(fields=["phone", "used", "expires_at"])]

    def __str__(self) -> str:
        return f"OTP({self.phone}, expires={self.expires_at})"

    @classmethod
    def hash_code(cls, raw: str) -> str:
        return hashlib.sha256(raw.encode()).hexdigest()

    def is_valid(self, raw: str) -> bool:
        from django.conf import settings

        if self.used:
            return False
        if timezone.now() > self.expires_at:
            return False
        if self.attempts >= settings.OTP_MAX_ATTEMPTS:
            return False
        return self.code_hash == self.hash_code(raw)

    def consume(self) -> None:
        """Mark OTP as used — call inside the verify transaction."""
        self.used = True
        self.save(update_fields=["used"])
