"""
Base settings shared across all environments.
All secrets come from environment variables via django-environ.
Never hard-code credentials here.
"""
from datetime import timedelta
from pathlib import Path

import environ

# -- Paths --------------------------------------------------------------------
BASE_DIR = Path(__file__).resolve().parent.parent.parent

env = environ.Env(
    DEBUG=(bool, False),
    GEO_ENABLED=(bool, False),
    CHANNELS_ENABLED=(bool, False),
    CONN_MAX_AGE=(int, 0),
    OTP_EXPIRY_MINUTES=(int, 5),
    OTP_MAX_ATTEMPTS=(int, 5),
    SMS_ENABLED=(bool, False),
    SOCIAL_AUTH_ENABLED=(bool, False),
    # Redis is optional in local dev (dev.py overrides cache/broker with
    # in-memory backends). The default below only keeps base.py importable
    # when REDIS_URL is absent from .env.
    REDIS_URL=(str, "redis://localhost:6379/0"),
)

# -- Security -----------------------------------------------------------------
SECRET_KEY = env("SECRET_KEY")
DEBUG = env("DEBUG")
ALLOWED_HOSTS = env.list("ALLOWED_HOSTS", default=["*"])

# -- Application --------------------------------------------------------------
DJANGO_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
]

THIRD_PARTY_APPS = [
    "rest_framework",
    "rest_framework_simplejwt",
    "rest_framework_simplejwt.token_blacklist",
    "dj_rest_auth",
    "django_filters",
    "corsheaders",
    "drf_spectacular",
    "django_celery_beat",
    "storages",
]

LOCAL_APPS = [
    "apps.common",
    "apps.accounts",
    "apps.catalog",
    "apps.scheduling",
    "apps.payments",
    "apps.audit",
    "apps.notifications",
    "apps.shop",
    "apps.staff",
    "apps.loyalty",
    "apps.tracking",
    "apps.analytics",
    "apps.geo",           # ServiceArea polygons + Haversine selectors (GEO_ENABLED)
    "apps.intelligence",  # Rule-based pricing / recommendations (Phase 4)
]

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

# -- Middleware ----------------------------------------------------------------
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",
    "corsheaders.middleware.CorsMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "apps.common.middleware.TenantMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "apps.common.middleware.RequestIDMiddleware",
]

ROOT_URLCONF = "config.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / "templates"],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "config.wsgi.application"
ASGI_APPLICATION = "config.asgi.application"

# -- Database -----------------------------------------------------------------
DATABASES = {
    "default": env.db("DATABASE_URL"),
}
DATABASES["default"]["CONN_MAX_AGE"] = env("CONN_MAX_AGE")

# -- Cache / Redis ------------------------------------------------------------
CACHES = {
    "default": {
        "BACKEND": "django.core.cache.backends.redis.RedisCache",
        "LOCATION": env("REDIS_URL"),
    }
}

# -- Auth ---------------------------------------------------------------------
AUTH_USER_MODEL = "accounts.CustomUser"

AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# -- Internationalization ------------------------------------------------------
LANGUAGE_CODE = "en-us"
TIME_ZONE = "UTC"
USE_I18N = True
USE_TZ = True

# -- Static & Media -----------------------------------------------------------
STATIC_URL = "/static/"
STATIC_ROOT = BASE_DIR / "staticfiles"
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

MEDIA_URL = "/media/"
MEDIA_ROOT = BASE_DIR / "media"

# -- S3 / R2 Object Storage ---------------------------------------------------
USE_S3 = env.bool("USE_S3", default=False)
if USE_S3:
    AWS_ACCESS_KEY_ID = env("AWS_ACCESS_KEY_ID")
    AWS_SECRET_ACCESS_KEY = env("AWS_SECRET_ACCESS_KEY")
    AWS_STORAGE_BUCKET_NAME = env("AWS_STORAGE_BUCKET_NAME")
    AWS_S3_ENDPOINT_URL = env("AWS_S3_ENDPOINT_URL", default=None)
    AWS_S3_REGION_NAME = env("AWS_S3_REGION_NAME", default="auto")
    AWS_DEFAULT_ACL = None
    AWS_S3_FILE_OVERWRITE = False
    AWS_QUERYSTRING_AUTH = True
    AWS_QUERYSTRING_EXPIRE = 3600
    DEFAULT_FILE_STORAGE = "storages.backends.s3boto3.S3Boto3Storage"

# -- DRF ----------------------------------------------------------------------
REST_FRAMEWORK = {
    "DEFAULT_AUTHENTICATION_CLASSES": [
        "rest_framework_simplejwt.authentication.JWTAuthentication",
    ],
    "DEFAULT_PERMISSION_CLASSES": [
        "rest_framework.permissions.IsAuthenticated",
    ],
    "DEFAULT_RENDERER_CLASSES": [
        "rest_framework.renderers.JSONRenderer",
    ],
    "DEFAULT_PARSER_CLASSES": [
        "rest_framework.parsers.JSONParser",
        "rest_framework.parsers.MultiPartParser",
    ],
    "DEFAULT_FILTER_BACKENDS": [
        "django_filters.rest_framework.DjangoFilterBackend",
        "rest_framework.filters.OrderingFilter",
        "rest_framework.filters.SearchFilter",
    ],
    "DEFAULT_PAGINATION_CLASS": "apps.common.pagination.CursorPagination",
    "PAGE_SIZE": 20,
    "EXCEPTION_HANDLER": "apps.common.errors.custom_exception_handler",
    "DEFAULT_SCHEMA_CLASS": "drf_spectacular.openapi.AutoSchema",
    "DEFAULT_THROTTLE_CLASSES": [
        "rest_framework.throttling.AnonRateThrottle",
        "rest_framework.throttling.UserRateThrottle",
    ],
    "DEFAULT_THROTTLE_RATES": {
        "anon": "60/min",
        "user": "300/min",
        "auth": "10/min",
        "otp_request": "5/hr",
        "otp_verify": "10/hr",
        # Tighter scope for token refresh — prevents hammering with a stolen
        # refresh token before the blacklist kicks in.
        "token_refresh": "20/hr",
    },
}

# -- dj-rest-auth -------------------------------------------------------------
# This project uses JWT (SimpleJWT) for all authentication — not DRF token auth.
# Setting TOKEN_MODEL = None prevents dj-rest-auth from requiring
# rest_framework.authtoken in INSTALLED_APPS.
REST_AUTH = {
    "USE_JWT": True,
    "JWT_AUTH_COOKIE": None,        # JWT lives in Authorization header, not cookie
    "JWT_AUTH_REFRESH_COOKIE": None,
    "TOKEN_MODEL": None,            # disables authtoken requirement
}

# -- JWT ----------------------------------------------------------------------
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=15),
    "REFRESH_TOKEN_LIFETIME": timedelta(days=7),
    "ROTATE_REFRESH_TOKENS": True,
    "BLACKLIST_AFTER_ROTATION": True,
    "UPDATE_LAST_LOGIN": True,
    "ALGORITHM": "HS256",
    "SIGNING_KEY": SECRET_KEY,
    "AUTH_HEADER_TYPES": ("Bearer",),
}

# -- drf-spectacular ----------------------------------------------------------
SPECTACULAR_SETTINGS = {
    "TITLE": "Sridhar Car Wash API",
    "DESCRIPTION": "Car-wash booking + materials shop backend.",
    "VERSION": "1.0.0",
    "SERVE_INCLUDE_SCHEMA": False,
    "COMPONENT_SPLIT_REQUEST": True,
    "SCHEMA_PATH_PREFIX": r"/api/v1/",
}

# -- Celery -------------------------------------------------------------------
CELERY_BROKER_URL = env("REDIS_URL")
CELERY_RESULT_BACKEND = env("REDIS_URL")
CELERY_ACCEPT_CONTENT = ["json"]
CELERY_TASK_SERIALIZER = "json"
CELERY_RESULT_SERIALIZER = "json"
CELERY_TIMEZONE = "UTC"
CELERY_BEAT_SCHEDULER = "django_celery_beat.schedulers:DatabaseScheduler"
CELERY_TASK_ALWAYS_EAGER = False

from celery.schedules import crontab  # noqa: E402

CELERY_BEAT_SCHEDULE = {
    "generate-booking-slots": {
        "task": "scheduling.generate_booking_slots",
        "schedule": crontab(hour=1, minute=0),
        "kwargs": {"days_ahead": 14},
    },
    "process-recurring-rules": {
        "task": "scheduling.process_recurring_rules",
        "schedule": crontab(hour=1, minute=30),
        "kwargs": {"lead_days": 7},
    },
    "send-booking-reminders": {
        "task": "notifications.send_booking_reminders",
        "schedule": crontab(minute="*/30"),
    },
    "send-abandoned-cart-reminders": {
        "task": "notifications.send_abandoned_cart_reminders",
        "schedule": crontab(minute=0, hour="*"),
    },
    "expire-idempotency-records": {
        "task": "audit.expire_idempotency_records",
        "schedule": crontab(hour=2, minute=0),
        "kwargs": {"days": 7},
    },
    # Birthday notifications -- daily at 09:00 UTC
    "send-birthday-notifications": {
        "task": "notifications.send_birthday_notifications",
        "schedule": crontab(hour=9, minute=0),
    },
    # Membership renewal reminders -- daily at 10:00 UTC
    "send-membership-renewal-reminders": {
        "task": "notifications.send_membership_renewal_reminders",
        "schedule": crontab(hour=10, minute=0),
    },
    # OTP cleanup -- weekly on Sunday at 03:00 UTC
    # Hard-deletes expired / used OTPCode rows to keep the table lean.
    "cleanup-expired-otps": {
        "task": "accounts.cleanup_expired_otps",
        "schedule": crontab(hour=3, minute=0, day_of_week=0),
    },
}

# -- CORS ---------------------------------------------------------------------
CORS_ALLOWED_ORIGINS = env.list("CORS_ALLOWED_ORIGINS", default=[])
CORS_ALLOW_CREDENTIALS = True

# -- Channels (Phase 3) -------------------------------------------------------
CHANNELS_ENABLED = env("CHANNELS_ENABLED")
if CHANNELS_ENABLED:
    CHANNEL_LAYERS = {
        "default": {
            "BACKEND": "channels_redis.core.RedisChannelLayer",
            "CONFIG": {"hosts": [env("REDIS_URL")]},
        }
    }

# -- Feature flags ------------------------------------------------------------
GEO_ENABLED = env("GEO_ENABLED")

# -- App-specific -------------------------------------------------------------
OTP_EXPIRY_MINUTES = env("OTP_EXPIRY_MINUTES")
OTP_MAX_ATTEMPTS = env("OTP_MAX_ATTEMPTS")
FRONTEND_URL = env("FRONTEND_URL", default="http://localhost:3000")
DEFAULT_FROM_EMAIL = env("DEFAULT_FROM_EMAIL", default="noreply@example.com")

# -- Maps / ETA (Phase 3 live tracking) --------------------------------------
MAPS_API_KEY = env("MAPS_API_KEY", default="")   # Google Maps Directions API key

# -- SMS (OTP delivery) -------------------------------------------------------
SMS_ENABLED = env("SMS_ENABLED")
SMS_PROVIDER = env("SMS_PROVIDER", default="twilio")   # "twilio" | "aws_sns"
SMS_ACCOUNT_SID = env("SMS_ACCOUNT_SID", default="")   # Twilio
SMS_AUTH_TOKEN = env("SMS_AUTH_TOKEN", default="")      # Twilio
SMS_FROM_NUMBER = env("SMS_FROM_NUMBER", default="")    # Twilio E.164 e.g. +15005550006

# -- Social auth --------------------------------------------------------------
SOCIAL_AUTH_ENABLED = env("SOCIAL_AUTH_ENABLED")

# -- FCM ----------------------------------------------------------------------
FCM_ENABLED = env.bool("FCM_ENABLED", default=False)
FCM_CREDENTIALS = env.json("FCM_CREDENTIALS_JSON", default={})

# -- Stripe -------------------------------------------------------------------
STRIPE_SECRET_KEY = env("STRIPE_SECRET_KEY", default="")
STRIPE_PUBLISHABLE_KEY = env("STRIPE_PUBLISHABLE_KEY", default="")
STRIPE_WEBHOOK_SECRET = env("STRIPE_WEBHOOK_SECRET", default="")

# -- Sentry -------------------------------------------------------------------
SENTRY_DSN = env("SENTRY_DSN", default="")
if SENTRY_DSN:
    import sentry_sdk
    from sentry_sdk.integrations.celery import CeleryIntegration
    from sentry_sdk.integrations.django import DjangoIntegration

    sentry_sdk.init(
        dsn=SENTRY_DSN,
        integrations=[DjangoIntegration(), CeleryIntegration()],
        traces_sample_rate=0.1,
        send_default_pii=False,
    )

# -- Default primary key type -------------------------------------------------
DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"
