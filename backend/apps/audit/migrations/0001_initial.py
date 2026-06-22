import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="AuditLog",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("action", models.CharField(db_index=True, max_length=100)),
                ("target_type", models.CharField(db_index=True, max_length=50)),
                ("target_id", models.BigIntegerField(db_index=True)),
                ("before", models.JSONField(blank=True, null=True)),
                ("after", models.JSONField(blank=True, null=True)),
                ("meta", models.JSONField(blank=True, null=True)),
                ("timestamp", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("actor", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="audit_logs", to=settings.AUTH_USER_MODEL)),
            ],
            options={"db_table": "audit_log", "ordering": ["-timestamp"]},
        ),
        migrations.AddIndex(model_name="auditlog", index=models.Index(fields=["target_type", "target_id"], name="audit_log_type_id_idx")),
        migrations.AddIndex(model_name="auditlog", index=models.Index(fields=["actor", "timestamp"], name="audit_log_actor_ts_idx")),
        migrations.CreateModel(
            name="IdempotencyRecord",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ("key", models.CharField(db_index=True, max_length=255)),
                ("endpoint", models.CharField(max_length=500)),
                ("response_payload", models.JSONField()),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
            ],
            options={"db_table": "audit_idempotency_record"},
        ),
        migrations.AlterUniqueTogether(name="idempotencyrecord", unique_together={("key", "endpoint")}),
    ]
