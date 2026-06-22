import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'notifications_dto.dart';

part 'notifications_repository.g.dart';

@riverpod
NotificationsRepository notificationsRepository(
        NotificationsRepositoryRef ref) =>
    NotificationsRepository(ref.watch(dioProvider));

class NotificationsRepository {
  NotificationsRepository(this._dio);
  final Dio _dio;

  Future<List<NotificationDto>> getNotifications(
      {bool unreadOnly = false}) async {
    try {
      // Backend responds with {"unread_count": n, "results": [...]} on
      // GET /notifications/ (trailing slash required — no redirect on POST).
      final r = await _dio.get<Map<String, dynamic>>(
        '/notifications/',
        queryParameters: unreadOnly ? {'unread': 1} : null,
      );
      final results = (r.data!['results'] as List<dynamic>? ?? const []);
      return results
          .map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  /// Unread badge count, served by the same endpoint.
  Future<int> getUnreadCount() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/notifications/');
      return (r.data!['unread_count'] as num?)?.toInt() ?? 0;
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> markRead(int id) async {
    try {
      await _dio.post<void>('/notifications/$id/read');
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dio.post<void>('/notifications/read-all');
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<NotificationSettingsDto> getSettings() async {
    try {
      final r =
          await _dio.get<Map<String, dynamic>>('/notifications/settings');
      return NotificationSettingsDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<NotificationSettingsDto> updateSettings(
      NotificationSettingsDto settings) async {
    try {
      final r = await _dio.patch<Map<String, dynamic>>(
        '/notifications/settings',
        data: settings.toJson(),
      );
      return NotificationSettingsDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> registerFcmToken(String token) async {
    try {
      await _dio.post<void>(
        '/notifications/fcm-token',
        data: {'fcm_token': token},
      );
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
