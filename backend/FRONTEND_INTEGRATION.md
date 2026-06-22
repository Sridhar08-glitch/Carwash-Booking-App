# Frontend Integration Guide — Holora Performance Backend

> **Base URL**: `https://api.yourdomain.com/api/v1`  
> **OpenAPI / Swagger UI**: `https://api.yourdomain.com/api/schema/swagger-ui/`  
> **Auth scheme**: Bearer JWT in `Authorization` header  
> **Default currency**: SAR (all money fields are strings, never floats)

---

## 1. Authentication

### OTP Flow (Passwordless — handles both Register & Login)

```
POST /auth/otp/request
Body: { "phone": "+966512345678" }
Response: 200 { "detail": "OTP sent" }

POST /auth/otp/verify
Body: { "phone": "+966512345678", "code": "123456" }
Response: 200 {
  "tokens": { "access": "eyJ...", "refresh": "eyJ..." },
  "user": { "id": 1, "phone": "+966512345678", "role": "customer", "is_phone_verified": true },
  "is_new": true   // true = first-time registration
}
```

**Token lifecycle**:
- `access` — 15-minute lifetime. Send as `Authorization: Bearer <access>`.
- `refresh` — 7-day lifetime. Send to `/auth/refresh` to get a new access token.
- On logout: blacklisted server-side; both tokens invalidated.

```
POST /auth/refresh
Body: { "refresh": "eyJ..." }
Response: 200 { "access": "eyJ...", "refresh": "eyJ..." }

POST /auth/logout
Body: { "refresh": "eyJ..." }
Response: 200 { "detail": "ok" }
```

**OTP rules**: 6-digit code, expires in 5 minutes, max 5 attempts. If all attempts fail, request a new code.

### Social Login (optional — when `SOCIAL_AUTH_ENABLED=True` on server)
```
POST /auth/social/  — dj-rest-auth social login (Google/Apple)
```

---

## 2. Error Envelope

Every error response has this shape — handle by `code`:

```json
{
  "code": "CONFLICT",
  "message": "This time slot is fully booked.",
  "detail": "",
  "field_errors": { "phone": ["Enter a valid phone number."] }
}
```

| HTTP | code | Meaning |
|------|------|---------|
| 400 | `VALIDATION_ERROR` | Field-level validation failed — see `field_errors` |
| 401 | `AUTHENTICATION_FAILED` | Token missing or expired |
| 403 | `PERMISSION_DENIED` | Authenticated but wrong role |
| 404 | `NOT_FOUND` | Resource doesn't exist or is soft-deleted |
| 409 | `CONFLICT` | Slot full, stock insufficient, idempotency replay, wallet low |
| 429 | `RATE_LIMITED` | Too many requests — retry after `wait` seconds |
| 500 | `SERVER_ERROR` | Unexpected server error — logged to Sentry |

---

## 3. List response shapes (current reality)

Most list endpoints currently return a **plain JSON array** (no pagination
envelope): `/services`, `/branches`, `/slots`, `/bookings`, `/products`,
`/orders`, `/payments/`, `/loyalty/tiers`, `/memberships/plans`, `/staff/jobs`.

Exceptions:
- `GET /notifications/` → `{ "unread_count": n, "results": [...] }`
  (supports `?limit=` and `?offset=`, plus `?unread=1`)

Cursor pagination (`{next, previous, results}`) is planned for a later phase;
client repositories already tolerate both shapes.

---

## 4. Profile & Account

```
GET  /profile/me           → { id, phone, email, role, locale, date_of_birth, fcm_token }
PATCH /profile/me          Body: { email, locale, date_of_birth, fcm_token }

# Vehicles
GET    /profile/vehicles
POST   /profile/vehicles   Body: { make, model, year, plate, colour, vehicle_type, notes, is_default }
PATCH  /profile/vehicles/{id}
DELETE /profile/vehicles/{id}

# Addresses
GET    /profile/addresses
POST   /profile/addresses  Body: { label, line1, line2, city, state, postal_code, lat, lng, is_default }
PATCH  /profile/addresses/{id}
DELETE /profile/addresses/{id}
```

Vehicle types: `sedan | suv | truck | van | hatchback | coupe | convertible | other`

---

## 5. Car Wash Services & Catalog

```
GET /services               → list of active services
GET /services?category=<id> → filtered by category
GET /services/{id}          → service detail

GET /branches               → list of active branches (with hours)
GET /branches/{id}          → branch detail including BranchHours[]

GET /services/categories    → all active service categories
```

**Service object**:
```json
{
  "id": 1,
  "name": "Full Detail",
  "slug": "full-detail",
  "description": "...",
  "base_price": "150.00",
  "currency": "SAR",
  "duration_minutes": 120,
  "category": { "id": 1, "name": "Exterior" },
  "tags": ["interior", "stain"],
  "is_mobile_available": true,
  "image": "https://..."
}
```

**Branch object** (includes hours):
```json
{
  "id": 1,
  "name": "Main Branch",
  "city": "Riyadh",
  "lat": "24.688000",
  "lng": "46.722000",
  "timezone": "Asia/Riyadh",
  "hours": [
    { "weekday": 0, "open_time": "08:00:00", "close_time": "20:00:00", "is_closed": false },
    { "weekday": 5, "open_time": "00:00:00", "close_time": "00:00:00", "is_closed": true }
  ]
}
```
Weekday: `0=Mon … 6=Sun`

---

## 6. Booking Slots & Bookings

### Get available slots
```
GET /slots?date=2026-06-10&service=1&branch=1
Response: [
  {
    "id": 42,
    "date": "2026-06-10",
    "start_time": "09:00:00",
    "end_time": "10:00:00",
    "capacity_left": 2,
    "is_available": true
  }
]
```

### Create a booking
```
POST /bookings
Headers: Idempotency-Key: <uuid>   ← REQUIRED; prevents double-booking on retry
Body:
{
  "service_id": 1,
  "slot_id": 42,
  "location_type": "branch",         // "branch" | "mobile"
  "vehicle_id": 5,                   // optional
  "address_id": null,                // required for mobile
  "mobile_lat": null,
  "mobile_lng": null
}
Response 201:
{
  "id": 101,
  "status": "confirmed",
  "price_charged": "80.00",
  "currency": "SAR",
  "payment": { "id": 55, "method": "cash", "status": "pending" },
  "slot": { "date": "2026-06-10", "start_time": "09:00:00" }
}
```

If slot is full → `409 CONFLICT`. Same Idempotency-Key → same booking returned (no charge twice).

### Booking statuses
`pending → confirmed → assigned → en_route → in_progress → completed`  
Terminal: `cancelled | no_show`

```
GET  /bookings              → my bookings list
GET  /bookings/{id}         → booking detail
POST /bookings/{id}/cancel  Body: { "reason": "..." }
POST /bookings/{id}/reschedule Body: { "slot_id": 99 }
```

### Recurring bookings
```
GET    /recurring/
POST   /recurring/
Body: {
  "service_id": 1,
  "frequency": "weekly",          // "weekly" | "biweekly" | "monthly"
  "preferred_weekday": 1,         // 0=Mon...6=Sun
  "preferred_time": "09:00",
  "location_type": "branch",
  "branch_id": 1,
  "default_payment_method": "wallet"
}
GET    /recurring/{id}
PATCH  /recurring/{id}
DELETE /recurring/{id}
```

---

## 7. Shop

### Products
```
GET /products                   → paginated list
GET /products?search=wax        → keyword search
GET /products?brand=Meguiars    → filter by brand
GET /products?car_type=suv      → filter by vehicle type
GET /products?min=20&max=150    → price range
GET /products/{id}              → detail
```

**Product object**:
```json
{
  "id": 3,
  "name": "Carnauba Wax",
  "price": "89.00",
  "compare_at_price": "110.00",
  "currency": "SAR",
  "stock": 24,
  "is_in_stock": true,
  "is_low_stock": false,
  "car_type_tags": ["sedan", "suv"],
  "images": [{ "url": "https://...", "is_primary": true }]
}
```

### Cart
```
GET    /cart                                → { items: [...], subtotal: "169.00", promo_code: null }
POST   /cart/items     Body: { product_id, quantity }
PATCH  /cart/items/{id} Body: { quantity: 2 }
DELETE /cart/items/{id}
POST   /cart/apply-promo Body: { code: "SUMMER20" }
```

### Checkout
```
POST /orders/checkout
Headers: Idempotency-Key: <uuid>
Body: {
  "delivery_method": "pickup",      // "pickup" | "delivery"
  "shipping_address_id": null       // required for delivery
}
Response 201: { "id": 77, "status": "pending", "total": "169.00", "payment": {...} }
```

After checkout, call `POST /payments/intent` with the payment id to get the Stripe `client_secret` for the mobile SDK.

```
GET /orders               → my orders list
GET /orders/{id}          → order detail
GET /orders/{id}/track    → shipping tracking info
```

Order statuses: `pending → paid → processing → shipped → delivered`  
Terminal: `cancelled | refunded`

---

## 8. Payments

### Stripe card flow
```
1. POST /orders/checkout           → creates Order + Payment(requires_action)
2. POST /payments/intent           Body: { payment_id: 55 }
                                   Response: { client_secret: "pi_xxx_secret_yyy" }
3. Client-side: stripe.confirmPayment(client_secret)
4. Stripe webhook fires → server marks Order paid + decrements stock
```

### Wallet payment
```
POST /payments/confirm   Body: { payment_id: 55 }
```
Wallet must have sufficient balance. Atomic deduction — never negative.

### Wallet
```
GET /payments/wallet
Response: {
  "balance": "250.00",
  "currency": "SAR",
  "recent_transactions": [
    { "delta": "-80.00", "reason": "booking_payment", "balance_after": "250.00", "created_at": "..." }
  ]
}
```

### Promo codes
Applied via `POST /cart/apply-promo` (for orders). For bookings, pass `promo_code` in the booking create payload (Phase 2 enhancement). Server computes discount — never trust client.

---

## 9. Notifications

```
GET  /notifications?unread=1      → { unread_count: 3, results: [...] }
POST /notifications/{id}/read
POST /notifications/read-all
GET  /notifications/settings      → { booking_reminders, order_updates, promotions, loyalty_updates, push_enabled }
PATCH /notifications/settings     Body: { push_enabled: false }

POST /notifications/fcm-token     Body: { fcm_token: "dXpz..." }
```

**Register FCM token on app launch** and after Firebase refreshes it:
```dart
// Flutter
FirebaseMessaging.instance.getToken().then((token) {
  api.post('/notifications/fcm-token', { 'fcm_token': token });
});
FirebaseMessaging.instance.onTokenRefresh.listen((token) {
  api.post('/notifications/fcm-token', { 'fcm_token': token });
});
```

**Notification types**: `booking_confirmed | booking_reminder_24h | booking_reminder_1h | booking_cancelled | booking_completed | order_confirmed | order_shipped | order_delivered | abandoned_cart | birthday | membership_renewal | loyalty_points | general`

Push payload `data` map always contains `type` so the app can deep-link:
```json
{ "type": "booking_confirmed", "booking_id": "101" }
```

---

## 10. Loyalty & Memberships

```
GET /loyalty/status
Response: {
  "washes_count": 12,
  "points": 1040,
  "current_tier": { "name": "Silver", "threshold_washes": 10, "discount_percent": "10.00" }
}

GET  /loyalty/tiers     → all tiers with thresholds
GET  /loyalty/referrals → my referrals (code + reward state)
POST /loyalty/referrals Body: { "referee_phone": "+966512345679" }

GET  /memberships/plans
Response: [
  { "id": 1, "name": "Monthly Unlimited", "price": "199.00", "billing_interval": "month",
    "included_washes": 8, "discount_percent": "15.00" }
]

POST /memberships/subscribe   Body: { plan_id: 1 }
POST /memberships/cancel
GET  /memberships/my          → current UserSubscription
```

Membership subscription creates a Stripe Subscription. The client must confirm the returned `payment_intent_client_secret` if present (for the first payment).

---

## 11. Staff App

> All staff endpoints require `role = "staff"` or `"admin"`.

```
GET  /staff/jobs                  → my assigned jobs list
GET  /staff/jobs/{booking_id}     → job detail with tasks + photos
POST /staff/jobs/{booking_id}/accept
POST /staff/jobs/{booking_id}/status  Body: { "status": "en_route" }
      // statuses: accepted → en_route → in_progress → completed

GET  /staff/jobs/{booking_id}/tasks
POST /staff/jobs/{booking_id}/tasks/{task_id}/toggle  (marks done/undone)

POST /staff/jobs/{booking_id}/photos/presign
      Body: { "kind": "before" }   // "before" | "after"
      Response: { "upload_url": "https://r2.../signed", "s3_key": "job-photos/..." }
POST /staff/jobs/{booking_id}/photos/record
      Body: { "kind": "before", "s3_key": "job-photos/...", "caption": "" }
```

**Photo upload flow**:
1. Call `/staff/jobs/{id}/photos/presign` → get `upload_url`
2. HTTP PUT the image binary directly to `upload_url` (from device, not via backend)
3. Call `/staff/jobs/{id}/photos/record` with the `s3_key`

---

## 12. Live Tracking (WebSocket — Phase 3)

### Connection
```
wss://api.yourdomain.com/ws/track/{booking_id}/?token=<access_jwt>
```

Authentication: pass JWT as query param `token`. Connection is rejected (code 4001) if unauthenticated or 4003 if the user doesn't have permission (not the booking owner, not the assigned staff, not an admin).

### Protocol — Staff → Server (send GPS pings)
```json
{ "type": "ping", "lat": 24.688, "lng": 46.685, "accuracy_m": 5.0 }
```

### Protocol — Server → Customer (receive updates)
```json
{ "type": "ping", "lat": 24.688, "lng": 46.685, "recorded_at": "2026-06-10T09:15:00Z", "eta_minutes": 7 }
{ "type": "status", "booking_status": "en_route" }
{ "type": "error", "message": "..." }
```

`eta_minutes` is `null` when the Maps API key is not configured (uses Haversine fallback instead).

---

## 13. Admin API

> All admin endpoints require `role = "admin"`.

```
GET  /admin-api/home-layout
PUT  /admin-api/home-layout  Body: [ { type, title, ... } ]

GET  /admin-api/promos
POST /admin-api/promos  Body: { code, discount_type, value, min_spend, usage_limit, valid_from, valid_until, applies_to }
GET  /admin-api/promos/{id}
PATCH /admin-api/promos/{id}

PATCH /admin-api/inventory/{product_id}  Body: { stock: 50 }

GET  /admin-api/bookings?status=confirmed&date=2026-06-10
POST /admin-api/bookings/{booking_id}/assign  Body: { staff_user_id: 3 }

PATCH /admin-api/orders/{id}/status  Body: { status: "shipped", tracking_number: "..." }

# Analytics
GET /admin-api/analytics/dashboard
GET /admin-api/analytics/revenue-by-day?from=2026-05-01&to=2026-05-31
GET /admin-api/analytics/bookings?from=...&to=...
GET /admin-api/analytics/top-services?limit=5
GET /admin-api/analytics/low-stock
GET /admin-api/analytics/staff
```

### Home layout sections
The `GET /home/layout` (customer-facing) returns an ordered array the app renders generically:
```json
[
  { "type": "hero_banner", "title": "Summer Deals", "cta": "Book Now", "image": null },
  { "type": "offer_strip", "text": "Free interior spray with any full detail" },
  { "type": "service_rail", "title": "Our Services", "source": "services" },
  { "type": "product_rail", "title": "Shop", "source": "featured_products" }
]
```
The app fetches the matching data (`source`) from the respective API and renders it in the rail.

---

## 14. Health Endpoints

```
GET /healthz   → 200 { "status": "ok" }
GET /readyz    → 200 { "status": "ok", "checks": { "database": "ok", "cache": "ok" } }
               → 503 if DB or Redis is down
```

---

## 15. Key Frontend Rules

### Always
- **Include `Idempotency-Key: <uuid>`** on `POST /bookings`, `POST /orders/checkout`, and `POST /payments/intent`. Generate a fresh UUID per logical action; reuse the same UUID on retries.
- **Treat all money as strings.** `"80.00"` not `80.0`. Format for display: parse the string, never arithmetic on the raw float.
- **Refresh JWT proactively.** Access token lifetime is 15 minutes. Refresh when `exp - now < 60s`, not after a 401.
- **Store `refresh` token securely** — Flutter Secure Storage / iOS Keychain / Android EncryptedSharedPreferences.

### Never
- Never compute totals client-side. The backend is the single source of truth for price, discount, and stock.
- Never hardcode currency. Always use the `currency` field from the API response.
- Never send raw floats for money fields. Always send strings: `"80.00"`.
- Never cache booking slot availability — always fetch fresh before displaying to the user.

---

## 16. Role-Based UI

| Endpoint family | customer | staff | admin |
|---|---|---|---|
| `auth/*`, `profile/*` | ✅ | ✅ | ✅ |
| `services/*`, `branches/*`, `slots/*` | ✅ | ✅ | ✅ |
| `bookings/*`, `recurring/*` | ✅ (own) | read | ✅ (all) |
| `products/*`, `cart/*`, `orders/*` | ✅ | — | ✅ |
| `payments/*` | ✅ (own) | — | ✅ |
| `loyalty/*`, `memberships/*` | ✅ | — | ✅ |
| `staff/*` | — | ✅ (own jobs) | ✅ |
| `notifications/*` | ✅ | ✅ | ✅ |
| `admin-api/*` | — | — | ✅ |
| `ws/track/{id}/` | ✅ (own booking) | ✅ (assigned) | ✅ |

---

## 17. Environment & Feature Flags (server-side)

The backend exposes these capabilities only when the corresponding env vars are set. Your app should gracefully handle absence of these features:

| Flag | Effect on frontend |
|---|---|
| `SMS_ENABLED=False` | OTP is logged server-side only — use any 6-digit code in dev |
| `GEO_ENABLED=False` | No service-area validation on mobile bookings |
| `CHANNELS_ENABLED=False` | WebSocket `/ws/track/` not active; skip live tracking UI |
| `MAPS_API_KEY=` empty | `eta_minutes` is always computed via Haversine (rough estimate) |
| `FCM_ENABLED=False` | Push notifications suppressed server-side |
| `SOCIAL_AUTH_ENABLED=False` | `/auth/social/` returns 404 — hide social login buttons |

---

## 18. Data Types Quick Reference

| Field | Type in JSON | Notes |
|---|---|---|
| `id` | integer | BigAutoField |
| `price`, `total`, `balance` | `"80.00"` string | Always 2 decimal places |
| `currency` | `"SAR"` | ISO 4217 |
| `lat`, `lng` | `"24.688000"` string | 6 decimal places |
| `date` | `"2026-06-10"` | ISO 8601 date |
| `time` | `"09:00:00"` | HH:MM:SS |
| `datetime` | `"2026-06-10T09:00:00Z"` | ISO 8601 UTC |
| `weekday` | `0..6` | 0=Monday, 6=Sunday |
| `phone` | `"+966512345678"` | E.164 format |
| `role` | `"customer"` `"staff"` `"admin"` | string enum |
| `booking_status` | see §6 | string enum |
| `order_status` | see §7 | string enum |
