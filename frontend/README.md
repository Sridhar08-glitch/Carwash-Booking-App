# Holora Performance — Flutter App

Car wash booking + materials shop. Single codebase, role-gated (customer / staff / admin).

## Flavors & Entrypoints

| Flavor | Entrypoint | Use |
|--------|-----------|-----|
| dev | `lib/main_dev.dart` | Local backend (`10.0.2.2:8000`) |
| staging | `lib/main_staging.dart` | Staging API |
| prod | `lib/main_prod.dart` | Production |

### Run dev
```bash
flutter run -t lib/main_dev.dart \
  --dart-define=BASE_URL=http://10.0.2.2:8000/api/v1 \
  --dart-define=WS_BASE_URL=ws://10.0.2.2:8000/ws \
  --dart-define=STRIPE_PK=pk_test_xxx \
  --dart-define=MAPS_KEY=AIza_xxx \
  --dart-define=SMS_ENABLED=false
```

### Build production
```bash
flutter build apk -t lib/main_prod.dart \
  --dart-define=BASE_URL=https://api.holoraperformance.com/api/v1 \
  --dart-define=STRIPE_PK=pk_live_xxx \
  --dart-define=MAPS_KEY=AIza_xxx \
  --dart-define=SENTRY_DSN=https://xxx@sentry.io/yyy
```

## Code Generation

After adding/modifying freezed models or Riverpod generators:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Project Structure

```
lib/
  main_dev.dart / main_staging.dart / main_prod.dart
  app/            # MaterialApp, GoRouter, shell scaffolds
  core/
    config/       # AppConfig (flavor env vars, feature flags)
    network/      # Dio + interceptors (auth, idempotency, retry, logging)
    auth/         # TokenStore, SessionController, SessionState
    storage/      # Hive boxes for offline cache
    error/        # Failure sealed class, ErrorMapper
    theme/        # AppColors, AppTypography, AppSpacing, AppTheme
    widgets/      # Shared: buttons, price_text, shimmer, empty/error/offline
    providers/    # connectivity, session, theme
  features/
    auth/         # Onboarding → Login → OTP
    home/         # Server-driven layout (hero carousel, quick actions, service rail)
    services/     # Service list (filtered by category) + detail
    booking/      # Slot picker → Location → Confirm → Success + History + Detail
    profile/      # Account, vehicles, loyalty (stub), theme toggle, logout
    staff/        # Phase 3 — job list, checklist, photos, status transitions
```

## Architecture Decisions

| Decision | Choice | Reason |
|---|---|---|
| Role split | Single app, role-gated routes | Simpler to ship; JWT role drives shell |
| Geofencing | Not implemented | Unreliable, battery-hostile, trust hazard |
| Money | Server is truth | Never compute totals client-side |
| Slots | Never cached | Always fetch fresh before display |
| Idempotency | UUID per logical action | POST /bookings, /orders/checkout, /payments/intent |

## Phase Build Plan

- **Phase 1 (this)** — Core + Auth + Home + Services + Booking (cash) + History
- **Phase 2** — Shop, cart, checkout, Stripe PaymentSheet, wallet, FCM push, offline cache
- **Phase 3** — Recurring rules, staff shell, live tracking (WebSocket), loyalty, memberships
- **Phase 4** — Multi-branch map, full i18n/RTL, QR deep links, analytics, white-label theming

## Key Rules (enforced by architecture)

- All money displayed from server string fields — never local arithmetic
- `Idempotency-Key` header on all booking/checkout/payment POST calls
- 401 → token refresh (single-flight) → retry once → logout
- Booking slot availability: never cached, always fresh
- Offline: booking creation, checkout, and payment are blocked (not faked)
