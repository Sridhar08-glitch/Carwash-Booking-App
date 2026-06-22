# Holora Performance Flutter App — Full Handoff Document
> Paste this entire file into a new Claude chat to continue development from exactly where we left off.

---

## 0. What This Project Is

A Flutter mobile app for **Holora Performance** — a two-line business:
1. **Car-wash service** — time-slot booking at a branch or mobile/at-home
2. **Materials e-shop** — detailing products

Single codebase, Android + iOS. Role-gated: `customer` shell and `staff` shell share the same auth/network core. Decision: **Option A** (single app, JWT role drives which shell mounts). No geofencing — time-based recurring rules only.

**Backend base URL:** `https://api.holoraperformance.com/api/v1`  
**WebSocket:** `wss://api.holoraperformance.com/ws`  
**Auth:** Bearer JWT. Access token 15 min, refresh token 7 days.  
**Currency:** SAR. All money fields are **strings** (`"80.00"`). NEVER compute totals client-side.

---

## 1. Tech Stack (pinned)

```
Flutter 3.x stable / Dart 3.x / null safety
State:        flutter_riverpod ^2.5.1 + riverpod_annotation ^2.3.5
Routing:      go_router ^13.2.0
Networking:   dio ^5.4.3
Models:       freezed_annotation ^2.4.1 + json_annotation ^4.9.0
Storage:      flutter_secure_storage ^9.2.2 + hive_flutter ^1.1.0
Maps:         google_maps_flutter ^2.6.0 + geolocator + geocoding
Payments:     flutter_stripe ^10.1.1
Push:         firebase_core ^2.31.0 + firebase_messaging ^14.9.4 + flutter_local_notifications
Real-time:    web_socket_channel ^2.4.5
Images:       cached_network_image ^3.3.1 + image_picker ^1.1.2
i18n:         flutter_localizations + intl ^0.19.0
UUID:         uuid ^4.4.0
Connectivity: connectivity_plus ^5.0.2
Monitoring:   sentry_flutter ^8.3.0
UI extras:    shimmer ^3.0.0 + google_fonts ^6.2.1
Dev:          build_runner, riverpod_generator, freezed, json_serializable, mocktail
```

---

## 2. Project Structure (complete — all phases built)

```
E:\carwash app\frontend\
├── pubspec.yaml
├── analysis_options.yaml
├── l10n.yaml
├── codemagic.yaml                      ✅ Phase 4
├── HANDOFF.md
├── assets/
│   ├── images/
│   ├── icons/
│   └── lottie/
└── lib/
    ├── main_dev.dart                   ✅ Sentry + FCM wired
    ├── main_staging.dart               ✅ Sentry + FCM wired
    ├── main_prod.dart                  ✅ Sentry + FCM wired
    ├── app/
    │   ├── app.dart
    │   ├── router.dart                 ✅ All routes (P1–P4) + QR deep-link
    │   └── shell_scaffold.dart
    ├── core/
    │   ├── config/app_config.dart
    │   ├── config/providers.dart
    │   ├── network/dio_client.dart
    │   ├── network/interceptors/
    │   │   ├── auth_interceptor.dart
    │   │   ├── idempotency_interceptor.dart
    │   │   ├── retry_interceptor.dart
    │   │   └── logging_interceptor.dart
    │   ├── auth/session_state.dart
    │   ├── auth/session_controller.dart
    │   ├── auth/token_store.dart
    │   ├── storage/hive_setup.dart
    │   ├── error/failures.dart
    │   ├── error/error_mapper.dart
    │   ├── theme/app_colors.dart
    │   ├── theme/app_spacing.dart
    │   ├── theme/app_typography.dart
    │   ├── theme/app_theme.dart
    │   ├── widgets/buttons.dart
    │   ├── widgets/price_text.dart
    │   ├── widgets/app_card.dart
    │   ├── widgets/app_text_field.dart
    │   ├── widgets/shimmer_box.dart
    │   ├── widgets/network_image_box.dart
    │   ├── widgets/offline_banner.dart
    │   ├── widgets/states.dart
    │   ├── providers/session_provider.dart
    │   ├── providers/connectivity_provider.dart
    │   ├── providers/theme_provider.dart
    │   └── i18n/app_en.arb + app_ar.arb
    └── features/
        ├── auth/                       ✅ Phase 1
        ├── home/                       ✅ Phase 1
        ├── services/                   ✅ Phase 1
        ├── booking/                    ✅ Phase 1
        ├── profile/
        │   └── screens/
        │       ├── profile_screen.dart ✅ Phase 1
        │       ├── referrals_screen.dart ✅ Phase 3
        ├── shop/                       ✅ Phase 2
        ├── cart/                       ✅ Phase 2
        ├── payments/                   ✅ Phase 2
        ├── orders/                     ✅ Phase 2
        ├── notifications/              ✅ Phase 2
        ├── recurring/                  ✅ Phase 3
        ├── staff/                      ✅ Phase 3 (full)
        ├── tracking/                   ✅ Phase 3
        ├── loyalty/                    ✅ Phase 3
        └── memberships/               ✅ Phase 3
```

---

## 3. Architectural Rules (NEVER violate)

| Rule | Implementation |
|---|---|
| Money = server strings only | `PriceText(amount: dto.price, currency: dto.currency)` — never `double.parse` + arithmetic |
| Slots never cached | `bookingRepository.getSlots()` always hits network; no Hive for slots |
| Idempotency keys | Auto-injected on `/bookings`, `/orders/checkout`, `/payments/intent` by `IdempotencyInterceptor`. Per-action UUID stored in `BookingFlowController.state.idempotencyKey` |
| 401 handling | `AuthInterceptor` single-flight refresh → retry → logout. Never 401 on `/auth/refresh` itself |
| Offline blocking | Booking create, checkout, payment → blocked with `OfflineBanner` when `isOnlineProvider` is false. Cart persists via Hive. |
| Error handling | All repository catch blocks call `ErrorMapper.map(e)` → typed `Failure`. UI uses `AsyncValueWidget<T>` |
| Role gating | Router `_redirect()` checks `user.role`. Staff → `staffJobs`. Customer → `home`. Mismatch → correct shell |

---

## 4. API Contract Quick Reference

### Auth
```
POST /auth/otp/request   { phone }
POST /auth/otp/verify    { phone, code } → { tokens:{access,refresh}, user, is_new }
POST /auth/refresh       { refresh } → { access, refresh }
POST /auth/logout        { refresh }
```

### Profile
```
GET/PATCH /profile/me
GET/POST/PATCH/DELETE /profile/vehicles
GET/POST/PATCH/DELETE /profile/addresses
```

### Services & Branches
```
GET /services?category=<id>
GET /services/{id}
GET /services/categories
GET /branches
GET /branches/{id}
```

### Booking
```
GET  /slots?date=&service=&branch=     ← NEVER cache
POST /bookings  [Idempotency-Key]
GET  /bookings
GET  /bookings/{id}
POST /bookings/{id}/cancel
POST /bookings/{id}/reschedule { slot_id }
GET/POST/PATCH/DELETE /recurring/
```

### Shop
```
GET /products?search=&brand=&car_type=&min=&max=
GET /products/{id}
GET /cart
POST /cart/items         { product_id, quantity }
PATCH /cart/items/{id}   { quantity }
DELETE /cart/items/{id}
POST /cart/apply-promo   { code }
```

### Checkout & Payments
```
POST /orders/checkout    [Idempotency-Key]  { delivery_method, shipping_address_id }
POST /payments/intent    { payment_id } → { client_secret }
POST /payments/confirm   { payment_id }
GET  /payments/wallet    → { balance, currency, recent_transactions }
GET  /orders
GET  /orders/{id}
```

### Notifications
```
GET  /notifications?unread=1
POST /notifications/{id}/read
POST /notifications/read-all
GET  /notifications/settings
PATCH /notifications/settings
POST /notifications/fcm-token   { fcm_token }
```

### Loyalty & Memberships
```
GET  /loyalty/status
GET  /loyalty/tiers
GET  /loyalty/referrals
POST /loyalty/referrals   { referee_phone }
GET  /memberships/plans
POST /memberships/subscribe { plan_id }
POST /memberships/cancel
GET  /memberships/my
```

### Staff (role=staff|admin)
```
GET  /staff/jobs
GET  /staff/jobs/{booking_id}
POST /staff/jobs/{booking_id}/accept
POST /staff/jobs/{booking_id}/status    { status }
GET  /staff/jobs/{booking_id}/tasks
POST /staff/jobs/{booking_id}/tasks/{task_id}/toggle
POST /staff/jobs/{booking_id}/photos/presign  { kind:"before"|"after" }
POST /staff/jobs/{booking_id}/photos/record   { kind, s3_key }
```

### WebSocket Tracking
```
wss://.../ws/track/{booking_id}/?token=<jwt>
Customer receives: { type:"ping", lat, lng, eta_minutes } | { type:"status", booking_status }
Staff sends:       { type:"ping", lat, lng, accuracy_m }
Close codes: 4001=unauthenticated, 4003=forbidden
```

---

## 5. Build & Run Commands

```bash
# Install deps + generate freezed/.g.dart files (REQUIRED after ANY model change)
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# Firebase (run once per project)
dart pub global activate flutterfire_cli
flutterfire configure   # → lib/firebase_options.dart

# Run dev
flutter run -t lib/main_dev.dart \
  --dart-define=BASE_URL=http://10.0.2.2:8000/api/v1 \
  --dart-define=WS_BASE_URL=ws://10.0.2.2:8000/ws \
  --dart-define=STRIPE_PK=pk_test_xxx \
  --dart-define=MAPS_KEY=AIza_xxx \
  --dart-define=SMS_ENABLED=false

# Run tests
flutter test

# Build production APK
flutter build apk -t lib/main_prod.dart \
  --dart-define=BASE_URL=https://api.holoraperformance.com/api/v1 \
  --dart-define=STRIPE_PK=pk_live_xxx \
  --dart-define=MAPS_KEY=AIza_xxx \
  --dart-define=SENTRY_DSN=https://xxx@sentry.io/yyy
```

---

## 6. Phase Completion Status — ALL PHASES COMPLETE ✅

### ✅ Phase 1 — Core + Auth + Booking
Auth (OTP), home layout engine, services list/detail, booking flow (slot picker → location → confirm → success → history → detail), profile, vehicle management, address management, i18n scaffold (EN + AR ARB).

### ✅ Phase 2 — Transactions
| Feature | Key files |
|---|---|
| Shop catalog (search, infinite scroll, grid) | `features/shop/` |
| Cart (server-synced, keepAlive, promo code) | `features/cart/` |
| Checkout (Stripe PaymentSheet, offline guard) | `features/payments/presentation/screens/checkout_screen.dart` |
| Wallet (balance card + transaction list) | `features/payments/presentation/screens/wallet_screen.dart` |
| Orders list + detail | `features/orders/` |
| Notifications inbox + settings | `features/notifications/` |

### ✅ Phase 3 — Automation & Staff
| Feature | Key files |
|---|---|
| Recurring bookings (list + form, freq/day/time) | `features/recurring/` |
| Full staff shell (job list, detail, checklist, photo upload via S3 presign) | `features/staff/` |
| WebSocket live tracking (StateNotifier, camera animate) | `features/tracking/` |
| Loyalty (tier card, progress bar, stats) | `features/loyalty/` |
| Memberships (plan cards, subscribe, cancel, usage bar) | `features/memberships/` |
| Referrals (code copy, invite by phone) | `features/profile/presentation/screens/referrals_screen.dart` |

### ✅ Phase 4 — Scale & Polish
| Feature | Status |
|---|---|
| `codemagic.yaml` — 3 workflows (dev/staging/prod → Play Store + App Store) | ✅ |
| Sentry init in all 3 mains (env-scoped DSN, sample rates) | ✅ |
| QR deep-link `/qr/:bookingId` → redirects to booking detail | ✅ |
| Asset placeholder directories | ✅ |
| `sentry_flutter ^8.3.0` added to pubspec | ✅ |

---

## 7. Route Map (complete)

```
/                          → SplashScreen
/onboarding                → OnboardingScreen
/login                     → LoginScreen
/otp?phone=&isNew=         → OtpScreen

/home                      → HomeScreen
/services                  → ServicesListScreen
/services/:serviceId       → ServiceDetailScreen
/bookings                  → BookingHistoryScreen
/bookings/:bookingId       → BookingDetailScreen
/profile                   → ProfileScreen
/profile/notifications     → NotificationSettingsScreen
/profile/loyalty           → LoyaltyScreen
/profile/memberships       → MembershipsScreen
/profile/referrals         → ReferralsScreen
/shop                      → ShopScreen
/shop/:productId           → ProductDetailScreen
/orders                    → OrdersScreen
/orders/:orderId           → OrderDetailScreen
/notifications             → NotificationsInboxScreen
/recurring                 → RecurringListScreen

/cart                      → CartScreen
/checkout                  → CheckoutScreen
/wallet                    → WalletScreen
/recurring/new             → RecurringFormScreen
/tracking/:bookingId       → TrackingScreen
/qr/:bookingId             → redirect → /bookings/:bookingId

/booking/slots?serviceId=  → SlotPickerScreen
/booking/location?...      → BookingLocationScreen
/booking/confirm           → BookingConfirmScreen
/booking/success?bookingId=→ BookingSuccessScreen

/staff/jobs                → StaffJobsScreen
/staff/jobs/:bookingId     → StaffJobDetailScreen
```

---

## 8. What Needs to Happen Before First Run

1. **`flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs`**  
   Generates all `.freezed.dart` and `.g.dart` files (none are committed).

2. **`flutterfire configure`**  
   Generates `lib/firebase_options.dart` (not committed — requires Firebase project).

3. **Codemagic env vars to set** (in project settings):
   - `DEV_STRIPE_PK`, `STAGING_STRIPE_PK`, `PROD_STRIPE_PK`
   - `MAPS_KEY` (Google Maps API key with Maps SDK for Android/iOS enabled)
   - `SENTRY_DSN`
   - `GPLAY_SERVICE_ACCOUNT_CREDENTIALS` (JSON)
   - Android keystore: `holora_keystore`

4. **Google Maps**: Add `MAPS_KEY` to `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`.

5. **Stripe**: Call `Stripe.publishableKey = const String.fromEnvironment('STRIPE_PK')` in `app.dart` before `runApp`.

---

## 9. Known Gaps / Next Steps

| Item | Notes |
|---|---|
| `firebase_options.dart` | Run `flutterfire configure` once per environment |
| Addresses + Vehicles screens | Phase 1 gap — profile tiles wired, screens are stubs |
| Admin shell | `/admin-api/*` endpoints defined in contract but no UI built |
| Unit tests | `test/` skeleton only; add widget + integration tests |
| ARB strings | `app_en.arb` / `app_ar.arb` have scaffold keys — fill in complete translations |
| Staff GPS ping | `TrackingController` handles customer-side; add staff-side WS ping sender in `staff_job_detail_screen.dart` using `Geolocator.getPositionStream()` |
| Social login | `SOCIAL_AUTH_ENABLED` feature flag exists; `/auth/social/` UI not built |

---

## 10. Common Patterns

### New repository
```dart
@riverpod
MyRepository myRepository(MyRepositoryRef ref) =>
    MyRepository(ref.watch(dioProvider));

class MyRepository {
  MyRepository(this._dio);
  final Dio _dio;

  Future<MyDto> getData() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/endpoint');
      return MyDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
```

### New screen with AsyncValue
```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: AsyncValueWidget(
        value: async,
        data: (data) => _Content(data: data),
      ),
    );
  }
}
```

### New freezed DTO
```dart
@freezed
class MyDto with _$MyDto {
  const factory MyDto({
    required int id,
    @JsonKey(name: 'snake_case') required String camelCase,
    @Default('SAR') String currency,
    @Default('0.00') String price,
  }) = _MyDto;
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
}
```

### Price display (ALWAYS server string)
```dart
PriceText(
  amount: dto.price,          // "89.00" from API
  currency: dto.currency,     // "SAR" from API
  originalAmount: dto.compareAtPrice,  // optional strike-through
)
```

### Idempotency on POST
```dart
final key = _uuid.v4();
await _dio.post('/bookings',
  data: dto.toJson(),
  options: Options(extra: {'idempotencyKey': key, 'idempotent': true}),
);
```
