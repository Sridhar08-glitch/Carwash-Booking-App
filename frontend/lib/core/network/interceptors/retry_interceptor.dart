import 'package:dio/dio.dart';

/// Retries idempotent GETs — and safe, explicitly whitelisted POST/PATCH paths
/// — once on transient network failures (timeout, connection error).
///
/// SAFETY RULES
/// ------------
/// 1. GET is always retried (idempotent by definition).
/// 2. Mutation methods (POST / PUT / PATCH / DELETE) are NEVER retried unless
///    the request path is in [_safeToRetryPrefixes].  This whitelist approach
///    prevents a developer accidentally marking a dangerous mutation as
///    retryable via `extra['retryable'] = true`.
/// 3. Payment paths are always excluded — even if somehow whitelisted —
///    because the Stripe idempotency key handles de-dup at the server level
///    and we never want a silent retry that charges a customer twice.
///
/// For endpoints that ARE safe to retry on transient errors (e.g. cancel /
/// reschedule, which carry idempotency keys), add their path prefix to
/// [_safeToRetryPrefixes].
class RetryInterceptor extends Interceptor {
  RetryInterceptor({required this.dio});

  final Dio dio;

  static const _maxRetries = 1;

  static const _retryableErrorTypes = {
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
  };

  /// POST/PUT/PATCH paths that carry idempotency keys and are safe to retry.
  /// These are matched as path prefixes (startsWith).
  static const _safeToRetryPrefixes = [
    '/bookings',     // create, cancel, reschedule — all carry Idempotency-Key
    '/notifications', // FCM token register — idempotent upsert
    '/loyalty',       // referral submit — idempotent
  ];

  /// Paths that must NEVER be retried regardless of any other rule.
  static const _neverRetryPrefixes = [
    '/payments/',
    '/orders/checkout',
    '/memberships/subscribe',
  ];

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final opts = err.requestOptions;
    final retryCount = (opts.extra['retryCount'] as int?) ?? 0;

    if (_isRetryable(err, opts) && retryCount < _maxRetries) {
      opts.extra['retryCount'] = retryCount + 1;
      try {
        await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));
        final response = await dio.fetch(opts);
        handler.resolve(response);
        return;
      } catch (_) {
        // Fall through to handler.next if the retry also fails
      }
    }

    handler.next(err);
  }

  bool _isRetryable(DioException err, RequestOptions opts) {
    // Only retry on transient network errors, never on HTTP 4xx/5xx responses
    if (!_retryableErrorTypes.contains(err.type)) return false;

    final method = opts.method.toUpperCase();
    final path = opts.path;

    // Rule 1: never-retry list beats everything
    if (_neverRetryPrefixes.any((p) => path.startsWith(p))) return false;

    // Rule 2: GETs are always safe
    if (method == 'GET') return true;

    // Rule 3: mutations — only retry paths on the explicit whitelist
    // (they must carry an Idempotency-Key so the server de-duplicates)
    if (_safeToRetryPrefixes.any((p) => path.startsWith(p))) {
      // Double-check the request actually has an idempotency key
      return opts.headers.containsKey('Idempotency-Key');
    }

    // All other mutations: do not retry
    return false;
  }
}
