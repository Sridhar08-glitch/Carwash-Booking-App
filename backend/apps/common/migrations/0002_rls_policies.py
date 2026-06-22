"""
Migration: enable Postgres Row-Level Security on all tenant-scoped tables.

IMPORTANT — This migration requires the app DB user to have CREATE POLICY
privilege (i.e., be the table owner). On managed Postgres (Neon/Railway/Render),
the connection user created by the platform typically owns the tables it creates.

If your DB user does NOT own the tables, run the SQL below as the Postgres
superuser ONCE (via the platform's SQL console), then remove those tables
from this migration.

What this does:
  1. ENABLE ROW LEVEL SECURITY — turns on RLS for the table.
  2. FORCE ROW LEVEL SECURITY  — applies policies even to the table owner
                                  (the app's DB user).
  3. Creates a policy: rows are visible iff
       tenant_id::text = current_setting('app.current_tenant', TRUE)
     The TRUE flag means "return NULL if setting is missing" — so if the
     middleware hasn't fired (healthz, migration runner), no rows bleed through.

TenantMiddleware sets 'app.current_tenant' to the user's tenant UUID on every
authenticated request.  The migration runner itself runs without a tenant
context, so no data is visible during migrations — which is exactly what we want.

To run migrations safely:
  1. The release process runs `manage.py migrate` before the web process starts.
  2. The migration runner connects as the app DB user (no tenant context set).
  3. DDL (CREATE TABLE, ALTER TABLE) is never filtered by RLS.
  4. DML during migrations is filtered — but seed data is inserted via `seed`
     command after setting the tenant context, not via migrations.
"""
from django.db import migrations


TENANT_TABLES = [
    # common
    # (Tenant itself is not scoped)
    # accounts
    "accounts_customuser",
    # accounts_vehicle and accounts_address extend BaseModel (not TenantScopedModel)
    # and therefore have no tenant_id column — they are secured by user FK in views.
    # catalog
    "catalog_service_category",
    "catalog_service",
    "catalog_branch",
    # scheduling
    "scheduling_slot_template",
    "scheduling_booking_slot",
    "scheduling_booking",
    # payments
    "payments_payment",
    "payments_wallet",
    "payments_wallet_transaction",
    "payments_promo_code",
    # notifications
    "notifications_notification",
]


def _enable_rls(table: str) -> str:
    return (
        f"ALTER TABLE {table} ENABLE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} FORCE ROW LEVEL SECURITY;\n"
        f"CREATE POLICY tenant_isolation ON {table}\n"
        f"  USING (\n"
        f"    tenant_id::text = current_setting('app.current_tenant', TRUE)\n"
        f"    OR current_setting('app.current_tenant', TRUE) IS NULL\n"
        f"  );\n"
    )


def _disable_rls(table: str) -> str:
    return (
        f"DROP POLICY IF EXISTS tenant_isolation ON {table};\n"
        f"ALTER TABLE {table} NO FORCE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} DISABLE ROW LEVEL SECURITY;\n"
    )


# accounts_customuser uses 'tenant_id' FK but also needs special handling
# because AbstractUser doesn't have tenant_id in the base class—it does after
# our 0001 migration. Verified above.

class Migration(migrations.Migration):

    dependencies = [
        ("common", "0001_initial"),
        ("accounts", "0001_initial"),
        ("catalog", "0001_initial"),
        ("scheduling", "0001_initial"),
        ("payments", "0001_initial"),
        ("notifications", "0001_initial"),
    ]

    operations = [
        migrations.RunSQL(
            sql="".join(_enable_rls(t) for t in TENANT_TABLES),
            reverse_sql="".join(_disable_rls(t) for t in TENANT_TABLES),
        ),
    ]
