import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../config/providers.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/idempotency_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

part 'dio_client.g.dart';

/// Base Dio instance wired with all interceptors.
/// Import [dioProvider] in repositories.
@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final config = ref.watch(appConfigProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  // Order matters: logging → auth → idempotency → retry
  dio.interceptors.addAll([
    LoggingInterceptor(),
    AuthInterceptor(ref: ref, dio: dio),
    IdempotencyInterceptor(),
    RetryInterceptor(dio: dio),
  ]);

  return dio;
}
