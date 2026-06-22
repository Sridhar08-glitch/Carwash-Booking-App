"""
Staff views.

StaffJobListView        GET  /api/v1/staff/jobs
StaffJobDetailView      GET  /api/v1/staff/jobs/{booking_id}
StaffJobAcceptView      POST /api/v1/staff/jobs/{booking_id}/accept
StaffJobStatusView      POST /api/v1/staff/jobs/{booking_id}/status
StaffJobTasksView       GET/POST /api/v1/staff/jobs/{booking_id}/tasks
StaffJobPhotoPresignView POST /api/v1/staff/jobs/{booking_id}/photos/presign
StaffJobPhotoRecordView  POST /api/v1/staff/jobs/{booking_id}/photos/record
AdminAssignView         POST /api/v1/admin-api/bookings/{booking_id}/assign
"""
from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.common.errors import NotFoundError
from apps.common.permissions import IsAdmin, IsStaff, IsStaffOrAdmin

from . import services
from .models import JobAssignment, JobTask
from .serializers import (
    AdminAssignSerializer,
    JobAssignmentSerializer,
    JobPhotoSerializer,
    JobStatusUpdateSerializer,
    JobTaskSerializer,
    PhotoPresignRequestSerializer,
    PhotoRecordSerializer,
)


class StaffJobListView(APIView):
    """GET /api/v1/staff/jobs — list the authenticated staff member's jobs."""

    permission_classes = [IsAuthenticated, IsStaffOrAdmin]

    @extend_schema(
        responses={200: JobAssignmentSerializer(many=True)},
        tags=["staff"],
        summary="List my assigned jobs",
    )
    def get(self, request: Request) -> Response:
        qs = (
            JobAssignment.objects.filter(staff=request.user)
            .select_related("booking__service", "booking__user", "booking__branch", "booking__slot")
            .prefetch_related("tasks", "booking__job_photos")
            .order_by("-booking__scheduled_date", "-booking__scheduled_start")
        )
        if s := request.query_params.get("status"):
            qs = qs.filter(status=s)
        return Response(JobAssignmentSerializer(qs, many=True).data)


class StaffJobDetailView(APIView):
    """GET /api/v1/staff/jobs/{booking_id}"""

    permission_classes = [IsAuthenticated, IsStaffOrAdmin]

    @extend_schema(responses={200: JobAssignmentSerializer}, tags=["staff"])
    def get(self, request: Request, booking_id: int) -> Response:
        assignment = JobAssignment.objects.filter(
            booking_id=booking_id, staff=request.user
        ).select_related("booking__service", "booking__user", "booking__branch", "booking__slot").first()
        if not assignment:
            raise NotFoundError("Job assignment not found.")
        return Response(JobAssignmentSerializer(assignment).data)


class StaffJobAcceptView(APIView):
    """POST /api/v1/staff/jobs/{booking_id}/accept"""

    permission_classes = [IsAuthenticated, IsStaff]

    @extend_schema(responses={200: JobAssignmentSerializer}, tags=["staff"])
    def post(self, request: Request, booking_id: int) -> Response:
        assignment = services.accept_job(staff_user=request.user, booking_id=booking_id)
        return Response(JobAssignmentSerializer(assignment).data)


class StaffJobStatusView(APIView):
    """POST /api/v1/staff/jobs/{booking_id}/status"""

    permission_classes = [IsAuthenticated, IsStaff]

    @extend_schema(
        request=JobStatusUpdateSerializer,
        responses={200: JobAssignmentSerializer},
        tags=["staff"],
        summary="Advance job status (en_route / in_progress / completed)",
    )
    def post(self, request: Request, booking_id: int) -> Response:
        s = JobStatusUpdateSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        assignment = services.update_job_status(
            staff_user=request.user,
            booking_id=booking_id,
            new_status=s.validated_data["status"],
        )
        return Response(JobAssignmentSerializer(assignment).data)


class StaffJobTasksView(APIView):
    """GET/POST /api/v1/staff/jobs/{booking_id}/tasks"""

    permission_classes = [IsAuthenticated, IsStaff]

    @extend_schema(responses={200: JobTaskSerializer(many=True)}, tags=["staff"])
    def get(self, request: Request, booking_id: int) -> Response:
        assignment = JobAssignment.objects.filter(
            booking_id=booking_id, staff=request.user
        ).first()
        if not assignment:
            raise NotFoundError()
        return Response(JobTaskSerializer(
            assignment.tasks.order_by("ordering"), many=True
        ).data)

    @extend_schema(
        request={"type": "object", "properties": {"task_id": {"type": "integer"}}},
        responses={200: JobTaskSerializer},
        tags=["staff"],
        summary="Toggle a task item done/undone",
    )
    def post(self, request: Request, booking_id: int) -> Response:
        task_id = request.data.get("task_id")
        if not task_id:
            from apps.common.errors import AppError
            raise AppError("task_id is required.")
        task = services.toggle_task(
            staff_user=request.user, booking_id=booking_id, task_id=task_id
        )
        return Response(JobTaskSerializer(task).data)


class StaffJobPhotoPresignView(APIView):
    """POST /api/v1/staff/jobs/{booking_id}/photos/presign"""

    permission_classes = [IsAuthenticated, IsStaff]

    @extend_schema(
        request=PhotoPresignRequestSerializer,
        responses={200: {"type": "object", "properties": {
            "upload_url": {"type": "string"},
            "s3_key": {"type": "string"},
            "expires_in": {"type": "integer"},
        }}},
        tags=["staff"],
        summary="Get presigned S3 URL for photo upload",
    )
    def post(self, request: Request, booking_id: int) -> Response:
        s = PhotoPresignRequestSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        result = services.generate_photo_presign(
            staff_user=request.user,
            booking_id=booking_id,
            kind=s.validated_data["kind"],
        )
        return Response(result)


class StaffJobPhotoRecordView(APIView):
    """POST /api/v1/staff/jobs/{booking_id}/photos/record — confirm upload done"""

    permission_classes = [IsAuthenticated, IsStaff]

    @extend_schema(request=PhotoRecordSerializer, responses={201: JobPhotoSerializer}, tags=["staff"])
    def post(self, request: Request, booking_id: int) -> Response:
        s = PhotoRecordSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        photo = services.record_photo(
            staff_user=request.user, booking_id=booking_id, **s.validated_data
        )
        return Response(JobPhotoSerializer(photo).data, status=status.HTTP_201_CREATED)


# ── Admin endpoints ───────────────────────────────────────────────────────────

class AdminAssignView(APIView):
    """POST /api/v1/admin-api/bookings/{booking_id}/assign"""

    permission_classes = [IsAuthenticated, IsAdmin]

    @extend_schema(
        request=AdminAssignSerializer,
        responses={200: JobAssignmentSerializer},
        tags=["admin"],
        summary="[Admin] Assign staff to a booking",
    )
    def post(self, request: Request, booking_id: int) -> Response:
        s = AdminAssignSerializer(data=request.data)
        s.is_valid(raise_exception=True)
        assignment = services.assign_staff_to_booking(
            admin_user=request.user,
            booking_id=booking_id,
            staff_user_id=s.validated_data["staff_user_id"],
        )
        return Response(JobAssignmentSerializer(assignment).data)
