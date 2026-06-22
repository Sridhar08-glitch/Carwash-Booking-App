from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        ("catalog", "0001_initial"),
        ("loyalty", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="PricingRule",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("name", models.CharField(max_length=200)),
                ("rule_type", models.CharField(choices=[("time_of_day", "Time of Day Window"), ("day_of_week", "Day of Week"), ("loyalty_tier", "Loyalty Tier Discount"), ("seasonal", "Seasonal Promo"), ("early_bird", "Early Bird (first 2 slots)")], max_length=20)),
                ("modifier_type", models.CharField(choices=[("percent_off", "Percentage Off"), ("fixed_off", "Fixed Amount Off"), ("percent_surcharge", "Percentage Surcharge")], max_length=20)),
                ("modifier_value", models.DecimalField(decimal_places=2, max_digits=8)),
                ("priority", models.PositiveSmallIntegerField(default=0)),
                ("is_active", models.BooleanField(db_index=True, default=True)),
                ("time_from", models.TimeField(blank=True, null=True)),
                ("time_to", models.TimeField(blank=True, null=True)),
                ("weekdays", models.JSONField(blank=True, default=list)),
                ("loyalty_tier", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="pricing_rules", to="loyalty.loyaltytier")),
                ("valid_from", models.DateField(blank=True, null=True)),
                ("valid_until", models.DateField(blank=True, null=True)),
                ("service", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="pricing_rules", to="catalog.service")),
            ],
            options={"db_table": "intelligence_pricing_rule", "ordering": ["priority", "name"]},
        ),
    ]
