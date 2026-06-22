import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/booking_flow_controller.dart';
import '../../data/booking_dto.dart';
import '../../data/booking_repository.dart';

class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(bookingDetailProvider(bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Detail')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (booking) => _DetailView(
          booking: booking,
          onCancelled: () {
            ref.invalidate(bookingHistoryControllerProvider);
            context.go(AppRoutes.bookingHistory);
          },
          ref: ref,
        ),
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({
    required this.booking,
    required this.onCancelled,
    required this.ref,
  });

  final BookingDto booking;
  final VoidCallback onCancelled;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _statusColor(booking.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Icon(
                  _statusIcon(booking.status),
                  color: _statusColor(booking.status),
                ),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _statusLabel(booking.status),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: _statusColor(booking.status),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Booking #${booking.id}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _statusColor(booking.status),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Details
          Text('Details', style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.sm),

          _DetailRow(icon: Icons.local_car_wash_outlined,
              label: 'Service', value: booking.serviceName ?? '—'),
          _DetailRow(icon: Icons.calendar_today_outlined,
              label: 'Date', value: booking.slot.date),
          _DetailRow(icon: Icons.schedule_outlined,
              label: 'Time', value: _formatTime(booking.slot.startTime)),
          _DetailRow(icon: Icons.location_on_outlined,
              label: 'Location',
              value: booking.locationType == 'branch'
                  ? booking.branchName ?? 'Branch'
                  : 'Mobile / At Home'),
          if (booking.vehiclePlate != null)
            _DetailRow(icon: Icons.directions_car_outlined,
                label: 'Vehicle', value: booking.vehiclePlate!),

          const SizedBox(height: AppSpacing.lg),

          // Payment
          Text('Payment', style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: AppSpacing.sm),

          _DetailRow(icon: Icons.payment_outlined,
              label: 'Method', value: booking.payment.method),
          _DetailRow(icon: Icons.info_outlined,
              label: 'Payment Status', value: booking.payment.status),

          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  )),
              PriceText(
                amount: booking.priceCharged,
                currency: booking.currency,
                fontSize: 20,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // Actions
          if (booking.canCancel)
            SecondaryButton(
              label: 'Cancel Booking',
              onPressed: () => _confirmCancel(context),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel booking?'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(bookingRepositoryProvider)
          .cancelBooking(booking.id, idempotencyKey: const Uuid().v4());
      onCancelled();
    }
  }

  Color _statusColor(String s) => switch (s) {
        'confirmed' || 'assigned' => AppColors.primary,
        'en_route' || 'in_progress' => AppColors.warning,
        'completed' => AppColors.success,
        'cancelled' || 'no_show' => AppColors.error,
        _ => AppColors.onSurfaceVariant,
      };

  IconData _statusIcon(String s) => switch (s) {
        'completed' => Icons.check_circle_rounded,
        'cancelled' || 'no_show' => Icons.cancel_rounded,
        'en_route' => Icons.directions_car_rounded,
        'in_progress' => Icons.local_car_wash_rounded,
        _ => Icons.schedule_rounded,
      };

  String _statusLabel(String s) => switch (s) {
        'pending' => 'Pending',
        'confirmed' => 'Confirmed',
        'assigned' => 'Assigned',
        'en_route' => 'Washer En Route',
        'in_progress' => 'In Progress',
        'completed' => 'Completed',
        'cancelled' => 'Cancelled',
        'no_show' => 'No Show',
        _ => s,
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Text(label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              )),
          const Spacer(),
          Text(value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
