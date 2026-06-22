from django.urls import path

from .views import (
    AdminAssignView,
    StaffJobAcceptView,
    StaffJobDetailView,
    StaffJobListView,
    StaffJobPhotoPresignView,
    StaffJobPhotoRecordView,
    StaffJobStatusView,
    StaffJobTasksView,
)

urlpatterns = [
    # Staff-facing job management
    path("staff/jobs", StaffJobListView.as_view(), name="staff-job-list"),
    path("staff/jobs/<int:booking_id>", StaffJobDetailView.as_view(), name="staff-job-detail"),
    path("staff/jobs/<int:booking_id>/accept", StaffJobAcceptView.as_view(), name="staff-job-accept"),
    path("staff/jobs/<int:booking_id>/status", StaffJobStatusView.as_view(), name="staff-job-status"),
    path("staff/jobs/<int:booking_id>/tasks", StaffJobTasksView.as_view(), name="staff-job-tasks"),
    path("staff/jobs/<int:booking_id>/photos/presign", StaffJobPhotoPresignView.as_view(), name="staff-photo-presign"),
    path("staff/jobs/<int:booking_id>/photos/record", StaffJobPhotoRecordView.as_view(), name="staff-photo-record"),
    # Admin-only
    path("admin-api/bookings/<int:booking_id>/assign", AdminAssignView.as_view(), name="admin-assign"),
]
