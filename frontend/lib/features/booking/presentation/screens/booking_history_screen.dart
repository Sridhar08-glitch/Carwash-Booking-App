import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/booking_flow_controller.dart';
import '../../data/booking_dto.dart';
import '../../data/booking_repository.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(bookingHistoryControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(bookingHistoryControllerProvider.notifier).refresh(),
        child: async.when(
          loading: () => ListView.builder(
            itemCount: 5,
            itemBuilder: (_, __) => const ShimmerListItem(),
          ),
          error: (e, _) => ErrorState(
            message: e.toString(),
            onRetry: () =>
                ref.read(bookingHistoryControllerProvider.notifier).refresh(),
          ),
          data: (bookings) => bookings.isEmpty
              ? const EmptyState(
                  title: 'No bookings yet',
                  subtitle: 'Book your first car wash service.',
                  icon: Icons.calendar_today_outlined,
                )
              : _BookingList(bookings: bookings),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({required this.bookings});
  final List<BookingListItemDto> bookings;

  @override
  Widget build(BuildContext context) {
    // Separate into upcoming and past
    final now = DateTime.now();
    final upcoming = bookings
        .where((b) => _isUpcoming(b, now))
        .toList();
    final past = bookings
        .where((b) => !_isUpcoming(b, now))
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      children: [
        if (upcoming.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              'Upcoming',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          ...upcoming.map((b) => _BookingCard(booking: b)),
        ],
        if (past.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              'Past',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          ...past.map((b) => _BookingCard(booking: b)),
        ],
      ],
    );
  }

  bool _isUpcoming(BookingListItemDto b, DateTime now) {
    if (b.slotDate == null) return false;
    final d = DateTime.tryParse(b.slotDate!);
    if (d == null) return false;
    return d.isAfter(now) &&
        !['cancelled', 'completed', 'no_show'].contains(b.status);
  }
}

class _BookingCard extends ConsumerWidget {
  const _BookingCard({required this.booking});
  final BookingListItemDto booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statusColor = _statusColor(booking.status);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(AppRoutes.bookingDetailPath(booking.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      booking.serviceName ?? 'Car Wash',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      _statusLabel(booking.status),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  if (booking.slotDate != null) ...[
                    const Icon(Icons.calendar_today_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      booking.slotDate!,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  if (booking.slotStartTime != null) ...[
                    const Icon(Icons.schedule_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(booking.slotStartTime!),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    booking.locationType == 'mobile'
                        ? Icons.home_outlined
                        : Icons.store_outlined,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    booking.branchName ?? (booking.locationType == 'mobile' ? 'Mobile' : 'Branch'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  PriceText(
                    amount: booking.priceCharged,
                    currency: booking.currency,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),

              if (booking.canCancel) ...[
                const SizedBox(height: AppSpacing.sm),
                const Divider(height: 1),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => _confirmCancel(context, ref),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Cancel booking'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel booking?'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to cancel?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Cancel booking'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref
            .read(bookingRepositoryProvider)
            .cancelBooking(booking.id, idempotencyKey: const Uuid().v4());
        await ref
            .read(bookingHistoryControllerProvider.notifier)
            .refresh();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking cancelled.')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to cancel: $e')),
          );
        }
      }
    }
  }

  Color _statusColor(String status) => switch (status) {
        'confirmed' || 'assigned' => AppColors.primary,
        'en_route' || 'in_progress' => AppColors.warning,
        'completed' => AppColors.success,
        'cancelled' || 'no_show' => AppColors.error,
        _ => AppColors.onSurfaceVariant,
      };

  String _statusLabel(String status) => switch (status) {
        'pending' => 'Pending',
        'confirmed' => 'Confirmed',
        'assigned' => 'Assigned',
        'en_route' => 'En Route',
        'in_progress' => 'In Progress',
        'completed' => 'Completed',
        'cancelled' => 'Cancelled',
        'no_show' => 'No Show',
        _ => status,
      };

  String _formatTime(String t) {
    final parts = t.split(':');
    if (parts.length < 2) return t;
    var h = int.tryParse(parts[0]) ?? 0;
    final m = parts[1];
    final suf = h >= 12 ? 'PM' : 'AM';
    if (h > 12) h -= 12;
    if (h == 0) h = 12;
    return '$h:$m $suf';
  }
}
