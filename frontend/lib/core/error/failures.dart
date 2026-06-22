import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Sealed failure hierarchy. The UI maps these to user-visible messages via
/// [ErrorMapper]. Add new variants here as new failure modes are discovered.
@freezed
class Failure with _$Failure {
  // Network / transport
  const factory Failure.network({
    @Default('Network error. Check your connection.') String message,
  }) = NetworkFailure;

  const factory Failure.timeout({
    @Default('The request timed out. Please try again.') String message,
  }) = TimeoutFailure;

  // HTTP semantic failures
  const factory Failure.unauthorized({
    @Default('Your session has expired. Please log in again.') String message,
  }) = UnauthorizedFailure;

  const factory Failure.forbidden({
    @Default('You don\'t have permission to do this.') String message,
  }) = ForbiddenFailure;

  const factory Failure.notFound({
    @Default('The requested resource was not found.') String message,
  }) = NotFoundFailure;

  const factory Failure.conflict({
    required String message, // server supplies specific reason e.g. "slot full"
  }) = ConflictFailure;

  const factory Failure.validation({
    required String message,
    @Default({}) Map<String, List<String>> fieldErrors,
  }) = ValidationFailure;

  const factory Failure.rateLimited({
    @Default('Too many requests. Please wait a moment.') String message,
    int? waitSeconds,
  }) = RateLimitedFailure;

  const factory Failure.server({
    @Default('Something went wrong on our end. Please try again.') String message,
  }) = ServerFailure;

  // Business / domain
  const factory Failure.slotUnavailable({
    @Default('This time slot is no longer available.') String message,
  }) = SlotUnavailableFailure;

  const factory Failure.insufficientWalletBalance({
    @Default('Insufficient wallet balance.') String message,
  }) = InsufficientWalletBalanceFailure;

  const factory Failure.unknown({
    @Default('An unexpected error occurred.') String message,
  }) = UnknownFailure;

  const factory Failure.offline({
    @Default('You appear to be offline.') String message,
  }) = OfflineFailure;
}

/// Convenience typedef — a result is either data or a failure.
typedef Result<T> = ({T? data, Failure? failure});

extension ResultX<T> on Result<T> {
  bool get isSuccess => data != null && failure == null;
  bool get isFailure => failure != null;
}
