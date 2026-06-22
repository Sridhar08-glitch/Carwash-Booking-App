"""Root URL configuration."""
from django.conf import settings
from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

from apps.common.views import health_check, readiness_check

urlpatterns = [
    # -- Health / readiness -------------------------------------------------------
    path("healthz", health_check, name="health-check"),
    path("readyz", readiness_check, name="readiness-check"),

    # -- Django admin -------------------------------------------------------------
    path("django-admin/", admin.site.urls),

    # -- OpenAPI schema -----------------------------------------------------------
    path("api/schema", SpectacularAPIView.as_view(), name="schema"),
    path("api/schema/swagger-ui/", SpectacularSwaggerView.as_view(url_name="schema"), name="swagger-ui"),

    # -- API v1 -------------------------------------------------------------------
    path("api/v1/", include("apps.accounts.urls")),
    path("api/v1/", include("apps.catalog.urls")),
    path("api/v1/", include("apps.scheduling.urls")),
    path("api/v1/", include("apps.payments.urls")),
    path("api/v1/", include("apps.shop.urls")),
    path("api/v1/", include("apps.notifications.urls")),
    path("api/v1/", include("apps.staff.urls")),
    path("api/v1/", include("apps.loyalty.urls")),
    path("api/v1/", include("apps.tracking.urls")),
    path("api/v1/", include("apps.analytics.urls")),
    path("api/v1/", include("apps.common.urls")),  # home/layout + admin-api
]

if settings.DEBUG:
    from django.conf.urls.static import static
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
