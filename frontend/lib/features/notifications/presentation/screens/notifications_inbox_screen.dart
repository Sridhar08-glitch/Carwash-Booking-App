import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/states.dart';
import '../controllers/notifications_controller.dart';

class NotificationsInboxScreen extends ConsumerWidget {
  const NotificationsInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsControllerProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => ref
                .read(notificationsControllerProvider.notifier)
                .markAllRead(),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: async.when(
        loading: () => const LoadingState(),
        error: (e, _) => ErrorState(message: e.toString()),
        data: (state) => state.notifications.isEmpty
            ? const EmptyState(
                icon: Icons.notifications_none_outlined,
                title: 'No notifications',
                subtitle: 'You\'re all caught up!',
              )
            : RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(notificationsControllerProvider),
                child: ListView.separated(
                  itemCount: state.notifications.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final notif = state.notifications[i];
                    final date = DateTime.tryParse(notif.createdAt);
                    final dateStr = date != null
                        ? DateFormat('d MMM, HH:mm').format(date)
                        : notif.createdAt;

                    return ListTile(
                      tileColor: notif.read
                          ? null
                          : cs.primaryContainer.withOpacity(0.2),
                      leading: CircleAvatar(
                        backgroundColor:
                            cs.primaryContainer,
                        child: Icon(
                          _iconForType(notif.type),
                          color: cs.primary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        notif.title,
                        style: tt.bodyMedium?.copyWith(
                          fontWeight: notif.read ? null : FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notif.body, style: tt.bodySmall),
                          const SizedBox(height: 2),
                          Text(dateStr,
                              style: tt.labelSmall
                                  ?.copyWith(color: cs.outline)),
                        ],
                      ),
                      isThreeLine: true,
                      onTap: notif.read
                          ? null
                          : () => ref
                              .read(notificationsControllerProvider.notifier)
                              .markRead(notif.id),
                    );
                  },
                ),
              ),
      ),
    );
  }

  IconData _iconForType(String? type) => switch (type) {
        'booking' => Icons.calendar_today_outlined,
        'order' => Icons.shopping_bag_outlined,
        'promo' => Icons.local_offer_outlined,
        'loyalty' => Icons.star_outline,
        _ => Icons.notifications_outlined,
      };
}
