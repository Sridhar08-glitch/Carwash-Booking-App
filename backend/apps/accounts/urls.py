from django.conf import settings
from django.urls import include, path
from rest_framework.routers import DefaultRouter

from .views import (
    AddressViewSet,
    LogoutView,
    OTPRequestView,
    OTPVerifyView,
    ProfileView,
    TokenRefreshView,
    VehicleViewSet,
)

router = DefaultRouter(trailing_slash=False)
router.register("profile/vehicles", VehicleViewSet, basename="vehicle")
router.register("profile/addresses", AddressViewSet, basename="address")

urlpatterns = [
    # ── OTP-based auth (passwordless — handles both register & login) ─────────
    path("auth/otp/request", OTPRequestView.as_view(), name="otp-request"),
    path("auth/otp/verify", OTPVerifyView.as_view(), name="otp-verify"),
    path("auth/refresh", TokenRefreshView.as_view(), name="token-refresh"),
    path("auth/logout", LogoutView.as_view(), name="logout"),

    # ── Profile ───────────────────────────────────────────────────────────────
    path("profile/me", ProfileView.as_view(), name="profile-me"),

    # ── Vehicles & Addresses ─────────────────────────────────────────────────
    path("", include(router.urls)),
]

# ── Social auth (optional — set SOCIAL_AUTH_ENABLED=True + configure allauth) ─
# Requires: pip install dj-rest-auth[with_social] django-allauth
# Add 'allauth', 'allauth.account', 'allauth.socialaccount',
#     'dj_rest_auth.registration' to INSTALLED_APPS and configure
#     SOCIALACCOUNT_PROVIDERS in settings.
if getattr(settings, "SOCIAL_AUTH_ENABLED", False):
    urlpatterns += [
        path("auth/social/", include("dj_rest_auth.registration.urls")),
    ]
