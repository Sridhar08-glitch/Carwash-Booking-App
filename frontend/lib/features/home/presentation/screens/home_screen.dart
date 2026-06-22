import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/providers/session_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../../../../core/widgets/states.dart';
import '../../data/home_dto.dart';
import '../controllers/home_controller.dart';
import '../../../services/data/services_dto.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final session = ref.watch(sessionStateProvider);
    final user = session.maybeWhen(
      authenticated: (u, _, __) => u,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sridhar Carwash'),
            if (user != null)
              Text(
                user.phone,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(homeControllerProvider.notifier).refresh(),
        child: state.isLoading
            ? const HomeSkeleton()
            : state.errorMessage != null
                ? ErrorState(
                    message: state.errorMessage!,
                    onRetry: () =>
                        ref.read(homeControllerProvider.notifier).refresh(),
                  )
                : _HomeContent(state: state),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Server-driven layout renderer
// ---------------------------------------------------------------------------
class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.state});
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: state.layout.length + 1, // +1 for quick actions always shown
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.lg),
      itemBuilder: (context, index) {
        // Always render quick actions at index 0
        if (index == 0) return const _QuickActionsSection();

        final section = state.layout[index - 1];
        return _renderSection(context, section, state);
      },
    );
  }

  Widget _renderSection(
    BuildContext context,
    HomeSectionDto section,
    HomeState state,
  ) {
    switch (section.type) {
      case 'hero_banner':
        if (section.banners.isNotEmpty) {
          return _HeroCarousel(banners: section.banners);
        }
        if (section.image != null || section.title != null) {
          return _SingleBannerCard(section: section);
        }
        return const SizedBox.shrink();

      case 'offer_strip':
        return _OfferStrip(section: section);

      case 'service_rail':
        return _ServiceRail(
          title: section.title ?? 'Our Services',
          services: state.services,
        );

      case 'product_rail':
        // Phase 2 — return stub for now
        return _SectionStub(title: section.title ?? 'Shop', type: section.type);

      case 'membership_upsell':
        return _SectionStub(title: 'Membership', type: section.type);

      case 'loyalty_progress':
        return _SectionStub(title: 'Your Loyalty', type: section.type);

      default:
        // Unknown section — skip (forward-compatible)
        return const SizedBox.shrink();
    }
  }
}

// ---------------------------------------------------------------------------
// Quick actions row — always shown regardless of server layout
// ---------------------------------------------------------------------------
class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _QuickAction(
            icon: Icons.local_car_wash,
            label: 'Book Wash',
            color: AppColors.primary,
            onTap: () => context.go(AppRoutes.services),
          ),
          const SizedBox(width: AppSpacing.sm),
          _QuickAction(
            icon: Icons.shopping_bag_outlined,
            label: 'Shop',
            color: AppColors.secondary,
            onTap: () {}, // Phase 2
          ),
          const SizedBox(width: AppSpacing.sm),
          _QuickAction(
            icon: Icons.calendar_month_outlined,
            label: 'My Bookings',
            color: AppColors.success,
            onTap: () => context.go(AppRoutes.bookingHistory),
          ),
          const SizedBox(width: AppSpacing.sm),
          _QuickAction(
            icon: Icons.location_on_outlined,
            label: 'Find Us',
            color: AppColors.promo,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero carousel — auto-advancing banners
// ---------------------------------------------------------------------------
class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel({required this.banners});
  final List<BannerDto> banners;

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  final _pageController = PageController();
  int _page = 0;
  bool _userScrolling = false;

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  void _startAutoAdvance() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted || _userScrolling) return true;
      final next = (_page + 1) % widget.banners.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      return mounted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: GestureDetector(
            onPanStart: (_) => _userScrolling = true,
            onPanEnd: (_) {
              _userScrolling = false;
              _startAutoAdvance();
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) => _BannerCard(banner: widget.banners[i]),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Page dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _page == i ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _page == i
                    ? AppColors.primary
                    : AppColors.outline,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner});
  final BannerDto banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Stack(
          children: [
            // Background image or gradient — fills the SizedBox bounds
            Positioned.fill(
              child: banner.image != null
                  ? NetworkImageBox(url: banner.image, fit: BoxFit.cover)
                  : Container(decoration: const BoxDecoration(gradient: AppColors.gradientPrimary)),
            ),

            // Gradient overlay for text legibility
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
            ),

            // Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      banner.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (banner.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        banner.subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                    if (banner.cta != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          banner.cta!,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.onSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Single banner card (non-carousel hero_banner with no banners list)
// ---------------------------------------------------------------------------
class _SingleBannerCard extends StatelessWidget {
  const _SingleBannerCard({required this.section});
  final HomeSectionDto section;

  @override
  Widget build(BuildContext context) {
    final banner = BannerDto(
      title: section.title ?? '',
      subtitle: section.text,
      cta: section.cta,
      image: section.image,
      deepLink: section.deepLink,
    );
    // SizedBox gives _BannerCard a bounded height so that Positioned.fill
    // children have a finite size to fill. ListView gives unbounded height,
    // so we constrain it here — same as _HeroCarousel's SizedBox(height: 200).
    return SizedBox(
      height: 200,
      child: _BannerCard(banner: banner),
    );
  }
}

// ---------------------------------------------------------------------------
// Offer strip — horizontal scroller of text promo chips
// ---------------------------------------------------------------------------
class _OfferStrip extends StatelessWidget {
  const _OfferStrip({required this.section});
  final HomeSectionDto section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.promoLight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_rounded, color: AppColors.promo, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              section.text ?? section.title ?? '',
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.promo,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Service rail
// ---------------------------------------------------------------------------
class _ServiceRail extends StatelessWidget {
  const _ServiceRail({required this.title, required this.services});
  final String title;
  final List<ServiceDto> services;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.services),
                child: const Text('See all'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: services.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (_, i) => _ServiceRailCard(service: services[i]),
          ),
        ),
      ],
    );
  }
}

class _ServiceRailCard extends StatelessWidget {
  const _ServiceRailCard({required this.service});
  final ServiceDto service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.push(AppRoutes.serviceDetailPath(service.id)),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.md),
              ),
              child: NetworkImageBox(
                url: service.image,
                width: 150,
                height: 90,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: theme.textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  PriceText(
                    amount: service.basePrice,
                    currency: service.currency,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stub for sections not yet built
// ---------------------------------------------------------------------------
class _SectionStub extends StatelessWidget {
  const _SectionStub({required this.title, required this.type});
  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Center(
          child: Text(
            '$title — coming soon',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ),
    );
  }
}
