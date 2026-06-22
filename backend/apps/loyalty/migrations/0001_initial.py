from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="LoyaltyTier",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("name", models.CharField(max_length=100)),
                ("threshold_washes", models.PositiveIntegerField(default=0)),
                ("discount_percent", models.DecimalField(decimal_places=2, default=0, max_digits=5)),
                ("perks", models.JSONField(blank=True, default=dict)),
                ("is_active", models.BooleanField(default=True)),
            ],
            options={"db_table": "loyalty_tier", "ordering": ["threshold_washes"]},
        ),
        migrations.CreateModel(
            name="CustomerLoyalty",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("user", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="loyalty", to=settings.AUTH_USER_MODEL)),
                ("washes_count", models.PositiveIntegerField(default=0)),
                ("points", models.PositiveIntegerField(default=0)),
                ("current_tier", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to="loyalty.loyaltytier")),
            ],
            options={"db_table": "loyalty_customer"},
        ),
        migrations.CreateModel(
            name="Referral",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("referrer", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="referrals_made", to=settings.AUTH_USER_MODEL)),
                ("referee", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="referred_by", to=settings.AUTH_USER_MODEL)),
                ("code", models.CharField(db_index=True, max_length=20)),
                ("reward_state", models.CharField(choices=[("pending", "Pending"), ("awarded", "Awarded"), ("expired", "Expired")], default="pending", max_length=10)),
                ("referee_phone", models.CharField(blank=True, max_length=20)),
            ],
            options={"db_table": "loyalty_referral"},
        ),
        migrations.CreateModel(
            name="MembershipPlan",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("name", models.CharField(max_length=200)),
                ("description", models.TextField(blank=True)),
                ("price", models.DecimalField(decimal_places=2, max_digits=12)),
                ("currency", models.CharField(default="SAR", max_length=3)),
                ("billing_interval", models.CharField(choices=[("month", "Monthly"), ("year", "Annual")], default="month", max_length=10)),
                ("included_washes", models.PositiveSmallIntegerField(default=4)),
                ("discount_percent", models.DecimalField(decimal_places=2, default=0, max_digits=5)),
                ("stripe_price_id", models.CharField(blank=True, max_length=100)),
                ("is_active", models.BooleanField(default=True)),
            ],
            options={"db_table": "loyalty_membership_plan"},
        ),
        migrations.CreateModel(
            name="UserSubscription",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="subscriptions", to=settings.AUTH_USER_MODEL)),
                ("plan", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to="loyalty.membershipplan")),
                ("stripe_subscription_id", models.CharField(blank=True, db_index=True, max_length=100)),
                ("stripe_customer_id", models.CharField(blank=True, max_length=100)),
                ("status", models.CharField(choices=[("active", "Active"), ("past_due", "Past Due"), ("cancelled", "Cancelled"), ("incomplete", "Incomplete"), ("trialing", "Trialing")], db_index=True, default="incomplete", max_length=15)),
                ("current_period_start", models.DateTimeField(blank=True, null=True)),
                ("current_period_end", models.DateTimeField(blank=True, null=True)),
                ("washes_used_this_period", models.PositiveSmallIntegerField(default=0)),
                ("cancelled_at", models.DateTimeField(blank=True, null=True)),
            ],
            options={"db_table": "loyalty_user_subscription"},
        ),
    ]
