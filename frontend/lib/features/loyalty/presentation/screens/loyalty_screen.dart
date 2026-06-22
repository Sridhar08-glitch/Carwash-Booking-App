import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/states.dart';
import '../../data/loyalty_dto.dart';
import '../../data/loyalty_repository.dart';

class LoyaltyScreen extends ConsumerWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(loyaltyStatusProvider);
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty & Rewards')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(loyaltyStatusProvider),
        ),
        data: (status) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(loyaltyStatusProvider),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // Tier card
              _TierCard(status: status),
              const SizedBox(height: AppSpacing.lg),

              // Progress to next tier
              if (status.nextTier != null && status.washesToNext != null) ...[
                Text('Progress to ${status.nextTier!.name}',
                    style: tt.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                _ProgressBar(
                  current: status.washesCount,
                  target: status.nextTier!.minWashes,
                  remaining: status.washesToNext!,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Stats row
              Row(
                children: [
                  _StatCard(
                    icon: Icons.local_car_wash,
                    label: 'Total washes',
                    value: '${status.washesCount}',
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _StatCard(
                    icon: Icons.stars_rounded,
                    label: 'Points',
                    value: '${status.points}',
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

class _TierCard extends StatelessWidget {
  const _TierCard({required this.status});
  final LoyaltyStatusDto status;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final tier = status.currentTier;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.brandGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Tier',
            style: tt.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.workspace_premium,
                  color: Colors.white, size: 36),
              const SizedBox(width: AppSpacing.sm),
              Text(
                tier?.name ?? 'Bronze',
                style: tt.displaySmall
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          if (tier != null)
            Text(
              '${tier.discountPercent}% discount on every wash',
              style: tt.bodyMedium?.copyWith(color: Colors.white70),
            ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.current,
    required this.target,
    required this.remaining,
  });
  final int current;
  final int target;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final pct = (current / target).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 12,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(cs.primary),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$remaining more wash${remaining == 1 ? '' : 'es'} to go',
          style: tt.bodySmall,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: cs.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(value, style: tt.headlineSmall),
            Text(label,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
