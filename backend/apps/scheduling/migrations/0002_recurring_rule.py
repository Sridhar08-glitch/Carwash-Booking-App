from django.conf import settings
from django.contrib.postgres.fields import ArrayField
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("common", "0001_initial"),
        ("scheduling", "0001_initial"),
        ("catalog", "0001_initial"),
        ("accounts", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="RecurringBookingRule",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="recurring_rules", to=settings.AUTH_USER_MODEL)),
                ("service", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="recurring_rules", to="catalog.service")),
                ("branch", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name="recurring_rules", to="catalog.branch")),
                ("frequency", models.CharField(choices=[("weekly", "Every Week"), ("biweekly", "Every 2 Weeks"), ("monthly", "Every Month")], max_length=10)),
                ("preferred_weekday", models.PositiveSmallIntegerField(validators=[MinValueValidator(0), MaxValueValidator(6)])),
                ("preferred_time", models.TimeField()),
                ("location_type", models.CharField(choices=[("branch", "Branch"), ("mobile", "Mobile")], default="branch", max_length=10)),
                ("address", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to="accounts.address")),
                ("vehicle", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to="accounts.vehicle")),
                ("default_payment_method", models.CharField(default="wallet", max_length=15)),
                ("is_active", models.BooleanField(db_index=True, default=True)),
                ("last_booking_date", models.DateField(blank=True, null=True)),
            ],
            options={"db_table": "scheduling_recurring_rule"},
        ),
        migrations.AddIndex(
            model_name="recurringbookingrule",
            index=models.Index(fields=["user", "is_active"], name="recurring_user_active_idx"),
        ),
    ]
