"""
JWT WebSocket authentication middleware.

Django Channels' built-in AuthMiddlewareStack only handles session auth.
This middleware reads a JWT access token from the `?token=` query parameter
and populates scope["user"] so consumers can do `self.scope["user"]`.

Usage in asgi.py:
    from apps.tracking.jwt_auth_middleware import JwtAuthMiddlewareStack
    ...
    "websocket": AllowedHostsOriginValidator(
        JwtAuthMiddlewareStack(URLRouter(websocket_urlpatterns))
    ),
"""
from urllib.parse import parse_qs

from channels.db import database_sync_to_async
from channels.middleware import BaseMiddleware
from django.contrib.auth import get_user_model
from django.contrib.auth.models import AnonymousUser
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from rest_framework_simplejwt.tokens import AccessToken

User = get_user_model()


@database_sync_to_async
def _get_user_from_token(token_key: str):
    """
    Validate the JWT access token and return the matching User.
    Returns AnonymousUser if the token is missing, expired, or invalid.
    """
    try:
        token = AccessToken(token_key)
        user_id = token["user_id"]
        return User.objects.get(pk=user_id, is_active=True)
    except (InvalidToken, TokenError, User.DoesNotExist, KeyError):
        return AnonymousUser()


class JwtAuthMiddleware(BaseMiddleware):
    """
    Channels middleware that authenticates WebSocket connections via a JWT
    passed in the `?token=<access_token>` query parameter.

    Sets scope["user"] to the resolved User instance (or AnonymousUser).
    Consumers should reject anonymous users with close code 4001.
    """

    async def __call__(self, scope, receive, send):
        # Parse query string: b"token=eyJ..." → {"token": ["eyJ..."]}
        qs = parse_qs(scope.get("query_string", b"").decode())
        token_list = qs.get("token", [])
        token_key = token_list[0] if token_list else None

        if token_key:
            scope["user"] = await _get_user_from_token(token_key)
        else:
            scope["user"] = AnonymousUser()

        return await super().__call__(scope, receive, send)


def JwtAuthMiddlewareStack(inner):
    """
    Convenience wrapper — mirrors the signature of channels.auth.AuthMiddlewareStack
    so callers only need to swap the import.
    """
    return JwtAuthMiddleware(inner)
