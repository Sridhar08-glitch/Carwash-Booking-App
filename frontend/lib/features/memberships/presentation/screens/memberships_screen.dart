import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../../data/memberships_dto.dart';
import '../../data/memberships_repository.dart';

class MembershipsScreen extends ConsumerWidget {
  const MembershipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(membershipPlansProvider);
    final myAsync = ref.watch(myMembershipProvider);
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Memberships')),
      body: plansAsync.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (plans) => ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Current membership banner
            myAsync.whenData((my) {
              if (my == null) return const SizedBox.shrink();
              return _CurrentMembershipCard(membership: my, ref: ref);
            }).valueOrNull ?? const SizedBox.shrink(),
            const SizedBox(height: AppSpacing.md),

            Text('Available Plans', style: tt.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            ...plans.map((plan) => _PlanCard(
                  plan: plan,
                  isActive: myAsync.valueOrNull?.plan.id == plan.id,
                  onSubscribe: myAsync.valueOrNull != null
                      ? null
                      : () async {
                          try {
                            await ref
                                .read(membershipsRepositoryProvider)
                                .subscribe(plan.id);
                            ref.invalidate(myMembershipProvider);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Membership activated!')),
                            );
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                )),
          ],
        ),
      ),
    );
  }
}

class _CurrentMembershipCard extends StatelessWidget {
  const _CurrentMembershipCard(
      {required this.membership, required this.ref});
  final MyMembershipDto membership;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final used = membership.washesUsed;
    final total = membership.plan.washesPerPeriod;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.brandGradient),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Membership',
              style: tt.labelMedium?.copyWith(color: Colors.white70)),
          const SizedBox(height: 4),
          Text(membership.plan.name,
              style: tt.titleLarge?.copyWith(color: Colors.white)),
          const SizedBox(height: AppSpacing.sm),
          Text('$used / $total washes used',
              style: tt.bodySmall?.copyWith(color: Colors.white70)),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: total > 0 ? used / total : 0,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              minHeight: 6,
            ),
          ),
          if (!membership.cancelAtPeriodEnd)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await ref.read(membershipsRepositoryProvider).cancel();
                  ref.invalidate(myMembershipProvider);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.white70)),
              ),
            ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isActive,
    required this.onSubscribe,
  });
  final MembershipPlanDto plan;
  final bool isActive;
  final VoidCallback? onSubscribe;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: isActive
            ? Border.all(color: cs.primary, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(plan.name, style: tt.titleMedium),
              ),
              if (isActive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Active',
                      style: tt.labelSmall
                          ?.copyWith(color: cs.onPrimaryContainer)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(plan.description, style: tt.bodySmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${plan.washesPerPeriod} washes / ${plan.billingPeriod}',
            style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          ...plan.features.map((f) => Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                  Text(f, style: tt.bodySmall),
                ],
              )),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceText(
                  amount: plan.price,
                  currency: plan.currency,
                  style: tt.titleMedium),
              if (!isActive && onSubscribe != null)
                FilledButton(
                  onPressed: onSubscribe,
                  child: const Text('Subscribe'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
