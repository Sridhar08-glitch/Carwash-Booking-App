# Holora Performance — Backend

Django 5.0 REST API for the Holora car-wash booking + materials shop.

**Stack:** Python 3.12 · Django 5 · DRF 3.15 · PostgreSQL 16 · Redis 7 · Celery 5 · gunicorn · WhiteNoise  
**Multi-tenancy:** Postgres Row-Level Security (tenant_id FK + `set_config` per request)  
**No Docker** — deploy on Railway or Render with native buildpacks.

---

## Local development (no containers)

### 1 — Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Python | 3.12 | `pyenv install 3.12.3` |
| PostgreSQL | ≥ 14 | native OS package **or** point at Neon free tier |
| Redis | ≥ 7 | native OS package **or** point at Upstash free tier |

### 2 — Clone + virtual environment

```bash
git clone <repo>
cd backend

python -m venv .venv
source .venv/bin/activate          # Windows: .venv\Scripts\activate

pip install -r requirements-dev.txt
```

### 3 — Environment variables

```bash
cp .env.example .env
# Edit .env with your local Postgres / Redis URLs and a dev SECRET_KEY
```

Minimum `.env` for local dev:

```
DJANGO_SETTINGS_MODULE=config.settings.dev
SECRET_KEY=any-local-secret
DATABASE_URL=postgres://postgres:password@localhost:5432/holora_dev
REDIS_URL=redis://localhost:6379/0
```

### 4 — Database

```bash
# Create the local database (if using local Postgres)
createdb holora_dev

# Run migrations (includes RLS policy setup)
python manage.py migrate

# Seed demo data
python manage.py seed
```

> **Note on RLS migration:** `0002_rls_policies` requires the DB user to own the
> tables (default for `createdb` with your own user). On Neon/Railway managed
> Postgres, the platform user owns all tables it creates, so this works out of
> the box. If you get "must be owner" errors, run the RLS SQL manually as the
> superuser via the platform's SQL console, then fake the migration:
> `python manage.py migrate common 0002 --fake`

### 5 — Run the application

Open **three** terminal tabs:

```bash
# Tab 1 — Django dev server
python manage.py runserver

# Tab 2 — Celery worker
celery -A config.celery worker --loglevel=info

# Tab 3 — Celery Beat (scheduled tasks)
celery -A config.celery beat --loglevel=info \
  --scheduler django_celery_beat.schedulers:DatabaseScheduler
```

### 6 — API docs

- OpenAPI schema: http://localhost:8000/api/schema
- Swagger UI:     http://localhost:8000/api/schema/swagger-ui/
- Django admin:   http://localhost:8000/django-admin/  (seed creates admin user `+966500000000` / `admin1234`)

---

## Running tests

```bash
# All tests
pytest

# With coverage
pytest --cov=apps --cov-report=term-missing

# A single module
pytest apps/scheduling/tests.py -v

# Concurrency / oversell test (TransactionTestCase — requires a real DB)
pytest apps/scheduling/tests.py::SlotOversellTest -v
```

### Lint

```bash
ruff check .
black --check .

# Auto-fix
ruff check . --fix && black .
```

### Check no migration drift

```bash
python manage.py makemigrations --check
```

---

## Project structure

```
config/
  settings/
    base.py     ← all shared config (12-factor env vars)
    dev.py      ← loads .env file; DEBUG=True; faster password hashing
    prod.py     ← HTTPS hardening; S3 storage; JSON logging
  urls.py
  wsgi.py       ← gunicorn entrypoint (Phase 1-2)
  asgi.py       ← uvicorn/daphne entrypoint (Phase 3, CHANNELS_ENABLED=True)
  celery.py

apps/
  common/       ← BaseModel, Tenant, TenantMiddleware, RLS helpers, errors, pagination
  accounts/     ← CustomUser, OTP auth, JWT, vehicles, addresses
  catalog/      ← ServiceCategory, Service, Branch, BranchHours
  scheduling/   ← SlotTemplate, BookingSlot, Booking
  payments/     ← Payment, Wallet, WalletTransaction, PromoCode
  audit/        ← AuditLog (signals), IdempotencyRecord
  notifications/← Notification (Phase 2 FCM dispatch)
  shop/         ← Product catalog + cart + orders (Phase 2)
  staff/        ← Job flow + checklist + photos (Phase 3)
  loyalty/      ← Tiers, referrals, memberships (Phase 3)
  tracking/     ← WebSocket GPS tracking (Phase 3)
  analytics/    ← Dashboard aggregations (Phase 4)
```

---

## API overview (`/api/v1/`)

| Method | Path | Description |
|--------|------|-------------|
| POST | `auth/otp/request` | Send OTP to phone |
| POST | `auth/otp/verify` | Verify OTP → JWT tokens |
| POST | `auth/refresh` | Rotate refresh token |
| POST | `auth/logout` | Blacklist refresh token |
| GET/PATCH | `profile/me` | Get / update profile |
| CRUD | `profile/vehicles` | Customer vehicles |
| CRUD | `profile/addresses` | Customer addresses |
| GET | `services` | List active services |
| GET | `services/{id}` | Service detail |
| GET | `branches` | List branches |
| GET | `slots` | Available slots (filter: date, service, branch) |
| GET/POST | `bookings` | List / create bookings |
| GET | `bookings/{id}` | Booking detail |
| POST | `bookings/{id}/cancel` | Cancel booking |
| GET | `payments/wallet` | Wallet balance |
| GET | `home/layout` | Home screen sections |
| GET | `healthz` | Liveness probe |
| GET | `readyz` | Readiness probe (DB + Redis) |

---

## Deployment — Railway or Render

### 1 — Connect repository

Railway: **New Project → Deploy from GitHub repo**  
Render: **New Web Service → Connect GitHub**

### 2 — Set environment variables

In the platform dashboard, set every key from `.env.example` with real production values.
**Never commit secrets.**

### 3 — Provision managed services

| Service | Railway | Render |
|---------|---------|--------|
| PostgreSQL 16 | Add PostgreSQL plugin | Add PostgreSQL database |
| Redis 7 | Add Redis plugin | Add Redis instance (or Upstash) |

Copy the `DATABASE_URL` and `REDIS_URL` from the service dashboards into your app env vars.

### 4 — Procfile processes

The `Procfile` defines four processes Railway/Render will run:

| Process | Command | Scale |
|---------|---------|-------|
| `web` | `gunicorn config.wsgi --workers 3 --timeout 60` | Horizontal (stateless) |
| `worker` | `celery -A config.celery worker` | 1–N |
| `beat` | `celery -A config.celery beat` | **Exactly 1** |
| `release` | `migrate && collectstatic` | Runs on every deploy |

> **Phase 3 ASGI upgrade:** swap the `web` process to:
> `uvicorn config.asgi:application --workers 3 --host 0.0.0.0 --port $PORT`
> and set `CHANNELS_ENABLED=True`.

### 5 — Static files

WhiteNoise serves static files directly from gunicorn — no Nginx or CDN required for Phase 1.
`collectstatic` runs in the `release` process on every deploy.

For production traffic, put Cloudflare or another CDN in front and set a long
`Cache-Control` header for `/static/`.

### 6 — Custom domain + TLS

Both Railway and Render provide free managed TLS certificates for custom domains.
Set `ALLOWED_HOSTS` to include your domain.

---

## Multi-tenancy & RLS

Every business model has a `tenant` FK.

**Application layer:** `TenantMiddleware` calls  
```sql
SELECT set_config('app.current_tenant', '<uuid>', FALSE)
```
on the DB connection after every authenticated request.

**Database layer:** Postgres RLS policies (in `0002_rls_policies`) enforce:
```sql
tenant_id::text = current_setting('app.current_tenant', TRUE)
```
so even if application code omits a `.filter(tenant=...)`, no cross-tenant data leaks.

`CONN_MAX_AGE = 0` ensures each request gets a fresh connection; the session-level
`set_config` cannot bleed between requests.

---

## Phase roadmap

| Phase | What ships |
|-------|-----------|
| **1 (now)** | Auth, catalog, slot booking (cash), home layout, seed, deploy |
| **2** | Shop, Stripe payments + webhooks, wallet, promos, FCM, idempotency |
| **3** | Staff job flow + checklist + photos, loyalty, memberships, real-time tracking (ASGI) |
| **4** | Multi-branch, PostGIS service areas, analytics dashboard, rule-based pricing/recs |

---

## Seed credentials (dev only)

| Role | Phone | Password |
|------|-------|----------|
| Admin | `+966500000000` | `admin1234` |
| Customer | `+966511111111` | `customer1234` |
| Staff | `+966522222222` | `staff1234` |

OTPs are logged to the console (search for "OTP stub") — no SMS provider needed in dev.
