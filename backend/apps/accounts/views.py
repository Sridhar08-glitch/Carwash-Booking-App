"""
Accounts views — thin: validate → call service/selector → serialize → respond.
No business logic in views.
"""
import logging

from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.throttling import ScopedRateThrottle
from rest_framework.views import APIView
from rest_framework.viewsets import GenericViewSet
from rest_framework_simplejwt.tokens import RefreshToken

from apps.common.errors import ConflictError
from apps.common.mixins import SoftDeleteMixin

from . import services
from .models import Address, Vehicle
from .selectors import get_user_addresses, get_user_vehicles
from .serializers import (
    AddressCreateSerializer,
    AddressSerializer,
    AuthResponseSerializer,
    OTPRequestSerializer,
    OTPVerifySerializer,
    RefreshTokenSerializer,
    UpdateProfileSerializer,
    UserProfileSerializer,
    VehicleCreateSerializer,
    VehicleSerializer,
)

logger = logging.getLogger(__name__)


# ── OTP ───────────────────────────────────────────────────────────────────────

class OTPRequestView(APIView):
    """POST /api/v1/auth/otp/request — send OTP to phone."""

    permission_classes = [AllowAny]
    throttle_scope = "otp_request"

    @extend_schema(
        request=OTPRequestSerializer,
        responses={200: {"type": "object", "properties": {"detail": {"type": "string"}}}},
        tags=["auth"],
        summary="Request OTP",
    )
    def post(self, request: Request) -> Response:
        serializer = OTPRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        services.request_otp(phone=serializer.validated_data["phone"])
        return Response({"detail": "OTP sent."})


class OTPVerifyView(APIView):
    """POST /api/v1/auth/otp/verify — verify OTP, return JWT tokens."""

    permission_classes = [AllowAny]
    throttle_scope = "otp_verify"

    @extend_schema(
        request=OTPVerifySerializer,
        responses={200: AuthResponseSerializer},
        tags=["auth"],
        summary="Verify OTP and obtain tokens",
    )
    def post(self, request: Request) -> Response:
        serializer = OTPVerifySerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        result = services.verify_otp_and_login(**serializer.validated_data)
        return Response(result, status=status.HTTP_200_OK)


class TokenRefreshView(APIView):
    """POST /api/v1/auth/refresh — rotate refresh token.

    Returns 401 on invalid/expired tokens so the frontend AuthInterceptor
    can detect the failure and trigger logout correctly (it checks for 401
    on the refresh path specifically).
    """

    permission_classes = [AllowAny]
    throttle_scope = "token_refresh"

    @extend_schema(
        request=RefreshTokenSerializer,
        responses={
            200: {"type": "object", "properties": {
                "access": {"type": "string"},
                "refresh": {"type": "string"},
            }},
            401: {"description": "Refresh token invalid or expired"},
        },
        tags=["auth"],
        summary="Refresh access token",
    )
    def post(self, request: Request) -> Response:
        serializer = RefreshTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            refresh = RefreshToken(serializer.validated_data["refresh"])
            return Response({
                "access": str(refresh.access_token),
                "refresh": str(refresh),
            })
        except Exception:
            # Return 401 (not 409) so the frontend AuthInterceptor's logout
            # path triggers: it checks specifically for 401 on /auth/refresh.
            from rest_framework.exceptions import AuthenticationFailed
            raise AuthenticationFailed("Refresh token is invalid or has expired.")


class LogoutView(APIView):
    """POST /api/v1/auth/logout — blacklist refresh token."""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=RefreshTokenSerializer,
        responses={204: None},
        tags=["auth"],
        summary="Logout (blacklist refresh token)",
    )
    def post(self, request: Request) -> Response:
        serializer = RefreshTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        services.logout_user(refresh_token=serializer.validated_data["refresh"])
        return Response(status=status.HTTP_204_NO_CONTENT)


# ── Profile ───────────────────────────────────────────────────────────────────

class ProfileView(APIView):
    """GET/PATCH /api/v1/profile/me"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: UserProfileSerializer}, tags=["profile"], summary="Get my profile")
    def get(self, request: Request) -> Response:
        serializer = UserProfileSerializer(request.user)
        return Response(serializer.data)

    @extend_schema(
        request=UpdateProfileSerializer,
        responses={200: UserProfileSerializer},
        tags=["profile"],
        summary="Update my profile",
    )
    def patch(self, request: Request) -> Response:
        serializer = UpdateProfileSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = services.update_profile(user=request.user, data=serializer.validated_data)
        return Response(UserProfileSerializer(user).data)


# ── Vehicles ──────────────────────────────────────────────────────────────────

class VehicleViewSet(SoftDeleteMixin, GenericViewSet):
    """CRUD /api/v1/profile/vehicles/"""

    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return get_user_vehicles(user=self.request.user)

    def get_serializer_class(self):
        if self.action in ("create", "partial_update"):
            return VehicleCreateSerializer
        return VehicleSerializer

    @extend_schema(responses={200: VehicleSerializer(many=True)}, tags=["vehicles"], summary="List my vehicles")
    def list(self, request: Request) -> Response:
        qs = self.get_queryset()
        return Response(VehicleSerializer(qs, many=True).data)

    @extend_schema(request=VehicleCreateSerializer, responses={201: VehicleSerializer}, tags=["vehicles"], summary="Add a vehicle")
    def create(self, request: Request) -> Response:
        serializer = VehicleCreateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        vehicle = services.create_vehicle(user=request.user, data=serializer.validated_data)
        return Response(VehicleSerializer(vehicle).data, status=status.HTTP_201_CREATED)

    @extend_schema(responses={200: VehicleSerializer}, tags=["vehicles"], summary="Get a vehicle")
    def retrieve(self, request: Request, pk=None) -> Response:
        vehicle = self.get_queryset().filter(pk=pk).first()
        if not vehicle:
            from apps.common.errors import NotFoundError
            raise NotFoundError()
        return Response(VehicleSerializer(vehicle).data)

    @extend_schema(request=VehicleCreateSerializer, responses={200: VehicleSerializer}, tags=["vehicles"], summary="Update a vehicle")
    def partial_update(self, request: Request, pk=None) -> Response:
        serializer = VehicleCreateSerializer(data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        vehicle = services.update_vehicle(user=request.user, vehicle_id=pk, data=serializer.validated_data)
        return Response(VehicleSerializer(vehicle).data)

    @extend_schema(responses={204: None}, tags=["vehicles"], summary="Delete a vehicle")
    def destroy(self, request: Request, pk=None) -> Response:
        services.delete_vehicle(user=request.user, vehicle_id=pk)
        return Response(status=status.HTTP_204_NO_CONTENT)


# ── Addresses ─────────────────────────────────────────────────────────────────

class AddressViewSet(SoftDeleteMixin, GenericViewSet):
    """CRUD /api/v1/profile/addresses/"""

    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return get_user_addresses(user=self.request.user)

    def get_serializer_class(self):
        if self.action in ("create", "partial_update"):
            return AddressCreateSerializer
        return AddressSerializer

    @extend_schema(responses={200: AddressSerializer(many=True)}, tags=["addresses"])
    def list(self, request: Request) -> Response:
        return Response(AddressSerializer(self.get_queryset(), many=True).data)

    @extend_schema(request=AddressCreateSerializer, responses={201: AddressSerializer}, tags=["addresses"])
    def create(self, request: Request) -> Response:
        serializer = AddressCreateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        address = services.create_address(user=request.user, data=serializer.validated_data)
        return Response(AddressSerializer(address).data, status=status.HTTP_201_CREATED)

    @extend_schema(responses={200: AddressSerializer}, tags=["addresses"])
    def retrieve(self, request: Request, pk=None) -> Response:
        address = self.get_queryset().filter(pk=pk).first()
        if not address:
            from apps.common.errors import NotFoundError
            raise NotFoundError()
        return Response(AddressSerializer(address).data)

    @extend_schema(request=AddressCreateSerializer, responses={200: AddressSerializer}, tags=["addresses"])
    def partial_update(self, request: Request, pk=None) -> Response:
        serializer = AddressCreateSerializer(data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        address = services.update_address(user=request.user, address_id=pk, data=serializer.validated_data)
        return Response(AddressSerializer(address).data)

    @extend_schema(responses={204: None}, tags=["addresses"])
    def destroy(self, request: Request, pk=None) -> Response:
        services.delete_address(user=request.user, address_id=pk)
        return Response(status=status.HTTP_204_NO_CONTENT)
