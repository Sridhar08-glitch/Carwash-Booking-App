from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        ("scheduling", "0001_initial"),
        ("catalog", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="JobAssignment",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("booking", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="job_assignment", to="scheduling.booking")),
                ("staff", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="job_assignments", to=settings.AUTH_USER_MODEL)),
                ("status", models.CharField(choices=[("pending", "Pending Acceptance"), ("accepted", "Accepted"), ("en_route", "En Route"), ("in_progress", "In Progress"), ("completed", "Completed")], db_index=True, default="pending", max_length=15)),
                ("notes", models.TextField(blank=True)),
                ("assigned_at", models.DateTimeField(auto_now_add=True)),
                ("accepted_at", models.DateTimeField(blank=True, null=True)),
                ("en_route_at", models.DateTimeField(blank=True, null=True)),
                ("started_at", models.DateTimeField(blank=True, null=True)),
                ("finished_at", models.DateTimeField(blank=True, null=True)),
            ],
            options={"db_table": "staff_job_assignment"},
        ),
        migrations.AddIndex(
            model_name="jobassignment",
            index=models.Index(fields=["staff", "status"], name="staff_assign_staff_idx"),
        ),
        migrations.AddIndex(
            model_name="jobassignment",
            index=models.Index(fields=["tenant", "status"], name="staff_assign_tenant_idx"),
        ),
        migrations.CreateModel(
            name="TaskTemplate",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("service", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="task_template", to="catalog.service")),
                ("steps", models.JSONField(default=list)),
            ],
            options={"db_table": "staff_task_template"},
        ),
        migrations.CreateModel(
            name="JobTask",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("assignment", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="tasks", to="staff.jobassignment")),
                ("step_name", models.CharField(max_length=200)),
                ("ordering", models.PositiveSmallIntegerField(default=0)),
                ("is_done", models.BooleanField(default=False)),
                ("done_at", models.DateTimeField(blank=True, null=True)),
            ],
            options={"db_table": "staff_job_task", "ordering": ["ordering"]},
        ),
        migrations.CreateModel(
            name="JobPhoto",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("booking", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="job_photos", to="scheduling.booking")),
                ("staff", models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="job_photos", to=settings.AUTH_USER_MODEL)),
                ("kind", models.CharField(choices=[("before", "Before"), ("after", "After")], db_index=True, max_length=10)),
                ("image_url", models.URLField(max_length=1000)),
                ("s3_key", models.CharField(blank=True, max_length=500)),
                ("caption", models.CharField(blank=True, max_length=255)),
                ("uploaded_at", models.DateTimeField(auto_now_add=True)),
            ],
            options={"db_table": "staff_job_photo"},
        ),
        migrations.AddIndex(
            model_name="jobphoto",
            index=models.Index(fields=["booking", "kind"], name="staff_photo_booking_kind_idx"),
        ),
    ]
