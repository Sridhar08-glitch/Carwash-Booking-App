import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/widgets/states.dart';
import '../../data/notifications_dto.dart';
import '../../data/notifications_repository.dart';

part 'notification_settings_screen.g.dart';

@riverpod
Future<NotificationSettingsDto> notificationSettings(
        NotificationSettingsRef ref) =>
    ref.watch(notificationsRepositoryProvider).getSettings();

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (settings) => _SettingsList(settings: settings),
      ),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.settings});
  final NotificationSettingsDto settings;

  Future<void> _update(
      WidgetRef ref, NotificationSettingsDto updated) async {
    try {
      await ref
          .read(notificationsRepositoryProvider)
          .updateSettings(updated);
      ref.invalidate(notificationSettingsProvider);
    } catch (e) {
      // silently ignore; UI will revert on next build
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Booking updates'),
          subtitle: const Text('Reminders, confirmations, cancellations'),
          value: settings.bookingUpdates,
          onChanged: (v) =>
              _update(ref, settings.copyWith(bookingUpdates: v)),
        ),
        const Divider(height: 1),
        SwitchListTile(
          title: const Text('Order updates'),
          subtitle: const Text('Dispatch, delivery, returns'),
          value: settings.orderUpdates,
          onChanged: (v) =>
              _update(ref, settings.copyWith(orderUpdates: v)),
        ),
        const Divider(height: 1),
        SwitchListTile(
          title: const Text('Promotions & offers'),
          subtitle: const Text('Deals, discounts, promo codes'),
          value: settings.promotions,
          onChanged: (v) =>
              _update(ref, settings.copyWith(promotions: v)),
        ),
        const Divider(height: 1),
        SwitchListTile(
          title: const Text('Loyalty & rewards'),
          subtitle: const Text('Points earned, tier upgrades'),
          value: settings.loyalty,
          onChanged: (v) => _update(ref, settings.copyWith(loyalty: v)),
        ),
      ],
    );
  }
}
