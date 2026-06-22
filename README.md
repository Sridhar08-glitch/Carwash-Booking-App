<div align="center">

<img src="https://avatars.githubusercontent.com/u/192087837?v=4" width="100" style="border-radius: 50%;" alt="Sridhar Mahalingam" />

# 🚗 Sridhar Car Wash

### Premium Car Care Booking Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Django](https://img.shields.io/badge/Django-5.0-092E20?style=for-the-badge&logo=django&logoColor=white)](https://www.djangoproject.com)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Stripe](https://img.shields.io/badge/Stripe-Payments-635BFF?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

*A full-stack car wash booking app — Flutter mobile client + Django REST backend*

</div>

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Backend Setup](#backend-setup)
  - [Frontend Setup](#frontend-setup)
- [API Overview](#api-overview)
- [Environment Variables](#environment-variables)
- [Author](#author)

---

## Overview

Sridhar Car Wash is a full-stack mobile application that lets customers book professional car wash services at a fixed location or as a mobile service at their address. The platform handles OTP-based authentication, real-time staff tracking, Stripe payments, loyalty points, membership subscriptions, and multi-tenant business isolation — all in a production-ready setup.

---

## Features

### Customer App (Flutter)
- 📱 **OTP Passwordless Auth** — phone-based sign-in with JWT session management
- 🗓️ **Slot Booking** — browse services, pick a time slot, choose in-bay or mobile wash
- 💳 **Stripe Payments** — card, wallet, and cash payment methods with PaymentIntent
- 📍 **Live Staff Tracking** — real-time WebSocket GPS tracking during active bookings
- 🏆 **Loyalty Program** — earn points per wash, tiered rewards, referral codes
- 🎫 **Promo Codes** — discount codes applied at checkout
- 🚗 **Vehicle Management** — save multiple vehicles to your profile
- 📬 **Address Book** — saved delivery addresses for mobile washes
- 💎 **Membership Plans** — subscribe to monthly/annual wash bundles via Stripe Billing
- 🔔 **Push Notifications** — Firebase Cloud Messaging for booking updates
- 🛒 **Shop** — browse and purchase car care products

### Platform / Backend
- 🏢 **Multi-tenant** — Row Level Security via `TenantScopedModel`; one deployment serves multiple branches
- ⚡ **Async Tasks** — Celery + Celery Beat for reminders, retries, and scheduled jobs
- 🔌 **WebSockets** — Django Channels (ASGI) for real-time tracking consumers
- 🧾 **Stripe Webhooks** — payment lifecycle events handled server-side
- 🔑 **Idempotency Keys** — safe mutation retries on all booking and payment endpoints
- 📖 **OpenAPI Docs** — DRF Spectacular auto-generates Swagger/ReDoc docs
- 🧹 **Soft Deletes** — `SoftDeleteManager` / `AllObjectsManager` pattern throughout
- 🔍 **Audit Trail** — per-model change logging via the `audit` app

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter App (Dart)                    │
│  Riverpod · go_router · Dio · Freezed · Hive · Sentry   │
└──────────────┬──────────────────────────┬───────────────┘
               │  REST (HTTPS)            │  WebSocket (wss)
               ▼                          ▼
┌─────────────────────────────────────────────────────────┐
│                Django REST Framework                      │
│  DRF Spectacular · SimpleJWT · dj-rest-auth              │
│                                                          │
│  ┌────────┐ ┌──────────┐ ┌─────────┐ ┌──────────────┐  │
│  │accounts│ │scheduling│ │payments │ │   loyalty    │  │
│  │  geo   │ │ tracking │ │ (Stripe)│ │ memberships  │  │
│  │catalog │ │   shop   │ │  audit  │ │notifications │  │
│  └────────┘ └──────────┘ └─────────┘ └──────────────┘  │
│                                                          │
│  Django Channels (ASGI) ──── Redis ──── Celery + Beat   │
└──────────────────────────────┬──────────────────────────┘
                               │
                     ┌─────────▼────────┐
                     │   PostgreSQL DB   │
                     └──────────────────┘
```

---

## Tech Stack

### Frontend
| Layer | Technology |
|---|---|
| Framework | Flutter 3.10+ / Dart 3.0+ |
| State Management | Riverpod 2 + riverpod_generator |
| Models | Freezed + json_serializable |
| HTTP Client | Dio 5 |
| Navigation | go_router |
| Local Storage | Hive + flutter_secure_storage |
| Payments | flutter_stripe |
| Maps & Location | google_maps_flutter · geolocator · geocoding |
| Push Notifications | Firebase Cloud Messaging |
| Real-time | web_socket_channel |
| Error Monitoring | Sentry |

### Backend
| Layer | Technology |
|---|---|
| Framework | Django 5.0 + Django REST Framework |
| Auth | SimpleJWT (access + refresh tokens) · OTP passwordless |
| Database | PostgreSQL (psycopg2) |
| Cache / Broker | Redis |
| Async Tasks | Celery 5 + Celery Beat |
| WebSockets | Django Channels 4 + channels-redis |
| Payments | Stripe SDK (PaymentIntent + Billing) |
| API Docs | DRF Spectacular (OpenAPI 3) |
| Storage | django-storages + boto3 (S3) |
| Error Monitoring | Sentry SDK |

---

## Project Structure

```
carwash-app/
├── frontend/                    # Flutter application
│   ├── lib/
│   │   ├── core/                # Theme, router, DI, constants
│   │   ├── features/
│   │   │   ├── auth/            # OTP login, JWT refresh
│   │   │   ├── booking/         # Slot selection, checkout, booking flow
│   │   │   ├── tracking/        # Live WebSocket map view
│   │   │   ├── loyalty/         # Points, tiers, referrals
│   │   │   ├── memberships/     # Plans, subscriptions
│   │   │   ├── vehicles/        # Vehicle CRUD
│   │   │   ├── addresses/       # Address book
│   │   │   ├── shop/            # Product catalogue + cart
│   │   │   └── notifications/   # FCM handler, inbox
│   │   └── shared/              # Widgets, utils, extensions
│   └── pubspec.yaml
│
└── backend/                     # Django application
    ├── apps/
    │   ├── accounts/            # User model, OTP, JWT
    │   ├── catalog/             # Services, pricing
    │   ├── scheduling/          # Slots, bookings
    │   ├── payments/            # Stripe PaymentIntent & webhooks
    │   ├── tracking/            # WebSocket consumers, JWT middleware
    │   ├── loyalty/             # Points, tiers, referrals, memberships
    │   ├── geo/                 # Locations, addresses
    │   ├── shop/                # Products, orders
    │   ├── notifications/       # FCM push, in-app inbox
    │   ├── staff/               # Staff management, attendance
    │   ├── analytics/           # Revenue & usage reports
    │   └── audit/               # Change-log trail
    ├── config/
    │   ├── settings/            # base / dev / prod
    │   ├── asgi.py              # Channels ASGI app
    │   └── wsgi.py
    └── requirements.txt
```

---

## Getting Started

### Prerequisites

- Python 3.12+
- Flutter 3.10+ / Dart 3.0+
- PostgreSQL 15+
- Redis 7+

---

### Backend Setup

```bash
# 1. Clone the repo
git clone https://github.com/Sridhar08-glitch/carwash-app.git
cd carwash-app/backend

# 2. Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Set up environment variables
cp .env.example .env
# Edit .env — see Environment Variables section below

# 5. Run migrations
python manage.py migrate

# 6. Create superuser
python manage.py createsuperuser

# 7. Start the development server
python manage.py runserver

# 8. Start Celery worker (separate terminal)
celery -A config worker -l info

# 9. Start Celery Beat scheduler (separate terminal)
celery -A config beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler
```

> **WebSocket support:** Set `CHANNELS_ENABLED=True` in `.env` and run via Daphne or Uvicorn instead of `runserver`.

---

### Frontend Setup

```bash
cd carwash-app/frontend

# 1. Install dependencies
flutter pub get

# 2. Run code generation (Freezed + Riverpod + Hive)
dart run build_runner build --delete-conflicting-outputs

# 3. Configure API base URL
# Edit lib/core/constants/api_constants.dart
# Set baseUrl to your backend address

# 4. Add Firebase config
# Place google-services.json in android/app/
# Place GoogleService-Info.plist in ios/Runner/

# 5. Run the app
flutter run
```

---

## API Overview

Base URL: `https://your-domain.com/api/v1/`

Interactive docs available at `/api/schema/swagger-ui/` and `/api/schema/redoc/` when `DEBUG=True`.

| Group | Endpoints |
|---|---|
| Auth | `POST /auth/otp/request` · `POST /auth/otp/verify` · `POST /auth/token/refresh` |
| Profile | `GET/PATCH /accounts/me` · `GET/POST /accounts/vehicles` · `GET/POST /accounts/addresses` |
| Catalog | `GET /catalog/services` · `GET /catalog/slots` |
| Bookings | `POST /bookings` · `GET /bookings/{id}` · `POST /bookings/{id}/cancel` |
| Payments | `POST /payments/intent` · `POST /payments/webhook` |
| Tracking | `WSS /ws/tracking/{booking_id}/?token=<jwt>` |
| Loyalty | `GET /loyalty/status` · `GET /loyalty/tiers` · `GET/POST /loyalty/referrals` |
| Memberships | `GET /memberships/plans` · `POST /memberships/subscribe` · `POST /memberships/cancel` |
| Shop | `GET /shop/products` · `POST /shop/orders` |
| Notifications | `GET /notifications` · `POST /notifications/{id}/read` |

---

## Environment Variables

Create `backend/.env` from the template below:

```env
# Django
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database
DATABASE_URL=postgres://user:password@localhost:5432/carwash_db

# Redis
REDIS_URL=redis://localhost:6379/0

# JWT
ACCESS_TOKEN_LIFETIME_MINUTES=60
REFRESH_TOKEN_LIFETIME_DAYS=30

# Stripe
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Firebase (push notifications)
FIREBASE_CREDENTIALS_JSON=path/to/firebase-credentials.json

# AWS S3 (media storage — optional in dev)
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_STORAGE_BUCKET_NAME=

# Channels
CHANNELS_ENABLED=False

# Sentry (optional)
SENTRY_DSN=
```

---

## Author

<div align="center">

<img src="https://avatars.githubusercontent.com/u/192087837?v=4" width="120" style="border-radius: 50%;" alt="Sridhar Mahalingam" />

### Sridhar Mahalingam

*Full Stack Developer · Doha, Qatar*

[![GitHub](https://img.shields.io/badge/GitHub-Sridhar08--glitch-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Sridhar08-glitch)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-sridhar--mahalingam-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sridhar-mahalingam-6b8357245/)
[![Portfolio](https://img.shields.io/badge/Portfolio-sridharportfolio1.netlify.app-00C7B7?style=for-the-badge&logo=netlify&logoColor=white)](https://sridharportfolio1.netlify.app/)
[![Email](https://img.shields.io/badge/Email-sridharansridhar22@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:sridharansridhar22@gmail.com)

<br/>

[![GitHub Stats](https://github-readme-stats.vercel.app/api?username=Sridhar08-glitch&show_icons=true&theme=dark&hide_border=true&count_private=true)](https://github.com/Sridhar08-glitch)

[![GitHub Streak](https://streak-stats.demolab.com?user=Sridhar08-glitch&theme=dark&hide_border=true)](https://github.com/Sridhar08-glitch)

</div>

---

<div align="center">

Made with ❤️ by [Sridhar Mahalingam](https://github.com/Sridhar08-glitch) 

</div>
