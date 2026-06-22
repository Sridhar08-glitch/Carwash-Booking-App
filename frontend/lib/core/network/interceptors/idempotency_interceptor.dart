import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

/// Automatically injects an `Idempotency-Key` header on designated mutating
/// endpoints that must be protected from duplicate execution.
///
/// Usage: annotate the RequestOptions.extra with `{'idempotent': true}` or
/// rely on the path-based auto-inject below.
///
/// The UUID is generated per logical action by the caller and stored in
/// `extra['idempotencyKey']`. On retry (same request object), the same
/// UUID is reused — guaranteeing the server de-duplicates it.
class IdempotencyInterceptor extends Interceptor {
  static const _uuid = Uuid();

  /// Paths that ALWAYS get an idempotency key (matches prefix).
  static const _idempotentPaths = [
    '/bookings',
    '/orders/checkout',
    '/payments/intent',
    '/memberships/subscribe',
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method.toUpperCase();
    if (method != 'POST' && method != 'PUT' && method != 'PATCH') {
      handler.next(options);
      return;
    }

    final shouldInject =
        options.extra['idempotent'] == true ||
        _idempotentPaths.any((p) => options.path.startsWith(p));

    if (!shouldInject) {
      handler.next(options);
      return;
    }

    // Reuse existing key (for retries), or generate a fresh one
    final key = options.extra['idempotencyKey'] as String? ?? _uuid.v4();
    options.extra['idempotencyKey'] = key;
    options.headers['Idempotency-Key'] = key;

    handler.next(options);
  }
}

// ---------------------------------------------------------------------------
// Extension for callers to attach a pre-generated key
// (e.g. kept in the notifier state across retries)
// ---------------------------------------------------------------------------

extension IdempotencyOptionsX on Options {
  Options withIdempotencyKey(String key) {
    final extras = Map<String, dynamic>.from(extra ?? {});
    extras['idempotencyKey'] = key;
    extras['idempotent'] = true;
    return copyWith(extra: extras);
  }
}
