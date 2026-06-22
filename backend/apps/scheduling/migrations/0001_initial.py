import django.contrib.postgres.fields
import django.core.validators
import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("catalog", "0001_initial"),
        ("common", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("payments", "0001_initial"),
        ("accounts", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="SlotTemplate",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("slot_minutes", models.PositiveSmallIntegerField(default=60)),
                ("capacity_per_slot", models.PositiveSmallIntegerField(default=1)),
                ("active_weekdays", django.contrib.postgres.fields.ArrayField(base_field=models.PositiveSmallIntegerField(validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(6)]), default=list, size=None)),
                ("is_active", models.BooleanField(default=True)),
                ("branch", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="slot_templates", to="catalog.branch")),
                ("service", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name="slot_templates", to="catalog.service")),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "scheduling_slot_template"},
        ),
        migrations.AddIndex(model_name="slottemplate", index=models.Index(fields=["branch", "is_active"], name="sched_st_branch_active_idx")),
        migrations.CreateModel(
            name="BookingSlot",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("date", models.DateField(db_index=True)),
                ("start_time", models.TimeField()),
                ("end_time", models.TimeField()),
                ("capacity_total", models.PositiveSmallIntegerField(default=1)),
                ("capacity_left", models.PositiveSmallIntegerField(default=1)),
                ("is_active", models.BooleanField(default=True)),
                ("branch", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="slots", to="catalog.branch")),
                ("service", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name="slots", to="catalog.service")),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "scheduling_booking_slot"},
        ),
        migrations.AlterUniqueTogether(name="bookingslot", unique_together={("branch", "service", "date", "start_time")}),
        migrations.AddIndex(model_name="bookingslot", index=models.Index(fields=["branch", "date", "is_active"], name="sched_bs_branch_date_idx")),
        migrations.AddIndex(model_name="bookingslot", index=models.Index(fields=["tenant", "date", "is_active"], name="sched_bs_tenant_date_idx")),
        migrations.CreateModel(
            name="Booking",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("status", models.CharField(choices=[("pending", "Pending"), ("confirmed", "Confirmed"), ("assigned", "Staff Assigned"), ("en_route", "En Route"), ("in_progress", "In Progress"), ("completed", "Completed"), ("cancelled", "Cancelled"), ("no_show", "No Show")], db_index=True, default="pending", max_length=15)),
                ("location_type", models.CharField(choices=[("branch", "Branch"), ("mobile", "Mobile / At-Home")], default="branch", max_length=10)),
                ("mobile_lat", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("mobile_lng", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("price_charged", models.DecimalField(decimal_places=2, max_digits=12)),
                ("currency", models.CharField(default="SAR", max_length=3)),
                ("idempotency_key", models.CharField(blank=True, db_index=True, max_length=255)),
                ("cancellation_reason", models.TextField(blank=True)),
                ("cancelled_at", models.DateTimeField(blank=True, null=True)),
                ("scheduled_date", models.DateField(db_index=True)),
                ("scheduled_start", models.TimeField()),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="bookings", to=settings.AUTH_USER_MODEL)),
                ("service", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="bookings", to="catalog.service")),
                ("branch", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name="bookings", to="catalog.branch")),
                ("slot", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="bookings", to="scheduling.bookingslot")),
                ("vehicle", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="bookings", to="accounts.vehicle")),
                ("address", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="bookings", to="accounts.address")),
                ("assigned_staff", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="assigned_bookings", to=settings.AUTH_USER_MODEL)),
                ("payment", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="bookings", to="payments.payment")),
            ],
            options={"db_table": "scheduling_booking"},
        ),
        migrations.AddIndex(model_name="booking", index=models.Index(fields=["user", "status"], name="sched_bk_user_status_idx")),
        migrations.AddIndex(model_name="booking", index=models.Index(fields=["tenant", "status", "scheduled_date"], name="sched_bk_tenant_status_date_idx")),
        migrations.AddIndex(model_name="booking", index=models.Index(fields=["assigned_staff", "status"], name="sched_bk_staff_status_idx")),
    ]
