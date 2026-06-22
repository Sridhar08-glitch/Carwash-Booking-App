import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/auth/session_state.dart';
import '../core/providers/session_provider.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/services/presentation/screens/services_list_screen.dart';
import '../features/services/presentation/screens/service_detail_screen.dart';
import '../features/booking/presentation/screens/slot_picker_screen.dart';
import '../features/booking/presentation/screens/booking_location_screen.dart';
import '../features/booking/presentation/screens/booking_confirm_screen.dart';
import '../features/booking/presentation/screens/booking_success_screen.dart';
import '../features/booking/presentation/screens/booking_history_screen.dart';
import '../features/booking/presentation/screens/booking_detail_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/staff/presentation/screens/staff_shell_screen.dart';
// Phase 2 imports
import '../features/shop/presentation/screens/shop_screen.dart';
import '../features/shop/presentation/screens/product_detail_screen.dart';
import '../features/cart/presentation/screens/cart_screen.dart';
import '../features/payments/presentation/screens/checkout_screen.dart';
import '../features/payments/presentation/screens/wallet_screen.dart';
import '../features/orders/presentation/screens/orders_screen.dart';
import '../features/orders/presentation/screens/order_detail_screen.dart';
import '../features/notifications/presentation/screens/notifications_inbox_screen.dart';
import '../features/notifications/presentation/screens/notification_settings_screen.dart';
// Phase 3 imports
import '../features/recurring/presentation/screens/recurring_list_screen.dart';
import '../features/recurring/presentation/screens/recurring_form_screen.dart';
import '../features/staff/presentation/screens/staff_jobs_screen.dart';
import '../features/staff/presentation/screens/staff_job_detail_screen.dart';
import '../features/tracking/presentation/screens/tracking_screen.dart';
import '../features/loyalty/presentation/screens/loyalty_screen.dart';
import '../features/memberships/presentation/screens/memberships_screen.dart';
import '../features/profile/presentation/screens/referrals_screen.dart';
import 'shell_scaffold.dart';

part 'router.g.dart';

// ---------------------------------------------------------------------------
// Route names — use these for navigation to avoid magic strings
// ---------------------------------------------------------------------------
class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const otp = '/otp';

  // Customer shell
  static const home = '/home';
  static const services = '/services';
  static const serviceDetail = '/services/:serviceId';
  static const slotPicker = '/booking/slots';
  static const bookingLocation = '/booking/location';
  static const bookingConfirm = '/booking/confirm';
  static const bookingSuccess = '/booking/success';
  static const bookingHistory = '/bookings';
  static const bookingDetail = '/bookings/:bookingId';
  static const profile = '/profile';

  // Phase 2 — shop
  static const shop = '/shop';
  static const shopProduct = '/shop/:productId';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const wallet = '/wallet';
  static const orders = '/orders';
  static const orderDetail = '/orders/:orderId';
  static const notifications = '/notifications';
  static const notificationSettings = '/profile/notifications';

  // Phase 3 — recurring, tracking, loyalty, memberships, referrals
  static const recurring = '/recurring';
  static const recurringNew = '/recurring/new';
  static const tracking = '/tracking/:bookingId';
  static const profileLoyalty = '/profile/loyalty';
  static const profileMemberships = '/profile/memberships';
  static const profileReferrals = '/profile/referrals';

  // Phase 4 — QR deep link
  static const qr = '/qr/:bookingId';

  // Staff shell
  static const staffJobs = '/staff/jobs';
  static const staffJobDetail = '/staff/jobs/:bookingId';

  static String serviceDetailPath(int id) => '/services/$id';
  static String bookingDetailPath(int id) => '/bookings/$id';
  static String productDetailPath(int id) => '/shop/$id';
  static String orderDetailPath(int id) => '/orders/$id';
  static String trackingPath(int bookingId) => '/tracking/$bookingId';
  static String staffJobDetailPath(int bookingId) => '/staff/jobs/$bookingId';
  static String qrPath(int bookingId) => '/qr/$bookingId';
}

// ---------------------------------------------------------------------------
// Router provider
// ---------------------------------------------------------------------------
@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _SessionListenable(ref),
    redirect: (context, state) => _redirect(state, ref.read(sessionStateProvider)),
    routes: [
      // Splash — redirects immediately based on session
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const _SplashScreen(),
      ),

      // Auth routes — accessible only when unauthenticated
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (_, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          final isNew = state.uri.queryParameters['isNew'] == 'true';
          return OtpScreen(phone: phone, isNew: isNew);
        },
      ),

      // Customer shell — bottom nav wrapper
      ShellRoute(
        builder: (_, __, child) => CustomerShellScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.services,
            builder: (_, __) => const ServicesListScreen(),
            routes: [
              GoRoute(
                path: ':serviceId',
                builder: (_, state) => ServiceDetailScreen(
                  serviceId: int.parse(state.pathParameters['serviceId']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.bookingHistory,
            builder: (_, __) => const BookingHistoryScreen(),
            routes: [
              GoRoute(
                path: ':bookingId',
                builder: (_, state) => BookingDetailScreen(
                  bookingId: int.parse(state.pathParameters['bookingId']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (_, __) => const ProfileScreen(),
          ),
          // Phase 2 — shop, cart, orders, notifications (inside shell for bottom nav)
          GoRoute(
            path: AppRoutes.shop,
            builder: (_, __) => const ShopScreen(),
            routes: [
              GoRoute(
                path: ':productId',
                builder: (_, state) => ProductDetailScreen(
                  productId: int.parse(state.pathParameters['productId']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.orders,
            builder: (_, __) => const OrdersScreen(),
            routes: [
              GoRoute(
                path: ':orderId',
                builder: (_, state) => OrderDetailScreen(
                  orderId: int.parse(state.pathParameters['orderId']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.notifications,
            builder: (_, __) => const NotificationsInboxScreen(),
          ),
          // Phase 3 — inside customer shell
          GoRoute(
            path: AppRoutes.recurring,
            builder: (_, __) => const RecurringListScreen(),
          ),
          GoRoute(
            path: AppRoutes.profileLoyalty,
            builder: (_, __) => const LoyaltyScreen(),
          ),
          GoRoute(
            path: AppRoutes.profileMemberships,
            builder: (_, __) => const MembershipsScreen(),
          ),
          GoRoute(
            path: AppRoutes.profileReferrals,
            builder: (_, __) => const ReferralsScreen(),
          ),
        ],
      ),

      // Phase 2 — full-screen routes (no bottom nav)
      GoRoute(
        path: AppRoutes.cart,
        builder: (_, __) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (_, __) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (_, __) => const WalletScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (_, __) => const NotificationSettingsScreen(),
      ),

      // Phase 3 — full-screen routes (no bottom nav)
      GoRoute(
        path: AppRoutes.recurringNew,
        builder: (_, __) => const RecurringFormScreen(),
      ),
      GoRoute(
        path: '/tracking/:bookingId',
        builder: (_, state) => TrackingScreen(
          bookingId: int.parse(state.pathParameters['bookingId']!),
        ),
      ),

      // Phase 4 — QR deep link
      GoRoute(
        path: '/qr/:bookingId',
        redirect: (_, state) {
          // QR check-in: redirect to booking detail for now
          final id = state.pathParameters['bookingId']!;
          return '/bookings/$id';
        },
      ),

      // Booking flow — modal / full-screen (outside shell so no bottom nav)
      GoRoute(
        path: AppRoutes.slotPicker,
        builder: (_, state) {
          final serviceId = int.parse(state.uri.queryParameters['serviceId']!);
          return SlotPickerScreen(serviceId: serviceId);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingLocation,
        builder: (_, state) {
          final serviceId = int.parse(state.uri.queryParameters['serviceId']!);
          final slotId = int.parse(state.uri.queryParameters['slotId']!);
          return BookingLocationScreen(serviceId: serviceId, slotId: slotId);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingConfirm,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BookingConfirmScreen(params: extra);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingSuccess,
        builder: (_, state) {
          final bookingId = int.parse(
            state.uri.queryParameters['bookingId'] ?? '0',
          );
          return BookingSuccessScreen(bookingId: bookingId);
        },
      ),

      // Staff shell (Phase 3 — full implementation)
      ShellRoute(
        builder: (_, __, child) => StaffShellScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.staffJobs,
            builder: (_, __) => const StaffJobsScreen(),
            routes: [
              GoRoute(
                path: ':bookingId',
                builder: (_, state) => StaffJobDetailScreen(
                  bookingId: int.parse(state.pathParameters['bookingId']!),
                ),
              ),
            ],
          ),
        ],
      ),
    ],

    errorBuilder: (_, state) => _ErrorRoute(state.error),
  );
}

// ---------------------------------------------------------------------------
// Auth redirect guard
// ---------------------------------------------------------------------------
String? _redirect(GoRouterState state, SessionState session) {
  final loc = state.matchedLocation;
  final isAuthRoute = loc == AppRoutes.login ||
      loc == AppRoutes.otp ||
      loc == AppRoutes.onboarding ||
      loc == AppRoutes.splash;

  return session.when(
    loading: () => null, // let splash handle it
    unauthenticated: () {
      if (loc == AppRoutes.splash) return AppRoutes.onboarding;
      return isAuthRoute ? null : AppRoutes.onboarding;
    },
    authenticated: (user, _, __) {
      if (loc == AppRoutes.splash || isAuthRoute) {
        return user.role == UserRole.staff
            ? AppRoutes.staffJobs
            : AppRoutes.home;
      }
      // Staff trying to access customer routes
      if (user.role == UserRole.staff && !loc.startsWith('/staff')) {
        return AppRoutes.staffJobs;
      }
      // Customer trying to access staff routes
      if (user.role == UserRole.customer && loc.startsWith('/staff')) {
        return AppRoutes.home;
      }
      return null;
    },
  );
}

// ---------------------------------------------------------------------------
// Listenable that triggers router rebuild when session changes
// ---------------------------------------------------------------------------
class _SessionListenable extends ChangeNotifier {
  _SessionListenable(Ref ref) {
    ref.listen<SessionState>(sessionStateProvider, (_, __) {
      notifyListeners();
    });
  }
}

// ---------------------------------------------------------------------------
// Splash screen — just shows a branded loader while session resolves
// ---------------------------------------------------------------------------
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              'Sridhar Carwash',
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error fallback
// ---------------------------------------------------------------------------
class _ErrorRoute extends StatelessWidget {
  const _ErrorRoute(this.error);
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Navigation error: $error')),
    );
  }
}

// Staff screens are imported from features/staff/ (Phase 3)
