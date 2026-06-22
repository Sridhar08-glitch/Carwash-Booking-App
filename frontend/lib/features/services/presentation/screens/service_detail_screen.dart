import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/services_controller.dart';
import '../../data/services_dto.dart';

class ServiceDetailScreen extends ConsumerWidget {
  const ServiceDetailScreen({super.key, required this.serviceId});
  final int serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(serviceDetailProvider(serviceId));

    return async.when(
      loading: () => const Scaffold(body: LoadingState()),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(message: e.toString()),
      ),
      data: (service) => _ServiceDetailView(service: service),
    );
  }
}

class _ServiceDetailView extends StatelessWidget {
  const _ServiceDetailView({required this.service});
  final ServiceDto service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero app bar with image
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: service.image != null
                  ? NetworkImageBox(
                      url: service.image,
                      width: double.infinity,
                      height: 260,
                    )
                  : Container(
                      color: AppColors.primary,
                      child: const Center(
                        child: Icon(
                          Icons.local_car_wash,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverList.list(
              children: [
                // Name + price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        service.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    PriceText(
                      amount: service.basePrice,
                      currency: service.currency,
                      fontSize: 22,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // Meta row
                Wrap(
                  spacing: AppSpacing.md,
                  children: [
                    _MetaChip(
                      icon: Icons.schedule_outlined,
                      label: '${service.durationMinutes} min',
                    ),
                    if (service.category != null)
                      _MetaChip(
                        icon: Icons.category_outlined,
                        label: service.category!.name,
                      ),
                    if (service.isMobileAvailable)
                      _MetaChip(
                        icon: Icons.home_outlined,
                        label: 'Mobile available',
                        color: theme.colorScheme.primary,
                      ),
                  ],
                ),

                if (service.description.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'About this service',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    service.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ],

                // Tags
                if (service.tags.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Includes',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: service.tags
                        .map((t) => Chip(
                              label: Text(t),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ],

                // Spacer for sticky button
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),

      // Sticky Book bar — price shown again for clarity
      bottomNavigationBar: _StickyBookBar(service: service),
    );
  }
}

class _StickyBookBar extends StatelessWidget {
  const _StickyBookBar({required this.service});
  final ServiceDto service;

  @override
  Widget build(BuildContext context) {
    return StickyBottomBar(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Starting from',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              PriceText(
                amount: service.basePrice,
                currency: service.currency,
                fontSize: 20,
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: PrimaryButton(
              label: 'Book Now',
              onPressed: () => context.push(
                '${AppRoutes.slotPicker}?serviceId=${service.id}',
              ),
              icon: const Icon(Icons.calendar_today_outlined, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label, this.color});
  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: c),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: c),
        ),
      ],
    );
  }
}
