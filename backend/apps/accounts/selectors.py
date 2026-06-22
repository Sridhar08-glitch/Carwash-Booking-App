"""Read-only queries for the accounts app."""
from __future__ import annotations

from django.db.models import QuerySet

from .models import Address, CustomUser, Vehicle


def get_user_by_phone(*, phone: str) -> CustomUser | None:
    return CustomUser.objects.filter(phone=phone).select_related("tenant").first()


def get_user_vehicles(*, user: CustomUser) -> QuerySet:
    return Vehicle.objects.filter(user=user).order_by("-is_default", "-created_at")


def get_user_addresses(*, user: CustomUser) -> QuerySet:
    return Address.objects.filter(user=user).order_by("-is_default", "-created_at")
