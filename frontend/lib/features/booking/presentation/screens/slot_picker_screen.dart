import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/shimmer_box.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/booking_flow_controller.dart';
import '../../data/booking_dto.dart';

class SlotPickerScreen extends ConsumerStatefulWidget {
  const SlotPickerScreen({super.key, required this.serviceId});
  final int serviceId;

  @override
  ConsumerState<SlotPickerScreen> createState() => _SlotPickerScreenState();
}

class _SlotPickerScreenState extends ConsumerState<SlotPickerScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingFlowControllerProvider.notifier)
        ..loadService(widget.serviceId)
        ..fetchSlots(_formatDate(_selectedDate));
    });
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _changeDate(int days) {
    final newDate = _selectedDate.add(Duration(days: days));
    if (newDate.isBefore(DateTime.now())) return;
    setState(() => _selectedDate = newDate);
    ref
        .read(bookingFlowControllerProvider.notifier)
        .fetchSlots(_formatDate(newDate));
  }

  void _proceed() {
    final state = ref.read(bookingFlowControllerProvider);
    if (state.selectedSlot == null) return;
    context.push(
      '${AppRoutes.bookingLocation}'
      '?serviceId=${widget.serviceId}'
      '&slotId=${state.selectedSlot!.id}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingFlowControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pick a Time'),
            if (state.service != null)
              Text(
                state.service!.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Date picker bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _changeDate(-1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 60)),
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                          ref
                              .read(bookingFlowControllerProvider.notifier)
                              .fetchSlots(_formatDate(picked));
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            _formatDate(_selectedDate),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            _weekdayName(_selectedDate.weekday),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _changeDate(1),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Slot grid
          Expanded(
            child: state.isLoadingSlots
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 2.2,
                      children: List.generate(
                        12,
                        (_) => const ShimmerBox(width: null, height: 44),
                      ),
                    ),
                  )
                : state.failure != null
                    ? ErrorState(
                        message: 'Could not load slots. Please try again.',
                        onRetry: () => ref
                            .read(bookingFlowControllerProvider.notifier)
                            .fetchSlots(_formatDate(_selectedDate)),
                      )
                    : state.availableSlots.isEmpty
                        ? const EmptyState(
                            title: 'No slots available',
                            subtitle: 'Try a different date.',
                            icon: Icons.calendar_today_outlined,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: AppSpacing.sm,
                              crossAxisSpacing: AppSpacing.sm,
                              childAspectRatio: 2.2,
                              children: state.availableSlots
                                  .map((slot) => _SlotChip(
                                        slot: slot,
                                        isSelected:
                                            state.selectedSlot?.id == slot.id,
                                        onTap: slot.isAvailable
                                            ? () => ref
                                                .read(bookingFlowControllerProvider
                                                    .notifier)
                                                .selectSlot(slot)
                                            : null,
                                      ))
                                  .toList(),
                            ),
                          ),
          ),
        ],
      ),
      bottomNavigationBar: StickyBottomBar(
        child: PrimaryButton(
          label: 'Continue',
          onPressed: state.selectedSlot != null ? _proceed : null,
        ),
      ),
    );
  }

  String _weekdayName(int w) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
    ];
    return days[(w - 1) % 7];
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  final SlotDto slot;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final available = slot.isAvailable;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : available
                  ? theme.colorScheme.surface
                  : theme.colorScheme.surfaceContainerHighest,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : available
                    ? theme.colorScheme.outline
                    : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // Format "09:00:00" → "9:00 AM"
                _formatTime(slot.startTime),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : available
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!available)
                Text(
                  'Full',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.error,
                    fontSize: 9,
                  ),
                )
              else if (slot.capacityLeft <= 2)
                Text(
                  '${slot.capacityLeft} left',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.warning,
                    fontSize: 9,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String time) {
    // "09:00:00" → "9:00 AM"
    final parts = time.split(':');
    if (parts.length < 2) return time;
    var hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final suffix = hour >= 12 ? 'PM' : 'AM';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $suffix';
  }
}
