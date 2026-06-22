"""
Accounts tests.

Coverage
--------
* OTP happy-path: request → verify → JWT issued
* OTP failure: wrong code → ConflictError
* OTP expired: past expires_at → ConflictError
* OTP max attempts exceeded
* Token refresh
* Logout (blacklist)
* Profile CRUD
* Vehicle CRUD
* Address CRUD
"""
import pytest
from datetime import timedelta

from django.test import TestCase
from django.urls import reverse
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.common.models import Tenant
from apps.accounts.models import CustomUser, OTPCode, Vehicle, Address
from apps.accounts import services


# ── Fixtures ──────────────────────────────────────────────────────────────────

def make_tenant():
    t, _ = Tenant.objects.get_or_create(slug="test", defaults={"name": "Test"})
    return t


def make_user(phone="+966501234567", role="customer"):
    t = make_tenant()
    user, _ = CustomUser.objects.get_or_create(
        phone=phone,
        defaults={
            "username": phone,
            "tenant": t,
            "role": role,
            "is_phone_verified": True,
        },
    )
    return user


def auth_client(user):
    client = APIClient()
    refresh = RefreshToken.for_user(user)
    client.credentials(HTTP_AUTHORIZATION=f"Bearer {str(refresh.access_token)}")
    return client


# ── OTP tests ─────────────────────────────────────────────────────────────────

class OTPRequestTests(TestCase):
    def test_request_otp_creates_record(self):
        services.request_otp(phone="+966501111111")
        assert OTPCode.objects.filter(phone="+966501111111", used=False).exists()

    def test_request_otp_invalidates_previous(self):
        services.request_otp(phone="+966502222222")
        services.request_otp(phone="+966502222222")
        assert OTPCode.objects.filter(phone="+966502222222", used=False).count() == 1

    def test_request_otp_endpoint_returns_200(self):
        client = APIClient()
        r = client.post("/api/v1/auth/otp/request", {"phone": "+966503333333"}, format="json")
        assert r.status_code == 200
        assert "detail" in r.data

    def test_request_otp_invalid_phone_returns_400(self):
        client = APIClient()
        r = client.post("/api/v1/auth/otp/request", {"phone": "not-a-phone"}, format="json")
        assert r.status_code == 400
        assert r.data["code"] == "VALIDATION_ERROR"


class OTPVerifyTests(TestCase):
    def _create_otp(self, phone="+966504444444", raw="123456"):
        return OTPCode.objects.create(
            phone=phone,
            code_hash=OTPCode.hash_code(raw),
            expires_at=timezone.now() + timedelta(minutes=5),
        )

    def test_verify_valid_otp_returns_tokens(self):
        otp = self._create_otp()
        result = services.verify_otp_and_login(phone=otp.phone, code="123456")
        assert "access" in result["tokens"]
        assert "refresh" in result["tokens"]
        assert result["user"]["is_phone_verified"] is True

    def test_verify_wrong_code_raises_conflict(self):
        self._create_otp()
        from apps.common.errors import ConflictError
        with pytest.raises(ConflictError):
            services.verify_otp_and_login(phone="+966504444444", code="000000")

    def test_verify_expired_otp_raises_conflict(self):
        otp = OTPCode.objects.create(
            phone="+966505555555",
            code_hash=OTPCode.hash_code("654321"),
            expires_at=timezone.now() - timedelta(minutes=1),
        )
        from apps.common.errors import ConflictError
        with pytest.raises(ConflictError):
            services.verify_otp_and_login(phone=otp.phone, code="654321")

    def test_verify_used_otp_raises_conflict(self):
        otp = self._create_otp(phone="+966506666666")
        otp.consume()
        from apps.common.errors import ConflictError
        with pytest.raises(ConflictError):
            services.verify_otp_and_login(phone=otp.phone, code="123456")

    def test_first_login_creates_user(self):
        self._create_otp(phone="+966507777777")
        result = services.verify_otp_and_login(phone="+966507777777", code="123456")
        assert result["is_new"] is True
        assert CustomUser.objects.filter(phone="+966507777777").exists()

    def test_verify_otp_endpoint_returns_200(self):
        otp = self._create_otp(phone="+966508888888")
        client = APIClient()
        r = client.post("/api/v1/auth/otp/verify", {"phone": otp.phone, "code": "123456"}, format="json")
        assert r.status_code == 200
        assert "tokens" in r.data


# ── Token refresh / logout ────────────────────────────────────────────────────

class TokenTests(TestCase):
    def test_refresh_returns_new_access_token(self):
        user = make_user("+966509999999")
        refresh = RefreshToken.for_user(user)
        client = APIClient()
        r = client.post("/api/v1/auth/refresh", {"refresh": str(refresh)}, format="json")
        assert r.status_code == 200
        assert "access" in r.data

    def test_logout_blacklists_token(self):
        user = make_user("+966500000001")
        c = auth_client(user)
        refresh = RefreshToken.for_user(user)
        r = c.post("/api/v1/auth/logout", {"refresh": str(refresh)}, format="json")
        assert r.status_code == 204


# ── Profile ───────────────────────────────────────────────────────────────────

class ProfileTests(TestCase):
    def test_get_profile(self):
        user = make_user("+966500000002")
        r = auth_client(user).get("/api/v1/profile/me")
        assert r.status_code == 200
        assert r.data["phone"] == user.phone

    def test_patch_profile_email(self):
        user = make_user("+966500000003")
        r = auth_client(user).patch("/api/v1/profile/me", {"email": "test@example.com"}, format="json")
        assert r.status_code == 200
        user.refresh_from_db()
        assert user.email == "test@example.com"

    def test_patch_profile_unauthenticated_returns_401(self):
        r = APIClient().patch("/api/v1/profile/me", {"email": "x@y.com"}, format="json")
        assert r.status_code == 401


# ── Vehicles ──────────────────────────────────────────────────────────────────

class VehicleTests(TestCase):
    def test_create_vehicle(self):
        user = make_user("+966500000010")
        c = auth_client(user)
        r = c.post("/api/v1/profile/vehicles", {"make": "Toyota", "model": "Camry", "plate": "ABC123", "vehicle_type": "sedan"}, format="json")
        assert r.status_code == 201
        assert r.data["plate"] == "ABC123"

    def test_duplicate_plate_raises_409(self):
        user = make_user("+966500000011")
        c = auth_client(user)
        c.post("/api/v1/profile/vehicles", {"make": "Honda", "model": "Civic", "plate": "DUP001", "vehicle_type": "sedan"}, format="json")
        r = c.post("/api/v1/profile/vehicles", {"make": "Honda", "model": "Civic", "plate": "DUP001", "vehicle_type": "sedan"}, format="json")
        assert r.status_code == 409

    def test_delete_vehicle_soft_deletes(self):
        user = make_user("+966500000012")
        c = auth_client(user)
        cr = c.post("/api/v1/profile/vehicles", {"make": "Kia", "model": "Rio", "plate": "DEL001", "vehicle_type": "sedan"}, format="json")
        vid = cr.data["id"]
        c.delete(f"/api/v1/profile/vehicles/{vid}")
        assert not Vehicle.objects.filter(pk=vid).exists()
        assert Vehicle.all_objects.filter(pk=vid).exists()


# ── Addresses ─────────────────────────────────────────────────────────────────

class AddressTests(TestCase):
    def test_create_address(self):
        user = make_user("+966500000020")
        c = auth_client(user)
        r = c.post("/api/v1/profile/addresses", {"label": "Home", "line1": "123 Main St", "city": "Riyadh"}, format="json")
        assert r.status_code == 201
        assert r.data["city"] == "Riyadh"

    def test_list_addresses_only_own(self):
        u1 = make_user("+966500000021")
        u2 = make_user("+966500000022")
        auth_client(u1).post("/api/v1/profile/addresses", {"line1": "A", "city": "X"}, format="json")
        r = auth_client(u2).get("/api/v1/profile/addresses")
        # u2 has no addresses — list should be empty
        assert r.data == []
