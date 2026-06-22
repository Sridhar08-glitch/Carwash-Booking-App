"""
Application-level middleware.

TenantMiddleware
    Sets the Postgres variable `app.current_tenant` on every authenticated
    request so RLS policies can filter rows correctly.

    Strategy
    --------
    * We use  set_config('app.current_tenant', id, TRUE)  (transaction-local).
      The value is automatically cleared when the current transaction ends —
      so it cannot bleed across requests even when CONN_MAX_AGE > 0 or
      PgBouncer is used in transaction-pooling mode.
    * Service-layer code that opens nested transactions (transaction.atomic())
      still sees the variable because Postgres inherits session state into
      savepoints; the clear only happens on the outermost commit/rollback.
    * Celery tasks must set the context themselves via
      apps.common.celery_tenant.with_tenant_context().

RequestIDMiddleware
    Injects a UUID request-id into every request/response for structured
    logging and distributed tracing.
"""
import uuid

from django.db import connection, transaction


class TenantMiddleware:
    """Set app.current_tenant Postgres variable (transaction-local) per request."""

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        tenant_id = self._resolve_tenant(request)
        if tenant_id:
            # Wrap dispatch in a transaction so transaction-local set_config
            # is guaranteed to be in scope for all DB work in this request.
            with transaction.atomic():
                self._set_tenant_context(str(tenant_id))
                response = self.get_response(request)
        else:
            response = self.get_response(request)
        return response

    # ── helpers ──────────────────────────────────────────────────────────────

    @staticmethod
    def _resolve_tenant(request) -> str | None:
        """
        Return the tenant UUID for this request, or None.

        Resolution order:
          1. Authenticated user's tenant_id  (most requests via session auth)
          2. X-Tenant-ID header              (machine-to-machine / admin API)
          3. Bearer JWT tenant_id claim      (JWT requests — before DRF auth runs)
          4. None                            (unauthenticated / public endpoints)

        For JWT requests, request.user is still AnonymousUser at middleware time
        because DRF's JWTAuthentication runs at the view layer. We decode the
        Bearer token here (signature-verified) to extract tenant_id so we can set
        app.current_tenant *before* DRF queries accounts_customuser (RLS requires it).
        """
        if hasattr(request, "user") and request.user.is_authenticated:
            return getattr(request.user, "tenant_id", None)
        header_val = request.headers.get("X-Tenant-ID")
        if header_val:
            return header_val
        # Decode the Bearer token to get tenant_id without a DB round-trip.
        # UntypedToken validates the signature and expiry — invalid/expired tokens
        # still return None here and will be rejected by DRF auth as usual.
        auth_header = request.META.get("HTTP_AUTHORIZATION", "")
        if auth_header.startswith("Bearer "):
            try:
                from rest_framework_simplejwt.tokens import UntypedToken  # noqa: PLC0415
                raw_token = auth_header.split(" ", 1)[1]
                token = UntypedToken(raw_token)
                tenant_id = token.get("tenant_id")
                if tenant_id:
                    return str(tenant_id)
            except Exception:
                pass
        return None

    @staticmethod
    def _set_tenant_context(tenant_id: str) -> None:
        """
        Set app.current_tenant as a transaction-local Postgres variable.

        is_local=TRUE means the variable is cleared automatically on transaction
        end — safe for persistent connections and PgBouncer transaction-pooling
        without any additional CONN_MAX_AGE=0 requirement.
        """
        try:
            with connection.cursor() as cursor:
                # transaction-local (is_local=TRUE): cleared on commit/rollback
                cursor.execute(
                    "SELECT set_config('app.current_tenant', %s, TRUE)",
                    [tenant_id],
                )
        except Exception:
            # Don't break the request if DB isn't reachable yet (health check, etc.)
            pass


class RequestIDMiddleware:
    """Attach a UUID request-id to request and response."""

    HEADER = "X-Request-ID"

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        request_id = request.headers.get(self.HEADER) or str(uuid.uuid4())
        request.request_id = request_id
        response = self.get_response(request)
        response[self.HEADER] = request_id
        return response
