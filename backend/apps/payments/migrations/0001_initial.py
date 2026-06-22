import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("common", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Payment",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("amount", models.DecimalField(decimal_places=2, max_digits=12)),
                ("currency", models.CharField(default="SAR", max_length=3)),
                ("method", models.CharField(choices=[("card", "Card"), ("wallet", "Wallet"), ("cash", "Cash / COD"), ("apple_pay", "Apple Pay"), ("google_pay", "Google Pay")], default="cash", max_length=15)),
                ("status", models.CharField(choices=[("pending", "Pending"), ("requires_action", "Requires Action"), ("succeeded", "Succeeded"), ("failed", "Failed"), ("refunded", "Refunded"), ("partially_refunded", "Partially Refunded"), ("cancelled", "Cancelled")], db_index=True, default="pending", max_length=20)),
                ("stripe_payment_intent_id", models.CharField(blank=True, db_index=True, max_length=100)),
                ("stripe_client_secret", models.CharField(blank=True, max_length=200)),
                ("idempotency_key", models.CharField(blank=True, db_index=True, max_length=255)),
                ("refunded_amount", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name="payments", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "payments_payment"},
        ),
        migrations.AddIndex(model_name="payment", index=models.Index(fields=["user", "status"], name="payments_pa_user_status_idx")),
        migrations.AddIndex(model_name="payment", index=models.Index(fields=["tenant", "status"], name="payments_pa_tenant_status_idx")),
        migrations.CreateModel(
            name="Wallet",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("balance", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("currency", models.CharField(default="SAR", max_length=3)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
                ("user", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="wallet", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "payments_wallet"},
        ),
        migrations.CreateModel(
            name="WalletTransaction",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("delta", models.DecimalField(decimal_places=2, max_digits=12)),
                ("balance_after", models.DecimalField(decimal_places=2, max_digits=12)),
                ("reason", models.CharField(choices=[("top_up", "Top Up"), ("booking_payment", "Booking Payment"), ("order_payment", "Order Payment"), ("refund", "Refund"), ("loyalty_credit", "Loyalty Credit"), ("adjustment", "Admin Adjustment")], max_length=20)),
                ("reference", models.CharField(blank=True, max_length=200)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
                ("wallet", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="transactions", to="payments.wallet")),
            ],
            options={"db_table": "payments_wallet_transaction", "ordering": ["-created_at"]},
        ),
        migrations.CreateModel(
            name="PromoCode",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("code", models.CharField(db_index=True, max_length=50)),
                ("discount_type", models.CharField(choices=[("percent", "Percentage"), ("fixed", "Fixed Amount")], max_length=10)),
                ("value", models.DecimalField(decimal_places=2, max_digits=8)),
                ("min_spend", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("usage_limit", models.PositiveIntegerField(blank=True, null=True)),
                ("used_count", models.PositiveIntegerField(default=0)),
                ("valid_from", models.DateTimeField()),
                ("valid_until", models.DateTimeField()),
                ("applies_to", models.CharField(choices=[("wash", "Car Wash"), ("shop", "Shop"), ("both", "Both")], default="both", max_length=5)),
                ("is_active", models.BooleanField(default=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="+", to="common.tenant")),
            ],
            options={"db_table": "payments_promo_code"},
        ),
        migrations.AlterUniqueTogether(name="promocode", unique_together={("tenant", "code")}),
    ]
