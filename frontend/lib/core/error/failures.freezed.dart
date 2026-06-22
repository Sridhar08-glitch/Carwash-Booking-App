// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl(
      {this.message = 'Network error. Check your connection.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure({final String message}) = _$NetworkFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$TimeoutFailureImplCopyWith(_$TimeoutFailureImpl value,
          $Res Function(_$TimeoutFailureImpl) then) =
      __$$TimeoutFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TimeoutFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeoutFailureImpl>
    implements _$$TimeoutFailureImplCopyWith<$Res> {
  __$$TimeoutFailureImplCopyWithImpl(
      _$TimeoutFailureImpl _value, $Res Function(_$TimeoutFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TimeoutFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl(
      {this.message = 'The request timed out. Please try again.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.timeout(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      __$$TimeoutFailureImplCopyWithImpl<_$TimeoutFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return timeout(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return timeout?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutFailure implements Failure {
  const factory TimeoutFailure({final String message}) = _$TimeoutFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnauthorizedFailureImplCopyWith(_$UnauthorizedFailureImpl value,
          $Res Function(_$UnauthorizedFailureImpl) then) =
      __$$UnauthorizedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnauthorizedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnauthorizedFailureImpl>
    implements _$$UnauthorizedFailureImplCopyWith<$Res> {
  __$$UnauthorizedFailureImplCopyWithImpl(_$UnauthorizedFailureImpl _value,
      $Res Function(_$UnauthorizedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnauthorizedFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnauthorizedFailureImpl implements UnauthorizedFailure {
  const _$UnauthorizedFailureImpl(
      {this.message = 'Your session has expired. Please log in again.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      __$$UnauthorizedFailureImplCopyWithImpl<_$UnauthorizedFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedFailure implements Failure {
  const factory UnauthorizedFailure({final String message}) =
      _$UnauthorizedFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForbiddenFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ForbiddenFailureImplCopyWith(_$ForbiddenFailureImpl value,
          $Res Function(_$ForbiddenFailureImpl) then) =
      __$$ForbiddenFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ForbiddenFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ForbiddenFailureImpl>
    implements _$$ForbiddenFailureImplCopyWith<$Res> {
  __$$ForbiddenFailureImplCopyWithImpl(_$ForbiddenFailureImpl _value,
      $Res Function(_$ForbiddenFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ForbiddenFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ForbiddenFailureImpl implements ForbiddenFailure {
  const _$ForbiddenFailureImpl(
      {this.message = 'You don\'t have permission to do this.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.forbidden(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForbiddenFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      __$$ForbiddenFailureImplCopyWithImpl<_$ForbiddenFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return forbidden(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return forbidden?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class ForbiddenFailure implements Failure {
  const factory ForbiddenFailure({final String message}) =
      _$ForbiddenFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(_$NotFoundFailureImpl value,
          $Res Function(_$NotFoundFailureImpl) then) =
      __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
      _$NotFoundFailureImpl _value, $Res Function(_$NotFoundFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NotFoundFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NotFoundFailureImpl implements NotFoundFailure {
  const _$NotFoundFailureImpl(
      {this.message = 'The requested resource was not found.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure implements Failure {
  const factory NotFoundFailure({final String message}) = _$NotFoundFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConflictFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ConflictFailureImplCopyWith(_$ConflictFailureImpl value,
          $Res Function(_$ConflictFailureImpl) then) =
      __$$ConflictFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ConflictFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConflictFailureImpl>
    implements _$$ConflictFailureImplCopyWith<$Res> {
  __$$ConflictFailureImplCopyWithImpl(
      _$ConflictFailureImpl _value, $Res Function(_$ConflictFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ConflictFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConflictFailureImpl implements ConflictFailure {
  const _$ConflictFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.conflict(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictFailureImplCopyWith<_$ConflictFailureImpl> get copyWith =>
      __$$ConflictFailureImplCopyWithImpl<_$ConflictFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return conflict(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return conflict?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return conflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return conflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(this);
    }
    return orElse();
  }
}

abstract class ConflictFailure implements Failure {
  const factory ConflictFailure({required final String message}) =
      _$ConflictFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ConflictFailureImplCopyWith<_$ConflictFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(_$ValidationFailureImpl value,
          $Res Function(_$ValidationFailureImpl) then) =
      __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, List<String>> fieldErrors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(_$ValidationFailureImpl _value,
      $Res Function(_$ValidationFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fieldErrors = null,
  }) {
    return _then(_$ValidationFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      fieldErrors: null == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl(
      {required this.message,
      final Map<String, List<String>> fieldErrors = const {}})
      : _fieldErrors = fieldErrors;

  @override
  final String message;
  final Map<String, List<String>> _fieldErrors;
  @override
  @JsonKey()
  Map<String, List<String>> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldErrors);
  }

  @override
  String toString() {
    return 'Failure.validation(message: $message, fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_fieldErrors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return validation(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return validation?.call(message, fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, fieldErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure(
      {required final String message,
      final Map<String, List<String>> fieldErrors}) = _$ValidationFailureImpl;

  @override
  String get message;
  Map<String, List<String>> get fieldErrors;
  @override
  @JsonKey(ignore: true)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RateLimitedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$RateLimitedFailureImplCopyWith(_$RateLimitedFailureImpl value,
          $Res Function(_$RateLimitedFailureImpl) then) =
      __$$RateLimitedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? waitSeconds});
}

/// @nodoc
class __$$RateLimitedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RateLimitedFailureImpl>
    implements _$$RateLimitedFailureImplCopyWith<$Res> {
  __$$RateLimitedFailureImplCopyWithImpl(_$RateLimitedFailureImpl _value,
      $Res Function(_$RateLimitedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? waitSeconds = freezed,
  }) {
    return _then(_$RateLimitedFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      waitSeconds: freezed == waitSeconds
          ? _value.waitSeconds
          : waitSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$RateLimitedFailureImpl implements RateLimitedFailure {
  const _$RateLimitedFailureImpl(
      {this.message = 'Too many requests. Please wait a moment.',
      this.waitSeconds});

  @override
  @JsonKey()
  final String message;
  @override
  final int? waitSeconds;

  @override
  String toString() {
    return 'Failure.rateLimited(message: $message, waitSeconds: $waitSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateLimitedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.waitSeconds, waitSeconds) ||
                other.waitSeconds == waitSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, waitSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateLimitedFailureImplCopyWith<_$RateLimitedFailureImpl> get copyWith =>
      __$$RateLimitedFailureImplCopyWithImpl<_$RateLimitedFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return rateLimited(message, waitSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return rateLimited?.call(message, waitSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited(message, waitSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return rateLimited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return rateLimited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited(this);
    }
    return orElse();
  }
}

abstract class RateLimitedFailure implements Failure {
  const factory RateLimitedFailure(
      {final String message,
      final int? waitSeconds}) = _$RateLimitedFailureImpl;

  @override
  String get message;
  int? get waitSeconds;
  @override
  @JsonKey(ignore: true)
  _$$RateLimitedFailureImplCopyWith<_$RateLimitedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
          _$ServerFailureImpl value, $Res Function(_$ServerFailureImpl) then) =
      __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
      _$ServerFailureImpl _value, $Res Function(_$ServerFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ServerFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl(
      {this.message = 'Something went wrong on our end. Please try again.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.server(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return server(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return server?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure({final String message}) = _$ServerFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SlotUnavailableFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$SlotUnavailableFailureImplCopyWith(
          _$SlotUnavailableFailureImpl value,
          $Res Function(_$SlotUnavailableFailureImpl) then) =
      __$$SlotUnavailableFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SlotUnavailableFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$SlotUnavailableFailureImpl>
    implements _$$SlotUnavailableFailureImplCopyWith<$Res> {
  __$$SlotUnavailableFailureImplCopyWithImpl(
      _$SlotUnavailableFailureImpl _value,
      $Res Function(_$SlotUnavailableFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SlotUnavailableFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SlotUnavailableFailureImpl implements SlotUnavailableFailure {
  const _$SlotUnavailableFailureImpl(
      {this.message = 'This time slot is no longer available.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.slotUnavailable(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotUnavailableFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotUnavailableFailureImplCopyWith<_$SlotUnavailableFailureImpl>
      get copyWith => __$$SlotUnavailableFailureImplCopyWithImpl<
          _$SlotUnavailableFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return slotUnavailable(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return slotUnavailable?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (slotUnavailable != null) {
      return slotUnavailable(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return slotUnavailable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return slotUnavailable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (slotUnavailable != null) {
      return slotUnavailable(this);
    }
    return orElse();
  }
}

abstract class SlotUnavailableFailure implements Failure {
  const factory SlotUnavailableFailure({final String message}) =
      _$SlotUnavailableFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$SlotUnavailableFailureImplCopyWith<_$SlotUnavailableFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsufficientWalletBalanceFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InsufficientWalletBalanceFailureImplCopyWith(
          _$InsufficientWalletBalanceFailureImpl value,
          $Res Function(_$InsufficientWalletBalanceFailureImpl) then) =
      __$$InsufficientWalletBalanceFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InsufficientWalletBalanceFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsufficientWalletBalanceFailureImpl>
    implements _$$InsufficientWalletBalanceFailureImplCopyWith<$Res> {
  __$$InsufficientWalletBalanceFailureImplCopyWithImpl(
      _$InsufficientWalletBalanceFailureImpl _value,
      $Res Function(_$InsufficientWalletBalanceFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$InsufficientWalletBalanceFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientWalletBalanceFailureImpl
    implements InsufficientWalletBalanceFailure {
  const _$InsufficientWalletBalanceFailureImpl(
      {this.message = 'Insufficient wallet balance.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.insufficientWalletBalance(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientWalletBalanceFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsufficientWalletBalanceFailureImplCopyWith<
          _$InsufficientWalletBalanceFailureImpl>
      get copyWith => __$$InsufficientWalletBalanceFailureImplCopyWithImpl<
          _$InsufficientWalletBalanceFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return insufficientWalletBalance(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return insufficientWalletBalance?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (insufficientWalletBalance != null) {
      return insufficientWalletBalance(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return insufficientWalletBalance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return insufficientWalletBalance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (insufficientWalletBalance != null) {
      return insufficientWalletBalance(this);
    }
    return orElse();
  }
}

abstract class InsufficientWalletBalanceFailure implements Failure {
  const factory InsufficientWalletBalanceFailure({final String message}) =
      _$InsufficientWalletBalanceFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$InsufficientWalletBalanceFailureImplCopyWith<
          _$InsufficientWalletBalanceFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnknownFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl({this.message = 'An unexpected error occurred.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure({final String message}) = _$UnknownFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfflineFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$OfflineFailureImplCopyWith(_$OfflineFailureImpl value,
          $Res Function(_$OfflineFailureImpl) then) =
      __$$OfflineFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$OfflineFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$OfflineFailureImpl>
    implements _$$OfflineFailureImplCopyWith<$Res> {
  __$$OfflineFailureImplCopyWithImpl(
      _$OfflineFailureImpl _value, $Res Function(_$OfflineFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$OfflineFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OfflineFailureImpl implements OfflineFailure {
  const _$OfflineFailureImpl({this.message = 'You appear to be offline.'});

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.offline(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineFailureImplCopyWith<_$OfflineFailureImpl> get copyWith =>
      __$$OfflineFailureImplCopyWithImpl<_$OfflineFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message) notFound,
    required TResult Function(String message) conflict,
    required TResult Function(
            String message, Map<String, List<String>> fieldErrors)
        validation,
    required TResult Function(String message, int? waitSeconds) rateLimited,
    required TResult Function(String message) server,
    required TResult Function(String message) slotUnavailable,
    required TResult Function(String message) insufficientWalletBalance,
    required TResult Function(String message) unknown,
    required TResult Function(String message) offline,
  }) {
    return offline(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? conflict,
    TResult? Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult? Function(String message, int? waitSeconds)? rateLimited,
    TResult? Function(String message)? server,
    TResult? Function(String message)? slotUnavailable,
    TResult? Function(String message)? insufficientWalletBalance,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? offline,
  }) {
    return offline?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message)? notFound,
    TResult Function(String message)? conflict,
    TResult Function(String message, Map<String, List<String>> fieldErrors)?
        validation,
    TResult Function(String message, int? waitSeconds)? rateLimited,
    TResult Function(String message)? server,
    TResult Function(String message)? slotUnavailable,
    TResult Function(String message)? insufficientWalletBalance,
    TResult Function(String message)? unknown,
    TResult Function(String message)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(RateLimitedFailure value) rateLimited,
    required TResult Function(ServerFailure value) server,
    required TResult Function(SlotUnavailableFailure value) slotUnavailable,
    required TResult Function(InsufficientWalletBalanceFailure value)
        insufficientWalletBalance,
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(OfflineFailure value) offline,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(RateLimitedFailure value)? rateLimited,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult? Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(OfflineFailure value)? offline,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(RateLimitedFailure value)? rateLimited,
    TResult Function(ServerFailure value)? server,
    TResult Function(SlotUnavailableFailure value)? slotUnavailable,
    TResult Function(InsufficientWalletBalanceFailure value)?
        insufficientWalletBalance,
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(OfflineFailure value)? offline,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class OfflineFailure implements Failure {
  const factory OfflineFailure({final String message}) = _$OfflineFailureImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$OfflineFailureImplCopyWith<_$OfflineFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
