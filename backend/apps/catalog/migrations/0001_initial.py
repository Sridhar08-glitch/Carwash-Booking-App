import django.contrib.postgres.fields
import django.core.validators
import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="ServiceCategory",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("name", models.CharField(max_length=100)),
                ("slug", models.SlugField(max_length=100)),
                ("description", models.TextField(blank=True)),
                ("ordering", models.PositiveSmallIntegerField(default=0)),
                ("is_active", models.BooleanField(db_index=True, default=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "catalog_service_category", "ordering": ["ordering", "name"]},
        ),
        migrations.AlterUniqueTogether(name="servicecategory", unique_together={("tenant", "slug")}),
        migrations.CreateModel(
            name="Branch",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("name", models.CharField(max_length=200)),
                ("address", models.CharField(max_length=500)),
                ("city", models.CharField(max_length=100)),
                ("lat", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("lng", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("timezone", models.CharField(default="Asia/Riyadh", max_length=50)),
                ("phone", models.CharField(blank=True, max_length=20)),
                ("is_active", models.BooleanField(db_index=True, default=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "catalog_branch"},
        ),
        migrations.AddIndex(model_name="branch", index=models.Index(fields=["tenant", "is_active"], name="catalog_br_tenant_active_idx")),
        migrations.CreateModel(
            name="BranchHours",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("weekday", models.PositiveSmallIntegerField(validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(6)])),
                ("open_time", models.TimeField()),
                ("close_time", models.TimeField()),
                ("is_closed", models.BooleanField(default=False)),
                ("branch", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="hours", to="catalog.branch")),
            ],
            options={"db_table": "catalog_branch_hours", "ordering": ["weekday"]},
        ),
        migrations.AlterUniqueTogether(name="branchhours", unique_together={("branch", "weekday")}),
        migrations.CreateModel(
            name="Service",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("name", models.CharField(max_length=200)),
                ("slug", models.SlugField(max_length=200)),
                ("description", models.TextField(blank=True)),
                ("base_price", models.DecimalField(decimal_places=2, max_digits=12)),
                ("currency", models.CharField(default="SAR", max_length=3)),
                ("duration_minutes", models.PositiveSmallIntegerField(default=60)),
                ("image", models.ImageField(blank=True, null=True, upload_to="services/")),
                ("tags", django.contrib.postgres.fields.ArrayField(base_field=models.CharField(max_length=50), blank=True, default=list, size=None)),
                ("is_mobile_available", models.BooleanField(default=True)),
                ("is_active", models.BooleanField(db_index=True, default=True)),
                ("category", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="services", to="catalog.servicecategory")),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "catalog_service"},
        ),
        migrations.AlterUniqueTogether(name="service", unique_together={("tenant", "slug")}),
        migrations.AddIndex(model_name="service", index=models.Index(fields=["tenant", "is_active"], name="catalog_svc_tenant_active_idx")),
        migrations.AddIndex(model_name="service", index=models.Index(fields=["category", "is_active"], name="catalog_svc_cat_active_idx")),
    ]
