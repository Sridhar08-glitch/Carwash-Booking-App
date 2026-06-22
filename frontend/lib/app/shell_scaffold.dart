import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/router.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/offline_banner.dart';

// ---------------------------------------------------------------------------
// Customer shell — bottom navigation with 4 tabs
// ---------------------------------------------------------------------------
class CustomerShellScaffold extends StatelessWidget {
  const CustomerShellScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _indexFromLocation(location);

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx < 0 ? 0 : idx,
        onDestinationSelected: (i) => _onTap(context, i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_car_wash_outlined),
            selectedIcon: Icon(Icons.local_car_wash),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.services)) return 1;
    if (location.startsWith(AppRoutes.bookingHistory)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return -1;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.services);
      case 2:
        context.go(AppRoutes.bookingHistory);
      case 3:
        context.go(AppRoutes.profile);
    }
  }
}

// ---------------------------------------------------------------------------
// Staff shell — minimal for Phase 1; expanded in Phase 3
// ---------------------------------------------------------------------------
class StaffShellScaffold extends StatelessWidget {
  const StaffShellScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Jobs',
          ),
        ],
      ),
    );
  }
}
