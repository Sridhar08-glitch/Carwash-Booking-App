"""Development settings — loads .env from repo root."""
from pathlib import Path

import environ

# ── Load .env BEFORE importing base.py ───────────────────────────────────────
# base.py calls env("SECRET_KEY") at import time, so the .env file must be
# read into os.environ first, otherwise Django raises ImproperlyConfigured.
BASE_DIR = Path(__file__).resolve().parent.parent.parent
environ.Env.read_env(BASE_DIR / ".env")

from .base import *  # noqa: F401, F403 — must come after read_env

DEBUG = True
SECRET_KEY = env("SECRET_KEY", default="dev-insecure-secret-key-change-in-prod")
ALLOWED_HOSTS = ["*"]

# ── Password hashing ──────────────────────────────────────────────────────────
# Use a fast-but-still-secure hasher in dev to speed up tests.
# REMOVED: MD5PasswordHasher was previously used here but is cryptographically
# broken — any dev DB accidentally copied to staging would expose trivially
# crackable hashes.  ScryptPasswordHasher is fast enough for dev while
# remaining safe if DB snapshots are shared.
PASSWORD_HASHERS = [
    "django.contrib.auth.hashers.ScryptPasswordHasher",
]

# Show emails in console during dev
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# ── No-Redis local development ────────────────────────────────────────────────
# Redis is NOT required on a dev laptop. The cache uses local process memory
# and Celery runs tasks synchronously (eager). Set USE_REDIS=True in .env if
# you install Redis and want production-fidelity caching / async tasks.
USE_REDIS = env.bool("USE_REDIS", default=False)

if not USE_REDIS:
    CACHES = {
        "default": {
            "BACKEND": "django.core.cache.backends.locmem.LocMemCache",
            "LOCATION": "sridhar-carwash-dev",
        }
    }
    # In-memory broker — only used if a task is ever sent asynchronously.
    CELERY_BROKER_URL = "memory://"
    CELERY_RESULT_BACKEND = "cache+memory://"

# ── Celery ────────────────────────────────────────────────────────────────────
# Default: EAGER (synchronous) so side-effects (slot generation, notifications)
# are visible immediately when testing locally without a worker.
# Set CELERY_TASK_ALWAYS_EAGER=False in .env to test the real async path.
CELERY_TASK_ALWAYS_EAGER = env.bool("CELERY_TASK_ALWAYS_EAGER", default=True)

# ── CORS (dev only) ──────────────────────────────────────────────────────────
# Flutter web (flutter run -d chrome) serves from a random localhost port, so
# allow all origins in dev rather than hardcoding one. Never enable this in
# staging/prod (base.py keeps CORS_ALLOWED_ORIGINS explicit there).
CORS_ALLOW_ALL_ORIGINS = True

# Django debug toolbar (optional — install separately if needed)
INTERNAL_IPS = ["127.0.0.1"]

# Logging
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "handlers": {"console": {"class": "logging.StreamHandler"}},
    "root": {"handlers": ["console"], "level": "DEBUG"},
    "loggers": {
        "django.db.backends": {"handlers": ["console"], "level": "WARNING"},
    },
}
