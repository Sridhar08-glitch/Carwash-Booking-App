"""
Consistent error envelope for every API response.

All errors are returned as:
{
    "code": "VALIDATION_ERROR",
    "message": "Human-readable summary.",
    "detail": "...",           // optional longer description
    "field_errors": {          // only present for validation errors
        "email": ["Enter a valid email address."]
    }
}

Error codes (extend as needed)
-------------------------------
VALIDATION_ERROR        — serializer / field-level validation failed
AUTHENTICATION_FAILED   — token missing, expired, or invalid
PERMISSION_DENIED       — authenticated but not authorised
NOT_FOUND               — resource does not exist (or is soft-deleted)
CONFLICT                — idempotency replay or slot/stock conflict
RATE_LIMITED            — throttle hit
SERVER_ERROR            — unexpected 500
"""
import logging

from django.core.exceptions import PermissionDenied
from django.http import Http404
from rest_framework import status
from rest_framework.exceptions import (
    AuthenticationFailed,
    NotAuthenticated,
    NotFound,
    PermissionDenied as DRFPermissionDenied,
    Throttled,
    ValidationError,
)
from rest_framework.response import Response
from rest_framework.views import exception_handler as drf_exception_handler

logger = logging.getLogger(__name__)


# ── Canonical error codes ─────────────────────────────────────────────────────

class ErrorCode:
    VALIDATION_ERROR = "VALIDATION_ERROR"
    AUTHENTICATION_FAILED = "AUTHENTICATION_FAILED"
    PERMISSION_DENIED = "PERMISSION_DENIED"
    NOT_FOUND = "NOT_FOUND"
    CONFLICT = "CONFLICT"
    RATE_LIMITED = "RATE_LIMITED"
    SERVER_ERROR = "SERVER_ERROR"


# ── Custom exception classes ──────────────────────────────────────────────────

class AppError(Exception):
    """Base class for application-level errors raised in the service layer."""

    status_code: int = status.HTTP_400_BAD_REQUEST
    default_code: str = ErrorCode.VALIDATION_ERROR
    default_message: str = "An error occurred."

    def __init__(self, message: str | None = None, code: str | None = None, detail: str = ""):
        self.message = message or self.default_message
        self.code = code or self.default_code
        self.detail = detail
        super().__init__(self.message)


class ConflictError(AppError):
    status_code = status.HTTP_409_CONFLICT
    default_code = ErrorCode.CONFLICT
    default_message = "Resource conflict."


class NotFoundError(AppError):
    status_code = status.HTTP_404_NOT_FOUND
    default_code = ErrorCode.NOT_FOUND
    default_message = "Not found."


class PermissionError(AppError):  # noqa: A001
    status_code = status.HTTP_403_FORBIDDEN
    default_code = ErrorCode.PERMISSION_DENIED
    default_message = "Permission denied."


# ── Exception handler ─────────────────────────────────────────────────────────

def _build_envelope(code: str, message: str, detail: str = "", field_errors=None) -> dict:
    envelope = {"code": code, "message": message, "detail": detail}
    if field_errors:
        envelope["field_errors"] = field_errors
    return envelope


def custom_exception_handler(exc, context):
    """
    Convert all exceptions to the standard error envelope.
    Falls back to DRF's handler for unrecognised exceptions.
    """
    # Convert Django core exceptions to DRF equivalents
    if isinstance(exc, Http404):
        exc = NotFound()
    elif isinstance(exc, PermissionDenied):
        exc = DRFPermissionDenied()

    # Handle our own AppError family
    if isinstance(exc, AppError):
        return Response(
            _build_envelope(exc.code, exc.message, exc.detail),
            status=exc.status_code,
        )

    # DRF native exceptions
    response = drf_exception_handler(exc, context)

    if response is not None:
        if isinstance(exc, (NotAuthenticated, AuthenticationFailed)):
            code = ErrorCode.AUTHENTICATION_FAILED
            message = "Authentication required."
        elif isinstance(exc, (DRFPermissionDenied,)):
            code = ErrorCode.PERMISSION_DENIED
            message = "You do not have permission to perform this action."
        elif isinstance(exc, NotFound):
            code = ErrorCode.NOT_FOUND
            message = "The requested resource was not found."
        elif isinstance(exc, Throttled):
            code = ErrorCode.RATE_LIMITED
            wait = getattr(exc, "wait", None)
            message = f"Rate limit exceeded. Retry in {int(wait)}s." if wait else "Rate limit exceeded."
        elif isinstance(exc, ValidationError):
            code = ErrorCode.VALIDATION_ERROR
            message = "Validation failed."
            # Normalise field errors
            errors = exc.detail
            if isinstance(errors, dict):
                field_errors = {
                    k: [str(e) for e in v] if isinstance(v, list) else [str(v)]
                    for k, v in errors.items()
                }
            elif isinstance(errors, list):
                field_errors = {"non_field_errors": [str(e) for e in errors]}
            else:
                field_errors = {"non_field_errors": [str(errors)]}
            response.data = _build_envelope(code, message, field_errors=field_errors)
            return response
        else:
            code = ErrorCode.SERVER_ERROR
            message = "An unexpected error occurred."

        response.data = _build_envelope(code, message)

    else:
        # Unhandled exception → 500
        logger.exception("Unhandled exception in view: %s", exc)
        response = Response(
            _build_envelope(ErrorCode.SERVER_ERROR, "An unexpected error occurred."),
            status=status.HTTP_500_INTERNAL_SERVER_ERROR,
        )

    return response
