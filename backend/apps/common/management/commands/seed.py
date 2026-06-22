"""
management command: python manage.py seed

Creates demo data for fast UI/mobile dev:
  - 1 Tenant  (Sridhar Car Wash)
  - 1 Admin + 1 Customer + 1 Staff user
  - 6 ServiceCategories + 16 Services
  - 1 Branch + BranchHours (Sun–Thu, 8am–7pm)
  - 1 SlotTemplate + BookingSlots for next 14 days
  [Phase 2]
  - 3 Shop Categories + 10 Products
  - 2 PromoCodes (SRIDHAR10, FLAT20)
  - Wallet top-up for demo customer (200 SAR)
  - 3 LoyaltyTiers (Bronze, Silver, Gold)
  - Default NotificationTriggers

All operations are idempotent — safe to run multiple times.
"""
import datetime

from django.contrib.auth.hashers import make_password
from django.core.management.base import BaseCommand
from django.utils import timezone


class Command(BaseCommand):
    help = "Seed the database with demo data for development."

    def handle(self, *args, **options):
        from apps.common.celery_tenant import with_tenant_context

        self.stdout.write("🌱 Seeding Sridhar Car Wash demo data...")

        # Tenant is not RLS-scoped — create it outside the context
        tenant = self._seed_tenant()

        # All subsequent inserts go into RLS-protected tables and require
        # the tenant context to be set so that RLS policies allow the writes.
        with with_tenant_context(str(tenant.id)):
            customer, _staff, _admin = self._seed_users(tenant)
            categories = self._seed_categories(tenant)
            self._seed_services(tenant, categories)
            branch = self._seed_branch(tenant)
            self._seed_slot_templates(tenant, branch)
            self._seed_slots(tenant)

            # ── Phase 2 ───────────────────────────────────────────────────────
            self._seed_shop_categories_and_products(tenant)
            self._seed_promo_codes(tenant)
            self._seed_wallet(tenant, customer)
            self._seed_loyalty_tiers(tenant)
            self._seed_notification_triggers(tenant)

        self.stdout.write(self.style.SUCCESS("✅ Seed complete."))

    # ── Tenant ────────────────────────────────────────────────────────────────

    def _seed_tenant(self):
        from apps.common.models import Tenant
        tenant, created = Tenant.objects.get_or_create(
            slug="sridhar-carwash",
            defaults={"name": "Sridhar Car Wash", "is_active": True},
        )
        self._log("Tenant", tenant.name, created)
        return tenant

    # ── Users ─────────────────────────────────────────────────────────────────

    def _seed_users(self, tenant):
        from apps.accounts.models import CustomUser, CustomerProfile

        admin, c = CustomUser.objects.get_or_create(
            phone="+966500000000",
            defaults={
                "username": "admin",
                "tenant": tenant,
                "role": "admin",
                "is_phone_verified": True,
                "is_staff": True,
                "is_superuser": True,
                "password": make_password("admin1234"),
            },
        )
        self._log("Admin user", admin.phone, c)

        customer, c = CustomUser.objects.get_or_create(
            phone="+966511111111",
            defaults={
                "username": "customer",
                "tenant": tenant,
                "role": "customer",
                "is_phone_verified": True,
                "password": make_password("customer1234"),
            },
        )
        self._log("Customer user", customer.phone, c)
        CustomerProfile.objects.get_or_create(user=customer)

        staff, c = CustomUser.objects.get_or_create(
            phone="+966522222222",
            defaults={
                "username": "staff",
                "tenant": tenant,
                "role": "staff",
                "is_phone_verified": True,
                "password": make_password("staff1234"),
            },
        )
        self._log("Staff user", staff.phone, c)

        return customer, staff, admin

    # ── Service categories ────────────────────────────────────────────────────

    def _seed_categories(self, tenant):
        from apps.catalog.models import ServiceCategory

        category_data = [
            dict(slug="exterior-wash",        name="Exterior Wash",        ordering=1,
                 description="Complete exterior cleaning to make your car shine."),
            dict(slug="interior-detailing",   name="Interior Detailing",   ordering=2,
                 description="Deep-clean your cabin — fresh, spotless, fragrant."),
            dict(slug="premium-detailing",    name="Premium Detailing",    ordering=3,
                 description="Professional-grade paint & ceramic treatments."),
            dict(slug="mobile-service",       name="Mobile Service",       ordering=4,
                 description="We come to you — doorstep car care anywhere in the city."),
            dict(slug="subscription-packages", name="Subscription Packages", ordering=5,
                 description="Monthly plans for regular care at unbeatable value."),
            dict(slug="special-treatments",   name="Special Treatments",   ordering=6,
                 description="Targeted treatments for headlights, engine bay & more."),
        ]

        cats = {}
        for cd in category_data:
            obj, c = ServiceCategory.objects.get_or_create(
                tenant=tenant, slug=cd["slug"],
                defaults={"is_active": True, **cd},
            )
            self._log("ServiceCategory", obj.name, c)
            cats[cd["slug"]] = obj

        return cats

    # ── Services ──────────────────────────────────────────────────────────────

    def _seed_services(self, tenant, cats):
        from apps.catalog.models import Service

        ext  = cats["exterior-wash"]
        int_ = cats["interior-detailing"]
        pre  = cats["premium-detailing"]
        mob  = cats["mobile-service"]
        sub  = cats["subscription-packages"]
        spe  = cats["special-treatments"]

        service_data = [
            # ── Exterior Wash ──────────────────────────────────────────────
            dict(
                slug="express-wash", category=ext,
                name="Express Wash",
                base_price="49.00", duration_minutes=30,
                description=(
                    "Quick rinse, foam blast & air dry. Perfect for a daily "
                    "refresh when you're short on time."
                ),
                tags=["express", "exterior", "quick"],
            ),
            dict(
                slug="full-exterior-wash", category=ext,
                name="Full Exterior Wash",
                base_price="99.00", duration_minutes=60,
                description=(
                    "Hand wash, clay-bar decontamination, tyre shine & streak-free "
                    "glass clean. Your car leaves spotless."
                ),
                tags=["exterior", "hand-wash", "tyres", "glass"],
            ),
            dict(
                slug="foam-cannon-wash", category=ext,
                name="Foam Cannon Wash",
                base_price="129.00", duration_minutes=45,
                description=(
                    "High-pressure pre-soak with thick snow foam lifts dirt before "
                    "contact. Swirl-free, paint-safe finish."
                ),
                tags=["exterior", "foam", "pressure-wash", "safe"],
            ),
            dict(
                slug="exterior-tyre-dressing", category=ext,
                name="Exterior + Tyre Dressing",
                base_price="149.00", duration_minutes=75,
                description=(
                    "Full exterior wash + long-lasting rubber conditioner on all four "
                    "tyres for that showroom look."
                ),
                tags=["exterior", "tyres", "dressing"],
            ),

            # ── Interior Detailing ─────────────────────────────────────────
            dict(
                slug="interior-vacuum-clean", category=int_,
                name="Interior Vacuum & Clean",
                base_price="149.00", duration_minutes=90,
                description=(
                    "Full vacuum, dashboard & door-card wipe-down, glass clean & "
                    "premium cabin fragrance."
                ),
                tags=["interior", "vacuum", "dash"],
            ),
            dict(
                slug="full-interior-detail", category=int_,
                name="Full Interior Detail",
                base_price="249.00", duration_minutes=120,
                description=(
                    "Deep-extraction carpet shampoo, seat scrub, leather conditioning, "
                    "vent detailing & ozone refresh."
                ),
                tags=["interior", "deep-clean", "carpet", "leather"],
            ),
            dict(
                slug="odour-elimination", category=int_,
                name="Odour Elimination Treatment",
                base_price="99.00", duration_minutes=60,
                description=(
                    "Ozone generator + enzyme spray neutralises smoke, pet & food odours "
                    "at the molecular level."
                ),
                tags=["interior", "odour", "ozone", "pet"],
            ),

            # ── Premium Detailing ──────────────────────────────────────────
            dict(
                slug="full-detail-package", category=pre,
                name="Full Detail Package",
                base_price="399.00", duration_minutes=180,
                description=(
                    "Our best-seller: complete interior + exterior detail. Clay bar, "
                    "one-stage polish, hand wax & deep interior clean."
                ),
                tags=["interior", "exterior", "full", "polish", "wax"],
                is_mobile_available=False,
            ),
            dict(
                slug="paint-decontamination", category=pre,
                name="Paint Decontamination & Polish",
                base_price="599.00", duration_minutes=240,
                description=(
                    "Iron fallout removal, clay bar, machine compound & finishing polish. "
                    "Removes swirls, holograms & light scratches."
                ),
                tags=["paint", "polish", "decontamination", "machine"],
                is_mobile_available=False,
            ),
            dict(
                slug="ceramic-coating-1yr", category=pre,
                name="Ceramic Coating (1-Year)",
                base_price="999.00", duration_minutes=300,
                description=(
                    "9H ceramic coating with 1-year hydrophobic protection. Includes "
                    "full paint decontamination, polish & coating application."
                ),
                tags=["ceramic", "coating", "protection", "hydrophobic"],
                is_mobile_available=False,
            ),

            # ── Mobile Service ─────────────────────────────────────────────
            dict(
                slug="mobile-express-wash", category=mob,
                name="Mobile Express Wash",
                base_price="149.00", duration_minutes=60,
                description=(
                    "Our team arrives at your home or office with all equipment. "
                    "Waterless wash + interior quick-clean."
                ),
                tags=["mobile", "express", "doorstep", "waterless"],
                is_mobile_available=True,
            ),
            dict(
                slug="mobile-full-detail", category=mob,
                name="Mobile Full Detail",
                base_price="449.00", duration_minutes=210,
                description=(
                    "Complete interior & exterior detail — at your location. "
                    "We bring the studio to you."
                ),
                tags=["mobile", "full", "doorstep", "interior", "exterior"],
                is_mobile_available=True,
            ),

            # ── Subscription Packages ──────────────────────────────────────
            dict(
                slug="monthly-unlimited-exterior", category=sub,
                name="Monthly Unlimited Exterior",
                base_price="299.00", duration_minutes=30,
                description=(
                    "Unlimited express exterior washes for 30 days. Best value for "
                    "daily drivers. Valid at main branch."
                ),
                tags=["subscription", "monthly", "exterior", "unlimited"],
            ),
            dict(
                slug="premium-monthly-package", category=sub,
                name="Premium Monthly Package",
                base_price="499.00", duration_minutes=90,
                description=(
                    "4 full exterior washes + 2 interior cleans per month. Priority "
                    "booking & 10% off shop products."
                ),
                tags=["subscription", "monthly", "premium", "interior", "exterior"],
            ),

            # ── Special Treatments ─────────────────────────────────────────
            dict(
                slug="headlight-restoration", category=spe,
                name="Headlight Restoration",
                base_price="149.00", duration_minutes=60,
                description=(
                    "Sand, polish & UV-coat foggy/yellowed headlights. Restores "
                    "clarity & improves night-time visibility."
                ),
                tags=["headlights", "restoration", "uv"],
            ),
            dict(
                slug="engine-bay-clean", category=spe,
                name="Engine Bay Clean",
                base_price="199.00", duration_minutes=90,
                description=(
                    "Degrease, pressure-rinse & dress the engine bay. Makes servicing "
                    "easier and your engine look brand new."
                ),
                tags=["engine", "degreaser", "underbonnet"],
            ),
        ]

        for svc in service_data:
            obj, c = Service.objects.get_or_create(
                tenant=tenant, slug=svc["slug"],
                defaults={"currency": "SAR", "is_active": True, **svc},
            )
            self._log("Service", obj.name, c)

    # ── Branch ────────────────────────────────────────────────────────────────

    def _seed_branch(self, tenant):
        from apps.catalog.models import Branch, BranchHours

        branch, c = Branch.objects.get_or_create(
            tenant=tenant, name="Sridhar Car Wash Riyadh Main",
            defaults={
                "address": "King Fahd Road, Al Olaya District",
                "city": "Riyadh",
                "lat": "24.688765",
                "lng": "46.685673",
                "timezone": "Asia/Riyadh",
                "phone": "+966112345678",
                "is_active": True,
            },
        )
        self._log("Branch", branch.name, c)

        # Sun–Thu 8am–7pm open; Fri & Sat closed
        WORK_DAYS = [0, 1, 2, 3, 6]  # Mon, Tue, Wed, Thu, Sun
        for wd in range(7):
            BranchHours.objects.get_or_create(
                branch=branch, weekday=wd,
                defaults={
                    "open_time": datetime.time(8, 0),
                    "close_time": datetime.time(19, 0),
                    "is_closed": wd not in WORK_DAYS,
                },
            )
        return branch

    # ── Slot template + slot generation ──────────────────────────────────────

    def _seed_slot_templates(self, tenant, branch):
        from apps.scheduling.models import SlotTemplate

        tmpl, c = SlotTemplate.objects.get_or_create(
            tenant=tenant, branch=branch, service=None,
            defaults={
                "slot_minutes": 60,
                "capacity_per_slot": 4,
                "active_weekdays": [0, 1, 2, 3, 6],
                "is_active": True,
            },
        )
        self._log("SlotTemplate", f"branch={branch.name}", c)

    def _seed_slots(self, tenant):
        from apps.scheduling.services import generate_slots_for_tenant
        count = generate_slots_for_tenant(tenant=tenant, days_ahead=14)
        self.stdout.write(f"  → Generated {count} booking slots (14 days)")

    # ── Shop ─────────────────────────────────────────────────────────────────

    def _seed_shop_categories_and_products(self, tenant):
        from apps.shop.models import Category, Product

        shampoo_cat, c = Category.objects.get_or_create(
            tenant=tenant, slug="car-shampoo",
            defaults={"name": "Car Shampoo & Polish", "ordering": 1, "is_active": True},
        )
        self._log("ShopCategory", shampoo_cat.name, c)

        accessories_cat, c = Category.objects.get_or_create(
            tenant=tenant, slug="accessories",
            defaults={"name": "Accessories & Tools", "ordering": 2, "is_active": True},
        )
        self._log("ShopCategory", accessories_cat.name, c)

        protection_cat, c = Category.objects.get_or_create(
            tenant=tenant, slug="paint-protection",
            defaults={"name": "Paint Protection", "ordering": 3, "is_active": True},
        )
        self._log("ShopCategory", protection_cat.name, c)

        products = [
            # ── Shampoo & Polish ───────────────────────────────────────────
            dict(
                slug="sridhar-foam-shampoo-1l", category=shampoo_cat,
                name="Sridhar Foam Shampoo 1L",
                price="45.00", brand="Sridhar", sku="SFS-1L-001", stock=80,
                car_type_tags=["sedan", "suv", "hatchback"],
                description=(
                    "pH-neutral, high-foam shampoo safe on all paint types. "
                    "Leaves a clean, streak-free finish every time."
                ),
                is_featured=True,
            ),
            dict(
                slug="sridhar-carnauba-wax-200g", category=shampoo_cat,
                name="Sridhar Carnauba Wax Paste 200g",
                price="89.00", brand="Sridhar", sku="SCW-200", stock=40,
                car_type_tags=["sedan", "sports", "luxury"],
                description=(
                    "Brazilian carnauba wax blended with polymers for a deep, "
                    "warm shine lasting up to 3 months."
                ),
                is_featured=True,
            ),
            dict(
                slug="sridhar-interior-detailer-250ml", category=shampoo_cat,
                name="Sridhar Interior Detailer Spray 250ml",
                price="39.00", brand="Sridhar", sku="SID-250", stock=60,
                car_type_tags=[],
                description=(
                    "Anti-static, UV-protecting interior cleaner for dashboards, "
                    "door cards & plastic trim. Leaves a matte finish."
                ),
            ),
            dict(
                slug="sridhar-all-purpose-cleaner-500ml", category=shampoo_cat,
                name="Sridhar APC All-Purpose Cleaner 500ml",
                price="55.00", brand="Sridhar", sku="SAPC-500", stock=50,
                car_type_tags=[],
                description=(
                    "Dilutable all-purpose cleaner — use on seats, carpet, engine "
                    "bay & wheels. 1:10 dilution for general use."
                ),
            ),

            # ── Accessories & Tools ────────────────────────────────────────
            dict(
                slug="microfiber-cloths-pack-10", category=accessories_cat,
                name="Microfibre Cloths — Pack of 10",
                price="49.00", brand="CleanPro", sku="MFC-10PK", stock=120,
                car_type_tags=[],
                description=(
                    "Ultra-soft 380gsm microfibre cloths — coloured by task "
                    "(blue=body, yellow=interior, red=wheels). Swirl-free."
                ),
                is_featured=True,
            ),
            dict(
                slug="tyre-shine-spray-500ml", category=accessories_cat,
                name="Tyre Shine Spray 500ml",
                price="29.00", brand="Sridhar", sku="STS-500", stock=75,
                car_type_tags=[],
                description=(
                    "Water-based wet-look tyre dressing. Protects against cracking "
                    "& UV damage. No sling formula."
                ),
            ),
            dict(
                slug="foam-cannon-lance", category=accessories_cat,
                name="Foam Cannon Lance",
                price="149.00", brand="ProWash", sku="FCL-001", stock=20,
                car_type_tags=[],
                description=(
                    "1/4\" quick-connect foam lance for pressure washers. Adjustable "
                    "foam thickness dial & fan spray pattern."
                ),
                is_featured=True,
            ),
            dict(
                slug="detailing-brush-set-5pc", category=accessories_cat,
                name="Detailing Brush Set — 5 Pieces",
                price="69.00", brand="CleanPro", sku="DBS-5PC", stock=35,
                car_type_tags=[],
                description=(
                    "Soft boar-hair brushes in 5 sizes for vents, emblems, gaps "
                    "& interior trim. Scratch-free bristles."
                ),
            ),

            # ── Paint Protection ───────────────────────────────────────────
            dict(
                slug="windshield-rain-repellent-100ml", category=protection_cat,
                name="Windshield Rain Repellent 100ml",
                price="59.00", brand="CleanPro", sku="WWR-100", stock=30,
                car_type_tags=[],
                description=(
                    "Silicone-free glass coating that causes rain to bead off at "
                    "speeds above 60 km/h. 3-month durability."
                ),
                is_featured=True,
            ),
            dict(
                slug="sridhar-quick-detail-spray-500ml", category=protection_cat,
                name="Sridhar Quick Detail Spray 500ml",
                price="75.00", brand="Sridhar", sku="SQDS-500", stock=45,
                car_type_tags=["sedan", "suv", "luxury"],
                description=(
                    "SiO2-infused spray detailer adds slickness, gloss & light "
                    "protection between washes. Works on wet or dry paint."
                ),
            ),
        ]

        for pd in products:
            obj, c = Product.objects.get_or_create(
                tenant=tenant, slug=pd["slug"],
                defaults={"currency": "SAR", "is_active": True, **pd},
            )
            self._log("Product", obj.name, c)

    # ── Promo codes ───────────────────────────────────────────────────────────

    def _seed_promo_codes(self, tenant):
        from apps.payments.models import PromoCode

        promos = [
            dict(
                code="SRIDHAR10",
                discount_type="percent", value="10",
                min_spend="0", applies_to="both",
                usage_limit=None,
            ),
            dict(
                code="FLAT20",
                discount_type="fixed", value="20",
                min_spend="100", applies_to="shop",
                usage_limit=200,
            ),
        ]
        now = timezone.now()
        for p in promos:
            obj, c = PromoCode.objects.get_or_create(
                tenant=tenant, code=p["code"],
                defaults={
                    "valid_from": now,
                    "valid_until": now + datetime.timedelta(days=365),
                    "is_active": True,
                    **p,
                },
            )
            self._log("PromoCode", obj.code, c)

    # ── Wallet ────────────────────────────────────────────────────────────────

    def _seed_wallet(self, tenant, customer):
        from apps.payments.models import Wallet, WalletTransaction
        from decimal import Decimal

        wallet, created = Wallet.objects.get_or_create(
            user=customer,
            defaults={"tenant": tenant, "balance": Decimal("200.00"), "currency": "SAR"},
        )
        if created:
            WalletTransaction.objects.create(
                tenant=tenant, wallet=wallet,
                delta=Decimal("200.00"), balance_after=Decimal("200.00"),
                reason=WalletTransaction.Reason.TOP_UP,
                reference="seed-demo-topup",
            )
        self._log("Wallet", f"user={customer.phone} balance={wallet.balance}", created)

    # ── Loyalty tiers ─────────────────────────────────────────────────────────

    def _seed_loyalty_tiers(self, tenant):
        from apps.loyalty.models import LoyaltyTier

        tiers = [
            dict(name="Bronze", threshold_washes=0,  discount_percent="0",  perks={}),
            dict(name="Silver", threshold_washes=5,  discount_percent="5",  perks={"priority_booking": True}),
            dict(name="Gold",   threshold_washes=15, discount_percent="10", perks={"priority_booking": True, "free_interior_clean": True}),
        ]
        for t in tiers:
            obj, c = LoyaltyTier.objects.get_or_create(
                tenant=tenant, name=t["name"],
                defaults={"is_active": True, **t},
            )
            self._log("LoyaltyTier", obj.name, c)

    # ── Notification triggers ─────────────────────────────────────────────────

    def _seed_notification_triggers(self, tenant):
        from apps.notifications.models import NotificationTrigger

        triggers = [
            dict(
                event="booking_reminder_24h",
                offset_hours=-24,
                title_template="Car Wash Reminder 🚗",
                body_template=(
                    "Your Sridhar Car Wash appointment is tomorrow. "
                    "We'll have your car looking brand new!"
                ),
            ),
            dict(
                event="booking_reminder_1h",
                offset_hours=-1,
                title_template="Car Wash in 1 Hour ⏰",
                body_template=(
                    "Your Sridhar Car Wash starts in about 1 hour. "
                    "Please head over to our branch — we're ready for you!"
                ),
            ),
            dict(
                event="booking_confirmed",
                offset_hours=0,
                title_template="Booking Confirmed ✅",
                body_template=(
                    "Your Sridhar Car Wash booking is confirmed! "
                    "Check the app for your appointment details."
                ),
            ),
            dict(
                event="abandoned_cart",
                offset_hours=1,
                title_template="Your Cart is Waiting 🛒",
                body_template=(
                    "You left items in your Sridhar Car Wash cart. "
                    "Complete your order before they sell out!"
                ),
            ),
            dict(
                event="wash_completed",
                offset_hours=0,
                title_template="All Done! Rate Your Wash ⭐",
                body_template=(
                    "Your car wash is complete! How did we do? "
                    "Tap to leave a review — it means a lot to us."
                ),
            ),
        ]
        for t in triggers:
            obj, c = NotificationTrigger.objects.get_or_create(
                tenant=tenant, event=t["event"],
                defaults={"is_active": True, **t},
            )
            self._log("NotificationTrigger", obj.event, c)

    # ── Helpers ───────────────────────────────────────────────────────────────

    def _log(self, model: str, name: str, created: bool):
        verb = "Created" if created else "Already exists"
        self.stdout.write(f"  {model}: {name} ({verb})")
