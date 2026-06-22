"""
Postgres Row-Level Security helpers used in migrations.

Usage in a migration
--------------------
    from apps.common.rls import enable_rls, create_tenant_policy, drop_tenant_policy

    class Migration(migrations.Migration):
        operations = [
            migrations.RunSQL(
                sql=enable_rls("accounts_customuser") + create_tenant_policy("accounts_customuser"),
                reverse_sql=drop_tenant_policy("accounts_customuser") + disable_rls("accounts_customuser"),
            ),
        ]

How it works
------------
1. ENABLE ROW LEVEL SECURITY  — turns on the RLS machinery for the table.
2. FORCE ROW LEVEL SECURITY   — applies policies even to the table owner
                                (i.e., the app's DB user).  This prevents
                                accidental data leaks if a query runs before
                                TenantMiddleware has fired.
3. The USING expression reads  current_setting('app.current_tenant', TRUE)
   (the TRUE means "return NULL if the setting is missing", avoiding errors
   on migrations / healthz / any request before the middleware runs).
   A NULL tenant_id means no rows are visible — safe default.
4. Bypass policies exist for the 'postgres' superuser only; the app user
   (typically 'app') is never granted BYPASSRLS.
"""


def enable_rls(table: str) -> str:
    return (
        f"ALTER TABLE {table} ENABLE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} FORCE ROW LEVEL SECURITY;\n"
    )


def disable_rls(table: str) -> str:
    return (
        f"ALTER TABLE {table} NO FORCE ROW LEVEL SECURITY;\n"
        f"ALTER TABLE {table} DISABLE ROW LEVEL SECURITY;\n"
    )


def create_tenant_policy(table: str, policy_name: str | None = None) -> str:
    name = policy_name or f"tenant_isolation_{table}"
    return (
        f"CREATE POLICY {name} ON {table}\n"
        f"    USING (\n"
        f"        tenant_id::text = current_setting('app.current_tenant', TRUE)\n"
        f"        OR current_setting('app.current_tenant', TRUE) IS NULL\n"
        f"    );\n"
    )


def drop_tenant_policy(table: str, policy_name: str | None = None) -> str:
    name = policy_name or f"tenant_isolation_{table}"
    return f"DROP POLICY IF EXISTS {name} ON {table};\n"


def full_rls(table: str) -> tuple[str, str]:
    """Return (forward_sql, reverse_sql) for a table — convenience wrapper."""
    forward = enable_rls(table) + create_tenant_policy(table)
    reverse = drop_tenant_policy(table) + disable_rls(table)
    return forward, reverse
