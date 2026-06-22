import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../data/recurring_dto.dart';
import '../../data/recurring_repository.dart';
import 'recurring_list_screen.dart';

class RecurringFormScreen extends ConsumerStatefulWidget {
  const RecurringFormScreen({super.key});

  @override
  ConsumerState<RecurringFormScreen> createState() =>
      _RecurringFormScreenState();
}

class _RecurringFormScreenState extends ConsumerState<RecurringFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _frequency = 'weekly';
  int _dayValue = 0; // Mon
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);
  String _locationType = 'branch';
  bool _isSubmitting = false;

  // For demo purposes — a real app would load services from the API
  final int _serviceId = 1;

  static const _weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    try {
      final dto = CreateRecurringDto(
        serviceId: _serviceId,
        frequency: _frequency,
        dayValue: _dayValue,
        preferredTime:
            '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
        locationType: _locationType,
      );
      await ref.read(recurringRepositoryProvider).createRule(dto);
      ref.invalidate(recurringRulesProvider);
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('New Recurring Schedule')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Frequency
            Text('Frequency', style: tt.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            ...['weekly', 'biweekly', 'monthly'].map(
              (f) => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(f[0].toUpperCase() + f.substring(1)),
                value: f,
                groupValue: _frequency,
                onChanged: (v) => setState(() => _frequency = v!),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Day selection
            Text(
              _frequency == 'monthly' ? 'Day of month' : 'Day of week',
              style: tt.titleSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            _frequency == 'monthly'
                ? DropdownButtonFormField<int>(
                    value: _dayValue.clamp(1, 28),
                    items: List.generate(
                      28,
                      (i) => DropdownMenuItem(
                          value: i + 1, child: Text('${i + 1}')),
                    ),
                    onChanged: (v) => setState(() => _dayValue = v!),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder()),
                  )
                : DropdownButtonFormField<int>(
                    value: _dayValue,
                    items: List.generate(
                      7,
                      (i) => DropdownMenuItem(
                          value: i, child: Text(_weekDays[i])),
                    ),
                    onChanged: (v) => setState(() => _dayValue = v!),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder()),
                  ),
            const SizedBox(height: AppSpacing.md),

            // Time
            Text('Preferred time', style: tt.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: Text(_time.format(context)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: _time,
                );
                if (picked != null) setState(() => _time = picked);
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // Location type
            Text('Location', style: tt.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            ...['branch', 'mobile'].map(
              (l) => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(l == 'branch' ? 'At branch' : 'Mobile (at home)'),
                value: l,
                groupValue: _locationType,
                onChanged: (v) => setState(() => _locationType = v!),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: StickyBottomBar(
        child: PrimaryButton(
          label: _isSubmitting ? 'Saving…' : 'Save Schedule',
          onPressed: _isSubmitting ? null : _submit,
        ),
      ),
    );
  }
}
