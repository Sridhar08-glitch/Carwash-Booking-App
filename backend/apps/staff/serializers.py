from rest_framework import serializers

from .models import JobAssignment, JobPhoto, JobTask, TaskTemplate


class JobTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobTask
        fields = ["id", "step_name", "ordering", "is_done", "done_at"]
        read_only_fields = ["id", "step_name", "ordering", "done_at"]


class JobPhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = JobPhoto
        fields = ["id", "kind", "image_url", "caption", "uploaded_at"]
        read_only_fields = fields


class JobAssignmentSerializer(serializers.ModelSerializer):
    tasks = JobTaskSerializer(many=True, read_only=True)
    photos = serializers.SerializerMethodField()
    booking_id = serializers.IntegerField(source="booking.pk", read_only=True)
    service_name = serializers.CharField(source="booking.service.name", read_only=True)
    scheduled_date = serializers.DateField(source="booking.scheduled_date", read_only=True)
    scheduled_start = serializers.TimeField(source="booking.scheduled_start", read_only=True)
    customer_phone = serializers.SerializerMethodField()

    class Meta:
        model = JobAssignment
        fields = [
            "id", "booking_id", "service_name", "scheduled_date", "scheduled_start",
            "status", "notes", "assigned_at", "accepted_at", "en_route_at",
            "started_at", "finished_at", "tasks", "photos", "customer_phone",
        ]
        read_only_fields = fields

    def get_photos(self, obj):
        return JobPhotoSerializer(obj.booking.job_photos.all(), many=True).data

    def get_customer_phone(self, obj):
        return obj.booking.user.phone


class JobStatusUpdateSerializer(serializers.Serializer):
    status = serializers.ChoiceField(
        choices=["en_route", "in_progress", "completed"]
    )


class PhotoPresignRequestSerializer(serializers.Serializer):
    kind = serializers.ChoiceField(choices=["before", "after"])


class PhotoRecordSerializer(serializers.Serializer):
    kind = serializers.ChoiceField(choices=["before", "after"])
    s3_key = serializers.CharField(max_length=500)
    caption = serializers.CharField(max_length=255, required=False, default="")


class AdminAssignSerializer(serializers.Serializer):
    staff_user_id = serializers.IntegerField()


class TaskTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskTemplate
        fields = ["id", "service_id", "steps"]
