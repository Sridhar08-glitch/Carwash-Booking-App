import django.contrib.auth.models
import django.contrib.auth.validators
import django.db.models.deletion
import django.utils.timezone
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("auth", "0012_alter_user_first_name_max_length"),
        ("common", "0001_initial"),
        ("catalog", "0001_initial"),  # StaffProfile.branch is a FK to catalog.Branch
    ]

    operations = [
        migrations.CreateModel(
            name="CustomUser",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("password", models.CharField(max_length=128, verbose_name="password")),
                ("last_login", models.DateTimeField(blank=True, null=True, verbose_name="last login")),
                ("is_superuser", models.BooleanField(default=False)),
                ("username", models.CharField(max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()])),
                ("first_name", models.CharField(blank=True, max_length=150)),
                ("last_name", models.CharField(blank=True, max_length=150)),
                ("is_staff", models.BooleanField(default=False)),
                ("is_active", models.BooleanField(default=True)),
                ("date_joined", models.DateTimeField(default=django.utils.timezone.now)),
                ("phone", models.CharField(max_length=20, unique=True)),
                ("email", models.EmailField(blank=True, null=True, unique=True)),
                ("role", models.CharField(choices=[("customer", "Customer"), ("staff", "Staff"), ("admin", "Admin")], default="customer", max_length=10)),
                ("is_phone_verified", models.BooleanField(default=False)),
                ("fcm_token", models.TextField(blank=True, default="")),
                ("locale", models.CharField(default="en", max_length=10)),
                ("date_of_birth", models.DateField(blank=True, null=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("groups", models.ManyToManyField(blank=True, related_name="user_set", related_query_name="user", to="auth.group", verbose_name="groups")),
                ("user_permissions", models.ManyToManyField(blank=True, related_name="user_set", related_query_name="user", to="auth.permission", verbose_name="user permissions")),
                ("tenant", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name="users", to="common.tenant")),
            ],
            options={"db_table": "accounts_customuser"},
            managers=[
                ("objects", django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.AddIndex(
            model_name="customuser",
            index=models.Index(fields=["tenant", "phone"], name="accounts_cu_tenant_i_phone_idx"),
        ),
        migrations.AddIndex(
            model_name="customuser",
            index=models.Index(fields=["tenant", "role"], name="accounts_cu_tenant_i_role_idx"),
        ),
        migrations.CreateModel(
            name="CustomerProfile",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("referral_code", models.CharField(blank=True, max_length=20, unique=True)),
                ("points_cache", models.PositiveIntegerField(default=0)),
                ("user", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="customer_profile", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "accounts_customer_profile"},
        ),
        migrations.CreateModel(
            name="StaffProfile",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("is_available", models.BooleanField(default=True)),
                ("rating_avg", models.DecimalField(decimal_places=2, default=0, max_digits=3)),
                ("jobs_completed", models.PositiveIntegerField(default=0)),
                ("user", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="staff_profile", to=settings.AUTH_USER_MODEL)),
                ("branch", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="staff_members", to="catalog.branch")),
            ],
            options={"db_table": "accounts_staff_profile"},
        ),
        migrations.CreateModel(
            name="Vehicle",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("make", models.CharField(max_length=100)),
                ("model", models.CharField(max_length=100)),
                ("year", models.PositiveSmallIntegerField(blank=True, null=True)),
                ("plate", models.CharField(max_length=20)),
                ("colour", models.CharField(blank=True, max_length=50)),
                ("vehicle_type", models.CharField(choices=[("sedan", "Sedan"), ("suv", "SUV"), ("truck", "Truck"), ("van", "Van"), ("hatchback", "Hatchback"), ("coupe", "Coupe"), ("convertible", "Convertible"), ("other", "Other")], default="sedan", max_length=15)),
                ("notes", models.TextField(blank=True)),
                ("is_default", models.BooleanField(default=False)),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="vehicles", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "accounts_vehicle"},
        ),
        migrations.AlterUniqueTogether(name="vehicle", unique_together={("user", "plate")}),
        migrations.AddIndex(model_name="vehicle", index=models.Index(fields=["user", "is_deleted"], name="accounts_ve_user_id_is_del_idx")),
        migrations.CreateModel(
            name="Address",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("label", models.CharField(blank=True, default="Home", max_length=100)),
                ("line1", models.CharField(max_length=255)),
                ("line2", models.CharField(blank=True, max_length=255)),
                ("city", models.CharField(max_length=100)),
                ("state", models.CharField(blank=True, max_length=100)),
                ("postal_code", models.CharField(blank=True, max_length=20)),
                ("country", models.CharField(default="SA", max_length=2)),
                ("lat", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("lng", models.DecimalField(blank=True, decimal_places=6, max_digits=9, null=True)),
                ("is_default", models.BooleanField(default=False)),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="addresses", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "accounts_address"},
        ),
        migrations.AddIndex(model_name="address", index=models.Index(fields=["user", "is_deleted"], name="accounts_ad_user_id_is_del_idx")),
        # Add default_address FK to CustomerProfile (after Address table exists)
        migrations.AddField(
            model_name="customerprofile",
            name="default_address",
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="+", to="accounts.address"),
        ),
        migrations.CreateModel(
            name="OTPCode",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("phone", models.CharField(db_index=True, max_length=20)),
                ("code_hash", models.CharField(max_length=64)),
                ("expires_at", models.DateTimeField()),
                ("attempts", models.PositiveSmallIntegerField(default=0)),
                ("used", models.BooleanField(default=False)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
            ],
            options={"db_table": "accounts_otp_code"},
        ),
        migrations.AddIndex(model_name="otpcode", index=models.Index(fields=["phone", "used", "expires_at"], name="accounts_ot_phone_used_exp_idx")),
    ]
