import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../controllers/booking_flow_controller.dart';
import '../../data/booking_dto.dart';
import '../../../services/data/services_dto.dart';

class BookingLocationScreen extends ConsumerWidget {
  const BookingLocationScreen({
    super.key,
    required this.serviceId,
    required this.slotId,
  });

  final int serviceId;
  final int slotId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingFlowControllerProvider);
    final notifier = ref.read(bookingFlowControllerProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Location')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service type', style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            )),
            const SizedBox(height: AppSpacing.sm),

            // Branch vs Mobile
            _LocationTypeCard(
              title: 'Branch Visit',
              subtitle: 'Drop off your car at our branch',
              icon: Icons.store_outlined,
              isSelected: state.locationType == 'branch',
              onTap: () => notifier.setLocationType('branch'),
            ),
            const SizedBox(height: AppSpacing.sm),

            if (state.service?.isMobileAvailable == true)
              _LocationTypeCard(
                title: 'Mobile / At Home',
                subtitle: 'We come to you',
                icon: Icons.home_outlined,
                isSelected: state.locationType == 'mobile',
                onTap: () => notifier.setLocationType('mobile'),
              ),

            // Branch selection (if branch type)
            if (state.locationType == 'branch' && state.branches.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              Text('Select branch', style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              )),
              const SizedBox(height: AppSpacing.sm),
              ...state.branches.map((b) => _BranchCard(
                    branch: b,
                    isSelected: state.selectedBranch?.id == b.id,
                    onTap: () => notifier.selectBranch(b),
                  )),
            ],

            // Mobile location note
            if (state.locationType == 'mobile') ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'You\'ll confirm your address on the next screen.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: StickyBottomBar(
        child: PrimaryButton(
          label: 'Continue',
          onPressed: () {
            context.push(
              AppRoutes.bookingConfirm,
              extra: {
                'serviceId': serviceId,
                'slotId': slotId,
              },
            );
          },
        ),
      ),
    );
  }
}

class _LocationTypeCard extends StatelessWidget {
  const _LocationTypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.05)
              : theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                size: 22,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Text(subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded,
                  color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  const _BranchCard({
    required this.branch,
    required this.isSelected,
    required this.onTap,
  });

  final BranchDto branch;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(branch.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                    if (branch.city.isNotEmpty)
                      Text(branch.city,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          )),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded,
                    color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
