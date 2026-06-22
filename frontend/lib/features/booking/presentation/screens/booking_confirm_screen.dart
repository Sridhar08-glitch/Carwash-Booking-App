import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/price_text.dart';
import '../controllers/booking_flow_controller.dart';

class BookingConfirmScreen extends ConsumerWidget {
  const BookingConfirmScreen({super.key, required this.params});
  final Map<String, dynamic> params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingFlowControllerProvider);
    final notifier = ref.read(bookingFlowControllerProvider.notifier);
    final theme = Theme.of(context);

    // Show failure snackbar
    ref.listen<BookingFlowState>(bookingFlowControllerProvider, (_, next) {
      if (next.failure != null) {
        final msg = next.failure!.maybeWhen(
          slotUnavailable: (m) => m,
          conflict: (m) => m,
          network: (m) => m,
          orElse: () => 'Booking failed. Please try again.',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.error),
        );
        notifier.clearFailure();
      } else if (next.result != null) {
        context.pushReplacement(
          '${AppRoutes.bookingSuccess}?bookingId=${next.result!.id}',
        );
      }
    });

    final slot = state.selectedSlot;
    final service = state.service;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Column(
                children: [
                  _ConfirmRow(
                    icon: Icons.local_car_wash,
                    label: 'Service',
                    value: service?.name ?? '—',
                  ),
                  const Divider(height: 1),
                  _ConfirmRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: state.selectedDate ?? '—',
                  ),
                  const Divider(height: 1),
                  _ConfirmRow(
                    icon: Icons.schedule_outlined,
                    label: 'Time',
                    value: slot != null
                        ? _formatTime(slot.startTime)
                        : '—',
                  ),
                  const Divider(height: 1),
                  _ConfirmRow(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: state.locationType == 'branch'
                        ? state.selectedBranch?.name ?? 'Branch'
                        : 'Mobile / At Home',
                  ),
                  const Divider(height: 1),
                  _ConfirmRow(
                    icon: Icons.payment_outlined,
                    label: 'Payment',
                    value: 'Cash on service',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Price display — from service base_price (server is truth)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.05),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Final price confirmed at booking',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (service != null)
                    PriceText(
                      amount: service.basePrice,
                      currency: service.currency,
                      fontSize: 20,
                    ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Info note
            Text(
              'The exact price is confirmed when your booking is created. '
              'You will pay in cash when the service is complete.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: StickyBottomBar(
        child: PrimaryButton(
          label: 'Confirm Booking',
          isLoading: state.isSubmitting,
          onPressed: state.isSubmitting
              ? null
              : () => notifier.submitBooking(),
        ),
      ),
    );
  }

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

class _ConfirmRow extends StatelessWidget {
  const _ConfirmRow({
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.md),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
