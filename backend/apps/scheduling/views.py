"""Scheduling views — Phase 3: recurring rules + reschedule added."""
import datetime

from drf_spectacular.utils import OpenApiParameter, extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError

from . import services
from .selectors import (
    get_available_slots,
    get_booking_by_id,
    get_recurring_rules,
    get_user_bookings,
)
from .serializers import (
    BookingCancelSerializer,
    BookingCreateSerializer,
    BookingRescheduleSerializer,
    BookingSerializer,
    BookingSlotSerializer,
    RecurringRuleCreateSerializer,
    RecurringRuleSerializer,
)


class SlotListView(APIView):
    """GET /api/v1/slots/"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        parameters=[
            OpenApiParameter("date", str, description="YYYY-MM-DD (defaults to today)"),
            OpenApiParameter("service", int),
            OpenApiParameter("branch", int),
        ],
        responses={200: BookingSlotSerializer(many=True)},
        tags=["scheduling"],
        summary="List available slots",
    )
    def get(self, request: Request) -> Response:
        date_str = request.query_params.get("date")
        try:
            target_date = datetime.date.fromisoformat(date_str) if date_str else datetime.date.today()
        except ValueError:
            from apps.common.errors import AppError
            raise AppError("Invalid date format. Use YYYY-MM-DD.")

        qs = get_available_slots(
            tenant_id=request.user.tenant_id,
            target_date=target_date,
            service_id=request.query_params.get("service"),
            branch_id=request.query_params.get("branch"),
        )
        return Response(BookingSlotSerializer(qs, many=True).data)


class BookingListCreateView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        parameters=[OpenApiParameter("status", str)],
        responses={200: BookingSerializer(many=True)},
        tags=["scheduling"],
        summary="List my bookings",
    )
    def get(self, request: Request) -> Response:
        return Response(BookingSerializer(
            get_user_bookings(user=request.user, status=request.query_params.get("status")),
            many=True,
        ).data)

    @extend_schema(
        request=BookingCreateSerializer,
        responses={201: BookingSerializer},
        tags=["scheduling"],
        summary="Create a booking",
    )
    def post(self, request: Request) -> Response:
        idempotency_key = request.headers.get("Idempotency-Key", "")
        s = BookingCreateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        if idempotency_key:
            s.validated_data["idempotency_key"] = idempotency_key
        booking = services.create_booking(user=request.user, **s.validated_data)
        return Response(BookingSerializer(booking).data, status=status.HTTP_201_CREATED)


class BookingDetailView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: BookingSerializer}, tags=["scheduling"])
    def get(self, request: Request, pk: int) -> Response:
        booking = get_booking_by_id(user=request.user, booking_id=pk)
        if not booking:
            raise NotFoundError()
        return Response(BookingSerializer(booking).data)


class BookingCancelView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(request=BookingCancelSerializer, responses={200: BookingSerializer}, tags=["scheduling"])
    def post(self, request: Request, pk: int) -> Response:
        s = BookingCancelSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        booking = services.cancel_booking(user=request.user, booking_id=pk, **s.validated_data)
        return Response(BookingSerializer(booking).data)


class BookingRescheduleView(APIView):
    """POST /api/v1/bookings/{id}/reschedule"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=BookingRescheduleSerializer,
        responses={200: BookingSerializer},
        tags=["scheduling"],
        summary="Reschedule a booking to a different slot",
    )
    def post(self, request: Request, pk: int) -> Response:
        s = BookingRescheduleSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        booking = services.reschedule_booking(
            user=request.user,
            booking_id=pk,
            slot_id=s.validated_data["slot_id"],
        )
        return Response(BookingSerializer(booking).data)


# ── Recurring rules ────────────────────────────────────────────────────────────

class RecurringRuleListCreateView(APIView):
    """GET/POST /api/v1/recurring/"""

    permission_classes = [IsAuthenticated]

    @extend_schema(responses={200: RecurringRuleSerializer(many=True)}, tags=["recurring"])
    def get(self, request: Request) -> Response:
        return Response(RecurringRuleSerializer(
            get_recurring_rules(user=request.user), many=True
        ).data)

    @extend_schema(request=RecurringRuleCreateSerializer, responses={201: RecurringRuleSerializer}, tags=["recurring"])
    def post(self, request: Request) -> Response:
        s = RecurringRuleCreateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        rule = services.create_recurring_rule(user=request.user, **s.validated_data)
        return Response(RecurringRuleSerializer(rule).data, status=status.HTTP_201_CREATED)


class RecurringRuleDetailView(APIView):
    """GET/PATCH/DELETE /api/v1/recurring/{id}/"""

    permission_classes = [IsAuthenticated]

    def _get_rule(self, request, pk):
        from .models import RecurringBookingRule
        rule = RecurringBookingRule.objects.filter(pk=pk, user=request.user).first()
        if not rule:
            raise NotFoundError("Recurring rule not found.")
        return rule

    @extend_schema(responses={200: RecurringRuleSerializer}, tags=["recurring"])
    def get(self, request: Request, pk: int) -> Response:
        return Response(RecurringRuleSerializer(self._get_rule(request, pk)).data)

    @extend_schema(
        request=RecurringRuleCreateSerializer,
        responses={200: RecurringRuleSerializer},
        tags=["recurring"],
    )
    def patch(self, request: Request, pk: int) -> Response:
        rule = self._get_rule(request, pk)
        s = RecurringRuleCreateSerializer(data=request.data, partial=True)
        s.is_valid(raise_exception=True)
        for field, value in s.validated_data.items():
            setattr(rule, field, value)
        rule.save()
        return Response(RecurringRuleSerializer(rule).data)

    @extend_schema(responses={204: None}, tags=["recurring"])
    def delete(self, request: Request, pk: int) -> Response:
        rule = self._get_rule(request, pk)
        rule.is_active = False
        rule.save(update_fields=["is_active", "updated_at"])
        return Response(status=status.HTTP_204_NO_CONTENT)
