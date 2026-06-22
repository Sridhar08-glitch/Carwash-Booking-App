"""
Phase 2 notifications migrations:
- Add NotificationTrigger and NotificationPreference models.
- Add fcm_message_id and type choices to Notification.
"""
import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("notifications", "0001_initial"),
        ("common", "0001_initial"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        # 1. Update Notification.type to use the new choices + add fcm_message_id
        migrations.AlterField(
            model_name="notification",
            name="type",
            field=models.CharField(
                choices=[
                    ("booking_confirmed", "Booking Confirmed"),
                    ("booking_reminder_24h", "Booking Reminder 24h"),
                    ("booking_reminder_1h", "Booking Reminder 1h"),
                    ("booking_cancelled", "Booking Cancelled"),
                    ("booking_completed", "Booking Completed"),
                    ("order_confirmed", "Order Confirmed"),
                    ("order_shipped", "Order Shipped"),
                    ("order_delivered", "Order Delivered"),
                    ("abandoned_cart", "Abandoned Cart"),
                    ("birthday", "Birthday"),
                    ("membership_renewal", "Membership Renewal"),
                    ("weather_alert", "Weather Alert"),
                    ("loyalty_points", "Loyalty Points Earned"),
                    ("general", "General"),
                ],
                db_index=True,
                default="general",
                max_length=30,
            ),
        ),
        migrations.AddField(
            model_name="notification",
            name="fcm_message_id",
            field=models.CharField(blank=True, max_length=200),
        ),
        migrations.AddIndex(
            model_name="notification",
            index=models.Index(fields=["user", "is_read"], name="notif_user_read_idx"),
        ),
        migrations.AddIndex(
            model_name="notification",
            index=models.Index(fields=["tenant", "type"], name="notif_tenant_type_idx"),
        ),

        # 2. NotificationTrigger
        migrations.CreateModel(
            name="NotificationTrigger",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("event", models.CharField(
                    choices=[
                        ("booking_reminder_24h", "Booking Reminder 24h Before"),
                        ("booking_reminder_1h", "Booking Reminder 1h Before"),
                        ("abandoned_cart", "Abandoned Cart"),
                        ("birthday", "Birthday"),
                        ("membership_renewal", "Membership Renewal"),
                        ("weather_alert", "Weather Alert"),
                    ],
                    db_index=True,
                    max_length=30,
                )),
                ("offset_hours", models.IntegerField(default=0)),
                ("title_template", models.CharField(max_length=255)),
                ("body_template", models.TextField()),
                ("is_active", models.BooleanField(db_index=True, default=True)),
            ],
            options={"db_table": "notifications_trigger"},
        ),
        migrations.AlterUniqueTogether(
            name="notificationtrigger",
            unique_together={("tenant", "event")},
        ),

        # 3. NotificationPreference
        migrations.CreateModel(
            name="NotificationPreference",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                ("is_deleted", models.BooleanField(db_index=True, default=False)),
                ("deleted_at", models.DateTimeField(blank=True, null=True)),
                ("tenant", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="%(class)s_set", to="common.tenant")),
                ("user", models.OneToOneField(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name="notification_prefs",
                    to=settings.AUTH_USER_MODEL,
                )),
                ("booking_reminders", models.BooleanField(default=True)),
                ("order_updates", models.BooleanField(default=True)),
                ("promotions", models.BooleanField(default=True)),
                ("loyalty_updates", models.BooleanField(default=True)),
                ("push_enabled", models.BooleanField(default=True)),
            ],
            options={"db_table": "notifications_preference"},
        ),
    ]
