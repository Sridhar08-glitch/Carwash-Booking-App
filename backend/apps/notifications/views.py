"""
Notifications views.

NotificationListView      GET  /api/v1/notifications/
NotificationReadView      POST /api/v1/notifications/<id>/read
NotificationReadAllView   POST /api/v1/notifications/read-all
NotificationSettingsView  GET/PATCH /api/v1/notifications/settings
FCMTokenView              POST /api/v1/notifications/fcm-token
"""
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError

from .models import Notification, NotificationPreference
from .serializers import (
    FCMTokenUpdateSerializer,
    NotificationPreferenceSerializer,
    NotificationSerializer,
)


class NotificationListView(APIView):
    """GET /api/v1/notifications/ — paginated, most-recent-first."""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: NotificationSerializer(many=True)},
        tags=["notifications"],
        summary="List my notifications",
    )
    def get(self, request: Request) -> Response:
        # Simple offset pagination; cursor pagination in Phase 3 refactor
        limit = min(int(request.query_params.get("limit", 30)), 100)
        offset = int(request.query_params.get("offset", 0))
        unread_only = request.query_params.get("unread") == "1"

        qs = Notification.objects.filter(user=request.user)
        if unread_only:
            qs = qs.filter(is_read=False)
        qs = qs.order_by("-created_at")[offset: offset + limit]

        unread_count = Notification.objects.filter(user=request.user, is_read=False).count()
        return Response({
            "unread_count": unread_count,
            "results": NotificationSerializer(qs, many=True).data,
        })


class NotificationReadView(APIView):
    """POST /api/v1/notifications/<id>/read"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: NotificationSerializer},
        tags=["notifications"],
        summary="Mark a notification as read",
    )
    def post(self, request: Request, pk: int) -> Response:
        notif = Notification.objects.filter(pk=pk, user=request.user).first()
        if not notif:
            raise NotFoundError("Notification not found.")
        if not notif.is_read:
            notif.is_read = True
            notif.save(update_fields=["is_read", "updated_at"])
        return Response(NotificationSerializer(notif).data)


class NotificationReadAllView(APIView):
    """POST /api/v1/notifications/read-all"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: {"type": "object", "properties": {"marked_read": {"type": "integer"}}}},
        tags=["notifications"],
        summary="Mark all unread notifications as read",
    )
    def post(self, request: Request) -> Response:
        count = Notification.objects.filter(user=request.user, is_read=False).update(is_read=True)
        return Response({"marked_read": count})


class NotificationSettingsView(APIView):
    """GET/PATCH /api/v1/notifications/settings"""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: NotificationPreferenceSerializer},
        tags=["notifications"],
        summary="Get notification preferences",
    )
    def get(self, request: Request) -> Response:
        pref, _ = NotificationPreference.objects.get_or_create(
            user=request.user,
            defaults={"tenant": request.user.tenant},
        )
        return Response(NotificationPreferenceSerializer(pref).data)

    @extend_schema(
        request=NotificationPreferenceSerializer,
        responses={200: NotificationPreferenceSerializer},
        tags=["notifications"],
        summary="Update notification preferences",
    )
    def patch(self, request: Request) -> Response:
        pref, _ = NotificationPreference.objects.get_or_create(
            user=request.user,
            defaults={"tenant": request.user.tenant},
        )
        s = NotificationPreferenceSerializer(pref, data=request.data, partial=True)
        s.is_valid(raise_exception=True)
        s.save()
        return Response(s.data)


class FCMTokenView(APIView):
    """
    POST /api/v1/notifications/fcm-token

    Updates the FCM device token for the authenticated user.
    Called by the mobile app when the token is refreshed by Firebase.
    """

    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=FCMTokenUpdateSerializer,
        responses={200: {"type": "object", "properties": {"status": {"type": "string"}}}},
        tags=["notifications"],
        summary="Update FCM device token",
    )
    def post(self, request: Request) -> Response:
        s = FCMTokenUpdateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        request.user.fcm_token = s.validated_data["fcm_token"]
        request.user.save(update_fields=["fcm_token"])
        return Response({"status": "ok"}, status=status.HTTP_200_OK)
