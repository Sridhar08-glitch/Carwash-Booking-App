from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        ("scheduling", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="TrackingPing",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("booking", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="tracking_pings", to="scheduling.booking")),
                ("staff", models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="tracking_pings", to=settings.AUTH_USER_MODEL)),
                ("lat", models.DecimalField(decimal_places=6, max_digits=9)),
                ("lng", models.DecimalField(decimal_places=6, max_digits=9)),
                ("accuracy_m", models.FloatField(blank=True, null=True)),
                ("recorded_at", models.DateTimeField(db_index=True)),
            ],
            options={"db_table": "tracking_ping", "ordering": ["-recorded_at"]},
        ),
        migrations.AddIndex(
            model_name="trackingping",
            index=models.Index(fields=["booking", "recorded_at"], name="tracking_booking_ts_idx"),
        ),
    ]
