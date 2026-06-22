from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        ("catalog", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="ServiceArea",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("branch", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="service_areas", to="catalog.branch")),
                ("name", models.CharField(blank=True, max_length=100)),
                ("polygon_coords", models.JSONField(default=list)),
                ("radius_km", models.DecimalField(decimal_places=2, default=10, max_digits=6)),
                ("is_active", models.BooleanField(default=True)),
            ],
            options={"db_table": "geo_service_area"},
        ),
    ]
