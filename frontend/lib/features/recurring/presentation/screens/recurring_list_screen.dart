import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/states.dart';
import '../../data/recurring_dto.dart';
import '../../data/recurring_repository.dart';

part 'recurring_list_screen.g.dart';

@riverpod
Future<List<RecurringRuleDto>> recurringRules(RecurringRulesRef ref) =>
    ref.watch(recurringRepositoryProvider).getRules();

class RecurringListScreen extends ConsumerWidget {
  const RecurringListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(recurringRulesProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Recurring Bookings')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (rules) => rules.isEmpty
            ? EmptyState(
                icon: Icons.repeat,
                title: 'No recurring bookings',
                subtitle: 'Set up automatic wash schedules below.',
                action: () => context.push('/recurring/new'),
                actionLabel: 'Add schedule',
              )
            : RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(recurringRulesProvider),
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: rules.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) => _RuleCard(
                    rule: rules[i],
                    onDelete: () async {
                      await ref
                          .read(recurringRepositoryProvider)
                          .deleteRule(rules[i].id);
                      ref.invalidate(recurringRulesProvider);
                    },
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/recurring/new'),
        icon: const Icon(Icons.add),
        label: const Text('New schedule'),
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({required this.rule, required this.onDelete});
  final RecurringRuleDto rule;
  final VoidCallback onDelete;

  String get _frequencyLabel => switch (rule.frequency) {
        'weekly' => 'Every week',
        'biweekly' => 'Every 2 weeks',
        'monthly' => 'Every month',
        _ => rule.frequency,
      };

  String get _dayLabel {
    if (rule.frequency == 'monthly') return 'Day ${rule.dayValue}';
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[rule.dayValue.clamp(0, 6)];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rule.isActive ? cs.primary : cs.outline,
          width: rule.isActive ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.repeat, color: cs.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rule.serviceName, style: tt.titleSmall),
                const SizedBox(height: 2),
                Text(
                  '$_frequencyLabel · $_dayLabel · ${rule.preferredTime}',
                  style: tt.bodySmall,
                ),
                if (rule.nextBookingDate != null)
                  Text(
                    'Next: ${rule.nextBookingDate}',
                    style: tt.labelSmall
                        ?.copyWith(color: cs.primary),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: cs.error,
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Remove schedule?'),
                content: const Text(
                    'This recurring booking will be cancelled.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
