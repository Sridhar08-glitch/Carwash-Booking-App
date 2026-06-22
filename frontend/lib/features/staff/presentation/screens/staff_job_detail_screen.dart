import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../../../core/widgets/states.dart';
import '../../data/staff_dto.dart';
import '../controllers/staff_controller.dart';

class StaffJobDetailScreen extends ConsumerWidget {
  const StaffJobDetailScreen({super.key, required this.bookingId});
  final int bookingId;

  static const _statusFlow = [
    'en_route',
    'in_progress',
    'completed',
  ];

  String? _nextStatus(String current) {
    final i = _statusFlow.indexOf(current);
    if (i == -1 || i == _statusFlow.length - 1) return null;
    return _statusFlow[i + 1];
  }

  String _nextStatusLabel(String next) => switch (next) {
        'en_route' => 'Start driving',
        'in_progress' => 'Start washing',
        'completed' => 'Mark complete',
        _ => next,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(staffJobControllerProvider(bookingId));
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Job Detail')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (jobState) {
          final job = jobState.job;
          final nextStatus = _nextStatus(job.status);

          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(staffJobControllerProvider(bookingId)),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                // Customer info card
                _InfoCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Row(label: 'Customer', value: job.customerName),
                      if (job.customerPhone != null)
                        _Row(label: 'Phone', value: job.customerPhone!),
                      _Row(label: 'Service', value: job.serviceName),
                      if (job.vehicleInfo != null)
                        _Row(label: 'Vehicle', value: job.vehicleInfo!),
                      _Row(
                        label: 'Location',
                        value: job.locationType == 'mobile'
                            ? (job.address ?? 'Mobile')
                            : (job.branchName ?? 'Branch'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Accept button if pending
                if (job.status == 'pending')
                  PrimaryButton(
                    label: 'Accept Job',
                    onPressed: jobState.isUpdating
                        ? null
                        : () => ref
                            .read(staffJobControllerProvider(bookingId)
                                .notifier)
                            .accept(),
                  ),

                // Advance status button
                if (nextStatus != null && job.status != 'pending')
                  PrimaryButton(
                    label: _nextStatusLabel(nextStatus),
                    onPressed: jobState.isUpdating
                        ? null
                        : () => ref
                            .read(staffJobControllerProvider(bookingId)
                                .notifier)
                            .updateStatus(nextStatus),
                  ),

                if (jobState.error != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: AppSpacing.sm),
                    child: Text(
                      jobState.error!,
                      style: tt.bodySmall?.copyWith(color: cs.error),
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),

                // Checklist
                if (job.tasks.isNotEmpty) ...[
                  Text('Checklist', style: tt.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ...job.tasks.map(
                    (task) => CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        task.label,
                        style: tt.bodyMedium?.copyWith(
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      value: task.completed,
                      onChanged: jobState.isUpdating ||
                              job.status == 'completed'
                          ? null
                          : (_) => ref
                              .read(staffJobControllerProvider(bookingId)
                                  .notifier)
                              .toggleTask(task.id),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Photos
                Text('Photos', style: tt.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                _PhotoSection(
                  label: 'Before',
                  photos: job.beforePhotos,
                  canAdd: job.status == 'accepted' ||
                      job.status == 'en_route',
                  onAdd: () => ref
                      .read(staffJobControllerProvider(bookingId).notifier)
                      .uploadPhoto('before'),
                ),
                const SizedBox(height: AppSpacing.sm),
                _PhotoSection(
                  label: 'After',
                  photos: job.afterPhotos,
                  canAdd: job.status == 'in_progress',
                  onAdd: () => ref
                      .read(staffJobControllerProvider(bookingId).notifier)
                      .uploadPhoto('after'),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: tt.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.outline)),
          ),
          Expanded(child: Text(value, style: tt.bodyMedium)),
        ],
      ),
    );
  }
}

class _PhotoSection extends StatelessWidget {
  const _PhotoSection({
    required this.label,
    required this.photos,
    required this.canAdd,
    required this.onAdd,
  });
  final String label;
  final List<String> photos;
  final bool canAdd;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: tt.titleSmall),
            const Spacer(),
            if (canAdd)
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.camera_alt_outlined, size: 18),
                label: const Text('Add'),
              ),
          ],
        ),
        if (photos.isEmpty)
          Text('No $label photos yet',
              style: tt.bodySmall?.copyWith(color: cs.outline))
        else
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: NetworkImageBox(
                    url: photos[i], height: 100, width: 100),
              ),
            ),
          ),
      ],
    );
  }
}
