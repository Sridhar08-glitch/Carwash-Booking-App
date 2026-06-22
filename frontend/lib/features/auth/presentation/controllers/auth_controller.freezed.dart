// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthFormState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get otpAttemptsLeft => throw _privateConstructorUsedError;
  int get resendSecondsLeft => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get fieldError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthFormStateCopyWith<AuthFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFormStateCopyWith<$Res> {
  factory $AuthFormStateCopyWith(
          AuthFormState value, $Res Function(AuthFormState) then) =
      _$AuthFormStateCopyWithImpl<$Res, AuthFormState>;
  @useResult
  $Res call(
      {bool isLoading,
      String phone,
      String code,
      int otpAttemptsLeft,
      int resendSecondsLeft,
      Failure? failure,
      String? fieldError});

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$AuthFormStateCopyWithImpl<$Res, $Val extends AuthFormState>
    implements $AuthFormStateCopyWith<$Res> {
  _$AuthFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? phone = null,
    Object? code = null,
    Object? otpAttemptsLeft = null,
    Object? resendSecondsLeft = null,
    Object? failure = freezed,
    Object? fieldError = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      otpAttemptsLeft: null == otpAttemptsLeft
          ? _value.otpAttemptsLeft
          : otpAttemptsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      resendSecondsLeft: null == resendSecondsLeft
          ? _value.resendSecondsLeft
          : resendSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      fieldError: freezed == fieldError
          ? _value.fieldError
          : fieldError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthFormStateImplCopyWith<$Res>
    implements $AuthFormStateCopyWith<$Res> {
  factory _$$AuthFormStateImplCopyWith(
          _$AuthFormStateImpl value, $Res Function(_$AuthFormStateImpl) then) =
      __$$AuthFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String phone,
      String code,
      int otpAttemptsLeft,
      int resendSecondsLeft,
      Failure? failure,
      String? fieldError});

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$AuthFormStateImplCopyWithImpl<$Res>
    extends _$AuthFormStateCopyWithImpl<$Res, _$AuthFormStateImpl>
    implements _$$AuthFormStateImplCopyWith<$Res> {
  __$$AuthFormStateImplCopyWithImpl(
      _$AuthFormStateImpl _value, $Res Function(_$AuthFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? phone = null,
    Object? code = null,
    Object? otpAttemptsLeft = null,
    Object? resendSecondsLeft = null,
    Object? failure = freezed,
    Object? fieldError = freezed,
  }) {
    return _then(_$AuthFormStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      otpAttemptsLeft: null == otpAttemptsLeft
          ? _value.otpAttemptsLeft
          : otpAttemptsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      resendSecondsLeft: null == resendSecondsLeft
          ? _value.resendSecondsLeft
          : resendSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      fieldError: freezed == fieldError
          ? _value.fieldError
          : fieldError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthFormStateImpl implements _AuthFormState {
  const _$AuthFormStateImpl(
      {this.isLoading = false,
      this.phone = '',
      this.code = '',
      this.otpAttemptsLeft = 0,
      this.resendSecondsLeft = 0,
      this.failure,
      this.fieldError});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final int otpAttemptsLeft;
  @override
  @JsonKey()
  final int resendSecondsLeft;
  @override
  final Failure? failure;
  @override
  final String? fieldError;

  @override
  String toString() {
    return 'AuthFormState(isLoading: $isLoading, phone: $phone, code: $code, otpAttemptsLeft: $otpAttemptsLeft, resendSecondsLeft: $resendSecondsLeft, failure: $failure, fieldError: $fieldError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFormStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.otpAttemptsLeft, otpAttemptsLeft) ||
                other.otpAttemptsLeft == otpAttemptsLeft) &&
            (identical(other.resendSecondsLeft, resendSecondsLeft) ||
                other.resendSecondsLeft == resendSecondsLeft) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.fieldError, fieldError) ||
                other.fieldError == fieldError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, phone, code,
      otpAttemptsLeft, resendSecondsLeft, failure, fieldError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFormStateImplCopyWith<_$AuthFormStateImpl> get copyWith =>
      __$$AuthFormStateImplCopyWithImpl<_$AuthFormStateImpl>(this, _$identity);
}

abstract class _AuthFormState implements AuthFormState {
  const factory _AuthFormState(
      {final bool isLoading,
      final String phone,
      final String code,
      final int otpAttemptsLeft,
      final int resendSecondsLeft,
      final Failure? failure,
      final String? fieldError}) = _$AuthFormStateImpl;

  @override
  bool get isLoading;
  @override
  String get phone;
  @override
  String get code;
  @override
  int get otpAttemptsLeft;
  @override
  int get resendSecondsLeft;
  @override
  Failure? get failure;
  @override
  String? get fieldError;
  @override
  @JsonKey(ignore: true)
  _$$AuthFormStateImplCopyWith<_$AuthFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
