"""
Staff service layer.

assign_staff_to_booking  — admin assigns a staff member to a booking.
accept_job               — staff accepts an assigned job.
update_job_status        — staff advances job lifecycle (en_route, in_progress, completed).
toggle_task              — staff checks/unchecks a checklist item.
generate_photo_presign   — returns a presigned S3 URL for photo upload.
"""
from __future__ import annotations

import logging
import uuid
from datetime import timedelta

from django.db import transaction
from django.utils import timezone

from apps.common.errors import ConflictError, NotFoundError

logger = logging.getLogger(__name__)


# ── Assignment ─────────────────────────────────────────────────────────────────

@transaction.atomic
def assign_staff_to_booking(*, admin_user, booking_id: int, staff_user_id: int) -> "JobAssignment":
    """
    Admin assigns a staff member to a confirmed booking.
    Creates or updates the JobAssignment and populates JobTasks from the
    service's TaskTemplate (if one exists).
    """
    from apps.scheduling.models import Booking
    from apps.accounts.models import CustomUser
    from .models import JobAssignment, JobTask, TaskTemplate

    booking = Booking.objects.select_for_update().filter(pk=booking_id).first()
    if not booking:
        raise NotFoundError("Booking not found.")
    if booking.status not in (Booking.Status.CONFIRMED, Booking.Status.PENDING):
        raise ConflictError(f"Cannot assign staff to booking in status '{booking.status}'.")

    staff = CustomUser.objects.filter(pk=staff_user_id, role="staff").first()
    if not staff:
        raise NotFoundError("Staff user not found.")

    # Upsert assignment
    assignment, created = JobAssignment.objects.get_or_create(
        booking=booking,
        defaults={"tenant": booking.tenant, "staff": staff},
    )
    if not created:
        assignment.staff = staff
        assignment.status = JobAssignment.AssignmentStatus.PENDING
        assignment.save(update_fields=["staff", "status", "updated_at"])
    else:
        # Seed tasks from template
        try:
            template = TaskTemplate.objects.get(service=booking.service)
            JobTask.objects.filter(assignment=assignment).delete()
            tasks = [
                JobTask(
                    tenant=booking.tenant,
                    assignment=assignment,
                    step_name=step,
                    ordering=i,
                )
                for i, step in enumerate(template.steps)
            ]
            JobTask.objects.bulk_create(tasks)
        except TaskTemplate.DoesNotExist:
            pass

    # Update booking
    booking.status = Booking.Status.ASSIGNED
    booking.assigned_staff = staff
    booking.save(update_fields=["status", "assigned_staff", "updated_at"])

    logger.info("Staff %s assigned to booking %s", staff.pk, booking.pk)
    return assignment


@transaction.atomic
def accept_job(*, staff_user, booking_id: int) -> "JobAssignment":
    """Staff accepts a pending job assignment."""
    from .models import JobAssignment

    assignment = _get_assignment_for_staff(staff_user=staff_user, booking_id=booking_id)
    if assignment.status != JobAssignment.AssignmentStatus.PENDING:
        raise ConflictError(f"Job is already in status '{assignment.status}'.")
    assignment.status = JobAssignment.AssignmentStatus.ACCEPTED
    assignment.accepted_at = timezone.now()
    assignment.save(update_fields=["status", "accepted_at", "updated_at"])
    return assignment


@transaction.atomic
def update_job_status(*, staff_user, booking_id: int, new_status: str) -> "JobAssignment":
    """
    Advance the job through its lifecycle.
    Allowed transitions: accepted → en_route → in_progress → completed.
    Also mirrors the status to the parent Booking.
    """
    from apps.scheduling.models import Booking
    from .models import JobAssignment

    TRANSITIONS = {
        JobAssignment.AssignmentStatus.ACCEPTED: [JobAssignment.AssignmentStatus.EN_ROUTE],
        JobAssignment.AssignmentStatus.EN_ROUTE: [JobAssignment.AssignmentStatus.IN_PROGRESS],
        JobAssignment.AssignmentStatus.IN_PROGRESS: [JobAssignment.AssignmentStatus.COMPLETED],
    }

    BOOKING_STATUS_MAP = {
        JobAssignment.AssignmentStatus.EN_ROUTE: Booking.Status.EN_ROUTE,
        JobAssignment.AssignmentStatus.IN_PROGRESS: Booking.Status.IN_PROGRESS,
        JobAssignment.AssignmentStatus.COMPLETED: Booking.Status.COMPLETED,
    }

    assignment = _get_assignment_for_staff(staff_user=staff_user, booking_id=booking_id)
    allowed = TRANSITIONS.get(assignment.status, [])
    if new_status not in allowed:
        raise ConflictError(
            f"Cannot transition from '{assignment.status}' to '{new_status}'."
        )

    now = timezone.now()
    assignment.status = new_status
    if new_status == JobAssignment.AssignmentStatus.EN_ROUTE:
        assignment.en_route_at = now
    elif new_status == JobAssignment.AssignmentStatus.IN_PROGRESS:
        assignment.started_at = now
    elif new_status == JobAssignment.AssignmentStatus.COMPLETED:
        assignment.finished_at = now

    assignment.save()

    # Mirror to Booking
    booking_status = BOOKING_STATUS_MAP.get(new_status)
    if booking_status:
        assignment.booking.status = booking_status
        assignment.booking.save(update_fields=["status", "updated_at"])

        if new_status == JobAssignment.AssignmentStatus.COMPLETED:
            # Notify customer
            try:
                from apps.notifications.services import send_notification
                send_notification(
                    user=assignment.booking.user,
                    title="Car Wash Complete!",
                    body="Your car is ready. Check the before/after photos in the app.",
                    notification_type="booking_completed",
                    data={"booking_id": str(booking_id)},
                )
            except Exception as exc:
                logger.warning("Could not send completion notification: %s", exc)

    return assignment


# ── Checklist ──────────────────────────────────────────────────────────────────

@transaction.atomic
def toggle_task(*, staff_user, booking_id: int, task_id: int) -> "JobTask":
    """Toggle a JobTask is_done flag."""
    from .models import JobTask

    assignment = _get_assignment_for_staff(staff_user=staff_user, booking_id=booking_id)
    task = JobTask.objects.filter(pk=task_id, assignment=assignment).first()
    if not task:
        raise NotFoundError("Task not found.")
    task.is_done = not task.is_done
    task.done_at = timezone.now() if task.is_done else None
    task.save(update_fields=["is_done", "done_at", "updated_at"])
    return task


# ── Photo presign ──────────────────────────────────────────────────────────────

def generate_photo_presign(*, staff_user, booking_id: int, kind: str) -> dict:
    """
    Generate a presigned S3/R2 PUT URL for a job photo upload.
    Returns {"upload_url": ..., "s3_key": ..., "expires_in": 3600}.
    Falls back to a placeholder when S3 is not configured (dev mode).
    """
    from django.conf import settings

    if not getattr(settings, "USE_S3", False):
        # Dev fallback — return a dummy URL
        fake_key = f"job-photos/{booking_id}/{kind}/{uuid.uuid4()}.jpg"
        return {
            "upload_url": f"http://localhost:8000/dev-upload-placeholder/{fake_key}",
            "s3_key": fake_key,
            "expires_in": 3600,
        }

    import boto3
    from botocore.config import Config

    s3 = boto3.client(
        "s3",
        endpoint_url=getattr(settings, "AWS_S3_ENDPOINT_URL", None),
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_S3_REGION_NAME,
        config=Config(signature_version="s3v4"),
    )
    key = f"job-photos/{booking_id}/{kind}/{uuid.uuid4()}.jpg"
    url = s3.generate_presigned_url(
        "put_object",
        Params={
            "Bucket": settings.AWS_STORAGE_BUCKET_NAME,
            "Key": key,
            "ContentType": "image/jpeg",
        },
        ExpiresIn=3600,
    )
    return {"upload_url": url, "s3_key": key, "expires_in": 3600}


@transaction.atomic
def record_photo(*, staff_user, booking_id: int, kind: str, s3_key: str, caption: str = "") -> "JobPhoto":
    """
    After the staff app uploads the photo, record it in JobPhoto.
    Constructs the public (or presigned) URL from the s3_key.
    """
    from django.conf import settings
    from .models import JobPhoto
    from apps.scheduling.models import Booking

    booking = Booking.objects.filter(pk=booking_id).first()
    if not booking:
        raise NotFoundError("Booking not found.")

    # Build URL
    if getattr(settings, "USE_S3", False):
        base = settings.AWS_S3_ENDPOINT_URL or f"https://{settings.AWS_STORAGE_BUCKET_NAME}.s3.amazonaws.com"
        image_url = f"{base}/{s3_key}"
    else:
        image_url = f"/media/{s3_key}"

    photo = JobPhoto.objects.create(
        tenant=booking.tenant,
        booking=booking,
        staff=staff_user,
        kind=kind,
        image_url=image_url,
        s3_key=s3_key,
        caption=caption,
    )
    return photo


# ── Helpers ────────────────────────────────────────────────────────────────────

def _get_assignment_for_staff(*, staff_user, booking_id: int) -> "JobAssignment":
    from .models import JobAssignment

    assignment = JobAssignment.objects.select_for_update().filter(
        booking_id=booking_id, staff=staff_user
    ).first()
    if not assignment:
        raise NotFoundError("Job assignment not found.")
    return assignment
