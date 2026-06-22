import 'dart:io';
import 'package:dio/dio.dart';

import 'failures.dart';

/// Maps any thrown object (DioException, SocketException, etc.) to a [Failure].
/// Call this in repository catch blocks — never let raw exceptions reach the UI.
class ErrorMapper {
  const ErrorMapper._();

  static Failure map(Object error) {
    if (error is DioException) return _fromDio(error);
    if (error is SocketException) return const Failure.network();
    if (error is Failure) return error; // already mapped upstream
    return Failure.unknown(message: error.toString());
  }

  static Failure _fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.timeout();

      case DioExceptionType.connectionError:
        return const Failure.network();

      case DioExceptionType.badResponse:
        return _fromResponse(e.response);

      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Request cancelled.');

      default:
        return const Failure.unknown();
    }
  }

  static Failure _fromResponse(Response? response) {
    if (response == null) return const Failure.server();

    final statusCode = response.statusCode ?? 0;
    final body = response.data;

    // Parse error envelope: { code, message, field_errors }
    final code = _str(body, 'code');
    final message = _str(body, 'message');
    final rawFields = body is Map ? body['field_errors'] : null;
    final fieldErrors = _parseFieldErrors(rawFields);

    switch (statusCode) {
      case 400:
        return Failure.validation(
          message: message.isNotEmpty ? message : 'Validation failed.',
          fieldErrors: fieldErrors,
        );

      case 401:
        return Failure.unauthorized(
          message: message.isNotEmpty ? message : 'Session expired.',
        );

      case 403:
        return Failure.forbidden(
          message: message.isNotEmpty ? message : 'Access denied.',
        );

      case 404:
        return Failure.notFound(
          message: message.isNotEmpty ? message : 'Not found.',
        );

      case 409:
        // Check specific conflict reasons
        if (code == 'SLOT_UNAVAILABLE') {
          return const Failure.slotUnavailable();
        }
        if (code == 'WALLET_LOW') {
          return const Failure.insufficientWalletBalance();
        }
        return Failure.conflict(
          message: message.isNotEmpty ? message : 'Conflict.',
        );

      case 429:
        final wait = body is Map ? body['wait'] as int? : null;
        return Failure.rateLimited(waitSeconds: wait);

      case >= 500:
        return Failure.server(
          message: message.isNotEmpty ? message : 'Server error.',
        );

      default:
        return Failure.unknown(
          message: message.isNotEmpty ? message : 'Unexpected error ($statusCode).',
        );
    }
  }

  static String _str(dynamic body, String key) {
    if (body is Map && body[key] is String) return body[key] as String;
    return '';
  }

  static Map<String, List<String>> _parseFieldErrors(dynamic raw) {
    if (raw == null || raw is! Map) return {};
    return {
      for (final entry in raw.entries)
        entry.key.toString(): switch (entry.value) {
          List l => l.map((e) => e.toString()).toList(),
          String s => [s],
          _ => [],
        },
    };
  }
}
