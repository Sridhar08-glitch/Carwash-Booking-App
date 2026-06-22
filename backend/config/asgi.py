"""
ASGI config — activated in Phase 3 when CHANNELS_ENABLED=True.
Phase 1-2: gunicorn uses wsgi.py; this file is a no-op.
Phase 3: switch Procfile web process to uvicorn/daphne pointing at this.
"""
import os

from django.conf import settings
from django.core.asgi import get_asgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.prod")

django_asgi_app = get_asgi_application()

if settings.CHANNELS_ENABLED:
    from channels.routing import ProtocolTypeRouter, URLRouter
    from channels.security.websocket import AllowedHostsOriginValidator

    import apps.tracking.routing  # noqa: F401  (Phase 3)
    from apps.tracking.jwt_auth_middleware import JwtAuthMiddlewareStack

    application = ProtocolTypeRouter(
        {
            "http": django_asgi_app,
            # JwtAuthMiddlewareStack parses ?token=<JWT> from the query string
            # and populates scope["user"].  The old AuthMiddlewareStack only
            # handled Django session auth and ignored JWT query params, causing
            # all WebSocket connections to be rejected with code 4001.
            "websocket": AllowedHostsOriginValidator(
                JwtAuthMiddlewareStack(URLRouter(apps.tracking.routing.websocket_urlpatterns))
            ),
        }
    )
else:
    application = django_asgi_app
