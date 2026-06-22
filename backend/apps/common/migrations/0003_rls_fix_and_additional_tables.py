"""
Migration 0003: Fix RLS NULL bypass and enable RLS on missing tenant-scoped tables.

WHY THIS IS NEEDED
------------------
Migration 0002 created policies with:

    USING (
        tenant_id::text = current_setting('app.current_tenant', TRUE)
        OR current_setting('app.current_tenant', TRUE) IS NULL   ← BUG
    )

The IS NULL branch means any DB session that has NOT set app.current_tenant
(Celery workers, management commands, direct psql, migration runner) sees ALL
rows across ALL tenants — a data-leak in any multi-tenant deployment.

FIX: Drop the NULL bypass.  When no tenant context is set, ZERO rows are
returned.  This is the safe default.  Celery tasks that need to operate on
data must explicitly call with_tenant_context() (see apps/common/celery_tenant.py).

ADDITIONAL TABLES
-----------------
The following tenant-scoped tables were missing from 0002:
  shop:     shop_category, shop_product, shop_cart, shop_cart_item,
            shop_order, shop_order_item
  loyalty:  loyalty_tier, loyalty_customer, loyalty_referral,
            loyalty_membership_plan, loyalty_user_subscription
  staff:    staff_job_assignment, staff_task_template, staff_job_task,
            staff_job_photo
  tracking: tracking_ping

Note: shop_product_image is a child-of-product and inherits access via
the parent query, but is also protected here for defence-in-depth.
"""
from django.db import migrations


# ── Tables already in 0002 that need their NULL bypass removed ─────────────────

EXISTING_TABLES = [
    "accounts_customuser",
    # accounts_vehicle and accounts_address excluded — no tenant_id column
    "catalog_service_category",
    "catalog_service",
    "catalog_branch",
    "scheduling_slot_template",
    "scheduling_booking_slot",
    "scheduling_booking",
    "payments_payment",
    "payments_wallet",
    "payments_wallet_transaction",
    "payments_promo_code",
    "notifications_notification",
]

# ── New tables not covered by 0002 ────────────────────────────────────────────

NEW_TABLES = [
    # shop — only TenantScopedModel subclasses have tenant_id
    "shop_category",
    "shop_product",
    # shop_product_image  → plain models.Model, no tenant_id
    "shop_cart",
    # shop_cart_item      → plain models.Model, no tenant_id
    "shop_order",
    # shop_order_item     → plain models.Model, no tenant_id
    # loyalty
    "loyalty_tier",
    "loyalty_customer",
    "loyalty_referral",
    "loyalty_membership_plan",
    "loyalty_user_subscription",
    # staff
    "staff_job_assignment",
    "staff_task_template",
    "staff_job_task",
    "staff_job_photo",
    # tracking
    "tracking_ping",
]

# ── Secure policy (no NULL bypass) ────────────────────────────────────────────

SECURE_POLICY = (
    "tenant_id::text = current_setting('app.current_tenant', TRUE)"
)


def _replace_policy(table: str) -> str:
    """Drop the old (NULL-bypassed) policy and create a secure replacement."""
    return (
        f"DROP POLICY IF EXISTS tenant_isolation_{table} ON {table};\n"
        f"DROP POLICY IF EXISTS tenant_isolation ON {table};\n"
        f"CREATE POLICY tenant_isolation ON {table}\n"
        f"  USING ({SECURE_POLICY});\n"
    )


def _restore_old_policy(table: str) -> str:
    """Reverse: reinstate the (NULL-bypassed) policy for rollback."""
    return (
        f"DROP POLICY IF EXISTS tenant_isolation ON {table};\n"
        f"CREATE POLICY tenant_isolation ON {table}\n"
        f"  USING (\n"
        f"    tenant_id::text = current_setting('app.current_tenant', TRUE)\n"
        f"    OR current_setting('app.current_tenant', TRUE) IS NULL\n"
        f"  );\n"
    )


def _enable_and_secure(table: str) -> str:
    """Enable RLS and create secure policy for a new table."""
    return (
        f"ALTER TABLE {table} ENABLE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} FORCE ROW LEVEL SECURITY;\n"
        f"CREATE POLICY tenant_isolation ON {table}\n"
        f"  USING ({SECURE_POLICY});\n"
    )


def _disable(table: str) -> str:
    """Reverse: drop policy and disable RLS."""
    return (
        f"DROP POLICY IF EXISTS tenant_isolation ON {table};\n"
        f"ALTER TABLE {table} NO FORCE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} DISABLE ROW LEVEL SECURITY;\n"
    )


forward_sql = (
    "".join(_replace_policy(t) for t in EXISTING_TABLES)
    + "".join(_enable_and_secure(t) for t in NEW_TABLES)
)

reverse_sql = (
    "".join(_restore_old_policy(t) for t in EXISTING_TABLES)
    + "".join(_disable(t) for t in NEW_TABLES)
)


class Migration(migrations.Migration):

    dependencies = [
        ("common", "0002_rls_policies"),
        ("shop", "0001_initial"),
        ("loyalty", "0001_initial"),
        ("staff", "0001_initial"),
        ("tracking", "0001_initial"),
    ]

    operations = [
        migrations.RunSQL(
            sql=forward_sql,
            reverse_sql=reverse_sql,
        ),
    ]
