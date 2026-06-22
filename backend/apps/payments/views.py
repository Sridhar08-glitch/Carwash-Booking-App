"""
Payments views -- Phase 2.

WalletView            GET  /api/v1/payments/wallet
WalletTopUpView       POST /api/v1/payments/wallet/top-up   (admin only)
PaymentIntentView     POST /api/v1/payments/intent
StripeWebhookView     POST /api/v1/payments/webhook
PaymentListView       GET  /api/v1/payments/
PaymentDetailView     GET  /api/v1/payments/<id>
"""
from __future__ import annotations

import logging
from decimal import Decimal

from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import ConflictError, NotFoundError
from apps.common.permissions import IsAdmin

from . import services
from .models import Payment, Wallet
from .serializers import (
    PaymentIntentRequestSerializer,
    PaymentSerializer,
    WalletSerializer,
    WalletTopUpSerializer,
)

logger = logging.getLogger(__name__)


class WalletView(APIView):
    """GET /api/v1/payments/wallet"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: WalletSerializer},
        tags=["payments"],
        summary="Get wallet balance and recent transactions",
    )
    def get(self, request: Request) -> Response:
        wallet, _ = Wallet.objects.get_or_create(
            user=request.user,
            defaults={"tenant": request.user.tenant, "balance": 0, "currency": "SAR"},
        )
        return Response(WalletSerializer(wallet).data)


class WalletTopUpView(APIView):
    """POST /api/v1/payments/wallet/top-up -- Admin-only credit."""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(
        request=WalletTopUpSerializer,
        responses={200: WalletSerializer},
        tags=["payments"],
        summary="[Admin] Credit wallet balance",
    )
    def post(self, request: Request) -> Response:
        s = WalletTopUpSerializer(data=request.data)
        s.is_valid(raise_exception=True)

        from apps.accounts.models import CustomUser
        target_user = CustomUser.objects.filter(
            pk=s.validated_data["user_id"], tenant=request.user.tenant
        ).first()
        if not target_user:
            raise NotFoundError("User not found.")

        wallet = services.top_up_wallet(
            user=target_user,
            amount=Decimal(str(s.validated_data["amount"])),
            reference=s.validated_data.get("reference", f"admin-topup-by-{request.user.pk}"),
        )
        return Response(WalletSerializer(wallet).data)


class PaymentIntentView(APIView):
    """
    POST /api/v1/payments/intent

    Creates (or retrieves) a Stripe PaymentIntent for an existing Payment record.
    Returns client_secret for the mobile Stripe SDK.
    Idempotent: same Idempotency-Key returns same response.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=PaymentIntentRequestSerializer,
        responses={200: {"type": "object", "properties": {
            "payment_id": {"type": "integer"},
            "client_secret": {"type": "string"},
            "amount": {"type": "string"},
            "currency": {"type": "string"},
            "status": {"type": "string"},
        }}},
        tags=["payments"],
        summary="Create or retrieve Stripe PaymentIntent",
    )
    def post(self, request: Request) -> Response:
        s = PaymentIntentRequestSerializer(data=request.data)
        s.is_valid(raise_exception=True)

        payment = Payment.objects.filter(
            pk=s.validated_data["payment_id"], user=request.user
        ).first()
        if not payment:
            raise NotFoundError("Payment record not found.")

        if payment.status == Payment.Status.SUCCEEDED:
            return Response({
                "payment_id": payment.pk,
                "client_secret": payment.stripe_client_secret,
                "amount": str(payment.amount),
                "currency": payment.currency,
                "status": payment.status,
            })

        if payment.status not in (Payment.Status.PENDING, Payment.Status.REQUIRES_ACTION):
            raise ConflictError(
                f"Payment is in status '{payment.status}' and cannot be initiated.",
                code="PAYMENT_INVALID_STATE",
            )

        from .stripe_service import create_payment_intent
        client_secret = create_payment_intent(payment=payment)

        return Response({
            "payment_id": payment.pk,
            "client_secret": client_secret,
            "amount": str(payment.amount),
            "currency": payment.currency,
            "status": payment.status,
        })


@method_decorator(csrf_exempt, name="dispatch")
class StripeWebhookView(APIView):
    """
    POST /api/v1/payments/webhook

    Receives signed Stripe events. CSRF exempt.
    Signature verification IS the authentication.
    """

    authentication_classes = []
    permission_classes = []

    @extend_schema(exclude=True)
    def post(self, request: Request) -> Response:
        payload = request.body
        sig_header = request.headers.get("Stripe-Signature", "")

        if not sig_header:
            return Response(
                {"error": "Missing Stripe-Signature header."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            from .stripe_service import handle_webhook
            result = handle_webhook(payload=payload, sig_header=sig_header)
        except ConflictError as exc:
            logger.warning("Stripe webhook rejected: %s", exc.message)
            return Response({"error": exc.message}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as exc:
            logger.exception("Stripe webhook unhandled error: %s", exc)
            return Response(
                {"error": "Internal error -- logged."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

        return Response(result, status=status.HTTP_200_OK)


class PaymentListView(APIView):
    """GET /api/v1/payments/"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: PaymentSerializer(many=True)},
        tags=["payments"],
        summary="List my payments",
    )
    def get(self, request: Request) -> Response:
        qs = Payment.objects.filter(user=request.user).order_by("-created_at")[:50]
        return Response(PaymentSerializer(qs, many=True).data)


class PaymentDetailView(APIView):
    """GET /api/v1/payments/<id>"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: PaymentSerializer}, tags=["payments"], summary="Get payment detail")
    def get(self, request: Request, pk: int) -> Response:
        payment = Payment.objects.filter(pk=pk, user=request.user).first()
        if not payment:
            raise NotFoundError("Payment not found.")
        return Response(PaymentSerializer(payment).data)


class PaymentConfirmView(APIView):
    """
    POST /api/v1/payments/confirm

    Server-side confirm for wallet and cash payments that do not go through
    the Stripe SDK flow (no client_secret needed).

    For card payments the source of truth is the Stripe webhook -- callers
    should not call this endpoint; it returns 409.

    Idempotent: confirming an already-succeeded payment returns the payment
    without re-processing.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=PaymentIntentRequestSerializer,
        responses={200: PaymentSerializer},
        tags=["payments"],
        summary="Confirm a wallet or cash payment server-side",
    )
    def post(self, request: Request) -> Response:
        s = PaymentIntentRequestSerializer(data=request.data)
        s.is_valid(raise_exception=True)

        payment = Payment.objects.filter(
            pk=s.validated_data["payment_id"], user=request.user
        ).first()
        if not payment:
            raise NotFoundError("Payment record not found.")

        if payment.status == Payment.Status.SUCCEEDED:
            return Response(PaymentSerializer(payment).data)

        if payment.method == Payment.Method.CARD:
            raise ConflictError(
                "Card payments are confirmed by the Stripe SDK + webhook, not this endpoint.",
                code="USE_STRIPE_SDK",
            )

        if payment.status != Payment.Status.PENDING:
            raise ConflictError(
                f"Payment is in status '{payment.status}' and cannot be confirmed.",
                code="PAYMENT_INVALID_STATE",
            )

        # Wallet: deduct and confirm atomically
        if payment.method == Payment.Method.WALLET:
            from decimal import Decimal
            from django.db import transaction as db_tx
            with db_tx.atomic():
                services.deduct_wallet(
                    user=request.user,
                    amount=payment.amount,
                    reason="booking_payment",
                    reference=f"payment#{payment.pk}",
                )
                payment.status = Payment.Status.SUCCEEDED
                payment.save(update_fields=["status", "updated_at"])
        else:
            # Cash — mark succeeded (staff collects cash physically)
            payment.status = Payment.Status.SUCCEEDED
            payment.save(update_fields=["status", "updated_at"])

        return Response(PaymentSerializer(payment).data)
