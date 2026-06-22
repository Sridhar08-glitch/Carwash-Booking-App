import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/notifications_dto.dart';
import '../../data/notifications_repository.dart';

part 'notifications_controller.freezed.dart';
part 'notifications_controller.g.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default([]) List<NotificationDto> notifications,
    @Default(0) int unreadCount,
    @Default(false) bool isLoading,
    String? error,
  }) = _NotificationsState;
}

@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  Future<NotificationsState> build() async {
    final notifications =
        await ref.watch(notificationsRepositoryProvider).getNotifications();
    final unread = notifications.where((n) => !n.read).length;
    return NotificationsState(
      notifications: notifications,
      unreadCount: unread,
    );
  }

  Future<void> markRead(int id) async {
    await ref.read(notificationsRepositoryProvider).markRead(id);
    ref.invalidateSelf();
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsRepositoryProvider).markAllRead();
    ref.invalidateSelf();
  }
}
