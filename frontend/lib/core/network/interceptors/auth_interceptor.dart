import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/session_controller.dart';
import '../../auth/token_store.dart';

/// Attaches the JWT access token to every request.
/// On 401: calls /auth/refresh (single-flight — queues other requests),
/// updates tokens, retries original request once.
/// If refresh fails → logs out.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  // Single-flight refresh guard
  Completer<String>? _refreshCompleter;

  // ---------------------------------------------------------------------------
  // onRequest — attach Bearer token
  // ---------------------------------------------------------------------------

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final skipAuth = options.extra['skipAuth'] == true;
    if (!skipAuth) {
      final session = ref.read(sessionControllerProvider.notifier);
      final token = session.accessToken;
      // ignore: avoid_print
      print('[AuthInterceptor] ${options.method} ${options.path} | token=${token == null ? "NULL" : "${token.substring(0, 20)}..."}');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  // ---------------------------------------------------------------------------
  // onError — handle 401 with token refresh
  // ---------------------------------------------------------------------------

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // Avoid refreshing on the refresh call itself
    if (err.requestOptions.path.contains('/auth/refresh')) {
      await _logout();
      handler.next(err);
      return;
    }

    try {
      final newAccess = await _refresh();
      // Retry the original request with the new token.
      // skipAuth: true so onRequest doesn't overwrite the header we just set.
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $newAccess';
      opts.extra['skipAuth'] = true;
      // ignore: avoid_print
      print('[AuthInterceptor] RETRY ${opts.method} ${opts.path} | token=${newAccess.substring(0, 20)}...');
      final response = await dio.fetch(opts);
      handler.resolve(response);
    } catch (_) {
      await _logout();
      handler.next(err);
    }
  }

  // ---------------------------------------------------------------------------
  // Single-flight refresh
  // ---------------------------------------------------------------------------

  Future<String> _refresh() async {
    if (_refreshCompleter != null) {
      // Another request is already refreshing — wait for it
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String>();
    try {
      final store = ref.read(tokenStoreProvider);
      final refreshToken = await store.readRefresh();
      if (refreshToken == null) throw Exception('No refresh token');

      final response = await dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh': refreshToken},
        options: Options(extra: {'skipAuth': true}),
      );

      final data = response.data!;
      final newAccess = data['access'] as String;
      final newRefresh = (data['refresh'] as String?) ?? refreshToken;

      await ref
          .read(sessionControllerProvider.notifier)
          .updateAccessToken(newAccess, newRefresh);

      _refreshCompleter!.complete(newAccess);
      return newAccess;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<void> _logout() async {
    await ref.read(sessionControllerProvider.notifier).logout();
  }
}
