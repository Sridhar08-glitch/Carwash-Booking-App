"""
Staff models.

JobAssignment   — one-to-one with Booking; tracks accept/start/finish times.
TaskTemplate    — ordered checklist items for a service.
JobTask         — per-assignment checklist item with done flag.
JobPhoto        — before/after photos for a booking job.
"""
from django.conf import settings
from django.db import models

from apps.common.models import TenantScopedModel


class JobAssignment(TenantScopedModel):
    """
    Tracks a staff member's work lifecycle for a single booking.

    Status mirrors Booking.status for the staff-facing side.
    accepted_at, started_at, finished_at are timestamps of each transition.
    """

    class AssignmentStatus(models.TextChoices):
        PENDING = "pending", "Pending Acceptance"
        ACCEPTED = "accepted", "Accepted"
        EN_ROUTE = "en_route", "En Route"
        IN_PROGRESS = "in_progress", "In Progress"
        COMPLETED = "completed", "Completed"

    booking = models.OneToOneField(
        "scheduling.Booking", on_delete=models.CASCADE, related_name="job_assignment"
    )
    staff = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="job_assignments",
    )
    status = models.CharField(
        max_length=15,
        choices=AssignmentStatus.choices,
        default=AssignmentStatus.PENDING,
        db_index=True,
    )
    notes = models.TextField(blank=True)

    # Timestamps
    assigned_at = models.DateTimeField(auto_now_add=True)
    accepted_at = models.DateTimeField(null=True, blank=True)
    en_route_at = models.DateTimeField(null=True, blank=True)
    started_at = models.DateTimeField(null=True, blank=True)
    finished_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "staff_job_assignment"
        indexes = [
            models.Index(fields=["staff", "status"]),
            models.Index(fields=["tenant", "status"]),
        ]

    def __str__(self) -> str:
        return f"JobAssignment(booking={self.booking_id}, staff={self.staff_id}, status={self.status})"


class TaskTemplate(TenantScopedModel):
    """
    Ordered checklist of steps for completing a service.
    One template per service; reused across all jobs for that service.
    """

    service = models.OneToOneField(
        "catalog.Service", on_delete=models.CASCADE, related_name="task_template"
    )
    # Ordered list of step names e.g. ["Pre-wash rinse", "Foam cannon", "Hand wash", ...]
    steps = models.JSONField(default=list)

    class Meta:
        db_table = "staff_task_template"

    def __str__(self) -> str:
        return f"TaskTemplate(service={self.service_id}, steps={len(self.steps)})"


class JobTask(TenantScopedModel):
    """
    Per-job checklist item, derived from TaskTemplate at assignment time.
    Staff checks items off during the job.
    """

    assignment = models.ForeignKey(
        JobAssignment, on_delete=models.CASCADE, related_name="tasks"
    )
    step_name = models.CharField(max_length=200)
    ordering = models.PositiveSmallIntegerField(default=0)
    is_done = models.BooleanField(default=False)
    done_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = "staff_job_task"
        ordering = ["ordering"]

    def __str__(self) -> str:
        return f"JobTask({self.assignment_id}, {self.step_name}, done={self.is_done})"


class JobPhoto(TenantScopedModel):
    """
    Before/after photos attached to a booking job.
    The image URL points to a presigned S3/R2 object uploaded by the staff app.
    """

    class Kind(models.TextChoices):
        BEFORE = "before", "Before"
        AFTER = "after", "After"

    booking = models.ForeignKey(
        "scheduling.Booking", on_delete=models.CASCADE, related_name="job_photos"
    )
    staff = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        related_name="job_photos",
    )
    kind = models.CharField(max_length=10, choices=Kind.choices, db_index=True)
    image_url = models.URLField(max_length=1000)
    s3_key = models.CharField(max_length=500, blank=True)  # for deletion/audit
    caption = models.CharField(max_length=255, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "staff_job_photo"
        indexes = [models.Index(fields=["booking", "kind"])]

    def __str__(self) -> str:
        return f"JobPhoto(booking={self.booking_id}, kind={self.kind})"
