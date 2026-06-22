import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/services_controller.dart';
import '../../data/services_dto.dart';

class ServicesListScreen extends ConsumerWidget {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(servicesControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(servicesControllerProvider.notifier).refresh(),
        child: CustomScrollView(
          slivers: [
            // Category filter chips
            if (state.categories.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: state.categories.length + 1,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      if (i == 0) {
                        return FilterChip(
                          label: const Text('All'),
                          selected: state.selectedCategory == null,
                          onSelected: (_) => ref
                              .read(servicesControllerProvider.notifier)
                              .selectCategory(null),
                        );
                      }
                      final cat = state.categories[i - 1];
                      return FilterChip(
                        label: Text(cat.name),
                        selected: state.selectedCategory?.id == cat.id,
                        onSelected: (_) => ref
                            .read(servicesControllerProvider.notifier)
                            .selectCategory(cat),
                      );
                    },
                  ),
                ),
              ),

            // Service list
            if (state.isLoading)
              SliverList.builder(
                itemCount: 5,
                itemBuilder: (_, __) => const ShimmerListItem(),
              )
            else if (state.errorMessage != null)
              SliverFillRemaining(
                child: ErrorState(
                  message: state.errorMessage!,
                  onRetry: () => ref
                      .read(servicesControllerProvider.notifier)
                      .refresh(),
                ),
              )
            else if (state.services.isEmpty)
              const SliverFillRemaining(
                child: EmptyState(
                  title: 'No services found',
                  icon: Icons.local_car_wash_outlined,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList.separated(
                  itemCount: state.services.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) =>
                      _ServiceCard(service: state.services[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});
  final ServiceDto service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () =>
            context.push(AppRoutes.serviceDetailPath(service.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: NetworkImageBox(
                  url: service.image,
                  width: 80,
                  height: 80,
                  borderRadius: 8,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (service.category != null)
                      Text(
                        service.category!.name,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${service.durationMinutes} min',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (service.isMobileAvailable) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.home_outlined,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Mobile',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Price + arrow
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PriceText(
                    amount: service.basePrice,
                    currency: service.currency,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
