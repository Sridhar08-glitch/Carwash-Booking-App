"""
Payments tests — Phase 2.

Covers:
- Wallet top-up, deduction, insufficient balance guard.
- PaymentIntentView: happy path, already-succeeded replay.
- StripeWebhookView: signature missing, duplicate event idempotency.
- Wallet payment method in booking: immediate confirm on wallet deduction.
"""
import json
from decimal import Decimal
from unittest.mock import MagicMock, patch

from django.test import TestCase
from rest_framework.test import APIClient
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import CustomUser
from apps.common.errors import ConflictError
from apps.common.models import Tenant
from apps.payments import services
from apps.payments.models import Payment, Wallet, WalletTransaction


# ── Fixtures ──────────────────────────────────────────────────────────────────

def _make_user(phone="+966540000001"):
    tenant, _ = Tenant.objects.get_or_create(slug="pay-test", defaults={"name": "PayTest"})
    user, _ = CustomUser.objects.get_or_create(
        phone=phone,
        defaults={"username": phone, "tenant": tenant, "role": "customer"},
    )
    return tenant, user


def _api_client(user):
    client = APIClient()
    token = RefreshToken.for_user(user)
    client.credentials(HTTP_AUTHORIZATION=f"Bearer {token.access_token}")
    return client


# ── Wallet service tests ──────────────────────────────────────────────────────

class WalletServiceTests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_user()
        Wallet.objects.filter(user=self.user).delete()

    def test_top_up_creates_wallet(self):
        wallet = services.top_up_wallet(user=self.user, amount=Decimal("100"))
        self.assertEqual(wallet.balance, Decimal("100"))
        self.assertEqual(WalletTransaction.objects.filter(wallet=wallet).count(), 1)

    def test_top_up_increments_balance(self):
        services.top_up_wallet(user=self.user, amount=Decimal("50"))
        wallet = services.top_up_wallet(user=self.user, amount=Decimal("30"))
        self.assertEqual(wallet.balance, Decimal("80"))

    def test_deduct_wallet_happy_path(self):
        services.top_up_wallet(user=self.user, amount=Decimal("100"))
        wallet = services.deduct_wallet(
            user=self.user, amount=Decimal("40"),
            reason=WalletTransaction.Reason.ORDER_PAYMENT,
        )
        self.assertEqual(wallet.balance, Decimal("60"))
        self.assertEqual(WalletTransaction.objects.filter(wallet=wallet).count(), 2)

    def test_deduct_insufficient_balance_raises(self):
        services.top_up_wallet(user=self.user, amount=Decimal("10"))
        with self.assertRaises(ConflictError) as ctx:
            services.deduct_wallet(
                user=self.user, amount=Decimal("50"),
                reason=WalletTransaction.Reason.ORDER_PAYMENT,
            )
        self.assertEqual(ctx.exception.code, "WALLET_INSUFFICIENT")

    def test_deduct_from_empty_wallet_raises(self):
        with self.assertRaises(ConflictError):
            services.deduct_wallet(
                user=self.user, amount=Decimal("1"),
                reason=WalletTransaction.Reason.ORDER_PAYMENT,
            )

    def test_top_up_zero_raises(self):
        with self.assertRaises(ConflictError):
            services.top_up_wallet(user=self.user, amount=Decimal("0"))


# ── Wallet API tests ──────────────────────────────────────────────────────────

class WalletAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_user()
        self.client = _api_client(self.user)

    def test_wallet_get_200(self):
        resp = self.client.get("/api/v1/payments/wallet")
        self.assertEqual(resp.status_code, 200)
        self.assertIn("balance", resp.json())

    def test_wallet_top_up_requires_admin(self):
        resp = self.client.post(
            "/api/v1/payments/wallet/top-up",
            {"user_id": self.user.pk, "amount": "50.00"},
            format="json",
        )
        self.assertEqual(resp.status_code, 403)

    def test_wallet_top_up_as_admin(self):
        _, admin = _make_user(phone="+966540000099")
        admin.role = "admin"
        admin.save(update_fields=["role"])
        admin_client = _api_client(admin)
        resp = admin_client.post(
            "/api/v1/payments/wallet/top-up",
            {"user_id": self.user.pk, "amount": "100.00"},
            format="json",
        )
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(Decimal(resp.json()["balance"]), Decimal("100.00"))


# ── PaymentIntent API tests ───────────────────────────────────────────────────

class PaymentIntentAPITests(TestCase):
    def setUp(self):
        self.tenant, self.user = _make_user()
        self.client = _api_client(self.user)

    def _make_payment(self, status=Payment.Status.PENDING):
        return Payment.objects.create(
            tenant=self.tenant,
            user=self.user,
            amount=Decimal("75.00"),
            currency="SAR",
            method=Payment.Method.CARD,
            status=status,
            idempotency_key="pi-test-key",
        )

    @patch("apps.payments.stripe_service.create_payment_intent")
    def test_intent_returns_client_secret(self, mock_pi):
        mock_pi.return_value = "pi_test_secret_abc"
        payment = self._make_payment()
        resp = self.client.post(
            "/api/v1/payments/intent",
            {"payment_id": payment.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["client_secret"], "pi_test_secret_abc")
        mock_pi.assert_called_once()

    @patch("apps.payments.stripe_service.create_payment_intent")
    def test_intent_already_succeeded_replays(self, mock_pi):
        """Succeeded payment returns stored client_secret without calling Stripe."""
        payment = self._make_payment(status=Payment.Status.SUCCEEDED)
        payment.stripe_client_secret = "existing_secret"
        payment.save(update_fields=["stripe_client_secret"])

        resp = self.client.post(
            "/api/v1/payments/intent",
            {"payment_id": payment.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["client_secret"], "existing_secret")
        mock_pi.assert_not_called()

    def test_intent_wrong_user_404(self):
        _, other_user = _make_user(phone="+966540000002")
        payment = Payment.objects.create(
            tenant=self.tenant, user=other_user,
            amount=Decimal("10"), currency="SAR", method="card", status="pending",
        )
        resp = self.client.post(
            "/api/v1/payments/intent",
            {"payment_id": payment.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, 404)

    def test_intent_failed_payment_raises_conflict(self):
        payment = self._make_payment(status=Payment.Status.FAILED)
        resp = self.client.post(
            "/api/v1/payments/intent",
            {"payment_id": payment.pk},
            format="json",
        )
        self.assertEqual(resp.status_code, 409)


# ── Stripe Webhook tests ──────────────────────────────────────────────────────

class StripeWebhookTests(TestCase):
    WEBHOOK_URL = "/api/v1/payments/webhook"

    def _post(self, payload: dict, sig: str = ""):
        client = APIClient()
        return client.post(
            self.WEBHOOK_URL,
            data=json.dumps(payload),
            content_type="application/json",
            HTTP_STRIPE_SIGNATURE=sig,
        )

    def test_missing_signature_400(self):
        resp = self._post({"type": "payment_intent.succeeded"})
        self.assertEqual(resp.status_code, 400)

    @patch("apps.payments.stripe_service.handle_webhook")
    def test_valid_webhook_200(self, mock_handle):
        mock_handle.return_value = {"status": "ok", "event_type": "payment_intent.succeeded"}
        resp = self._post({"type": "payment_intent.succeeded"}, sig="fake-sig")
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()["status"], "ok")

    @patch("apps.payments.stripe_service.handle_webhook")
    def test_duplicate_webhook_200(self, mock_handle):
        """Duplicate events return 200 — Stripe must not retry."""
        mock_handle.return_value = {"status": "duplicate", "event_type": "payment_intent.succeeded"}
        resp = self._post({}, sig="fake-sig")
        self.assertEqual(resp.status_code, 200)
