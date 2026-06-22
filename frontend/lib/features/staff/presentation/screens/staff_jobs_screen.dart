import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/states.dart';
import '../../data/staff_dto.dart';
import '../controllers/staff_controller.dart';

class StaffJobsScreen extends ConsumerWidget {
  const StaffJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(staffJobsControllerProvider);
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('My Jobs')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (jobs) => jobs.isEmpty
            ? const EmptyState(
                icon: Icons.work_outline,
                title: 'No jobs assigned',
                subtitle: 'Check back later for new assignments.',
              )
            : RefreshIndicator(
                onRefresh: () =>
                    ref.read(staffJobsControllerProvider.notifier).refresh(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: jobs.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, i) => _JobCard(job: jobs[i]),
                ),
              ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});
  final StaffJobListItemDto job;

  Color _statusColor(BuildContext context, String status) {
    final cs = Theme.of(context).colorScheme;
    return switch (status) {
      'pending' => Colors.orange,
      'accepted' => cs.primary,
      'en_route' => Colors.blue,
      'in_progress' => Colors.deepPurple,
      'completed' => Colors.green,
      _ => cs.outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final date = DateTime.tryParse(job.scheduledAt);
    final dateStr = date != null
        ? DateFormat('d MMM, HH:mm').format(date)
        : job.scheduledAt;

    return GestureDetector(
      onTap: () => context.push('/staff/jobs/${job.bookingId}'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: _statusColor(context, job.status),
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.customerName, style: tt.titleSmall),
                  const SizedBox(height: 2),
                  Text(job.serviceName, style: tt.bodySmall),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        job.locationType == 'mobile'
                            ? Icons.directions_car
                            : Icons.store_outlined,
                        size: 14,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(dateStr, style: tt.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _statusColor(context, job.status)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.status.replaceAll('_', ' '),
                    style: tt.labelSmall?.copyWith(
                      color: _statusColor(context, job.status),
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
