// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffJobState {
  StaffJobDto get job => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StaffJobStateCopyWith<StaffJobState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffJobStateCopyWith<$Res> {
  factory $StaffJobStateCopyWith(
          StaffJobState value, $Res Function(StaffJobState) then) =
      _$StaffJobStateCopyWithImpl<$Res, StaffJobState>;
  @useResult
  $Res call({StaffJobDto job, bool isUpdating, String? error});

  $StaffJobDtoCopyWith<$Res> get job;
}

/// @nodoc
class _$StaffJobStateCopyWithImpl<$Res, $Val extends StaffJobState>
    implements $StaffJobStateCopyWith<$Res> {
  _$StaffJobStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? isUpdating = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as StaffJobDto,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StaffJobDtoCopyWith<$Res> get job {
    return $StaffJobDtoCopyWith<$Res>(_value.job, (value) {
      return _then(_value.copyWith(job: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaffJobStateImplCopyWith<$Res>
    implements $StaffJobStateCopyWith<$Res> {
  factory _$$StaffJobStateImplCopyWith(
          _$StaffJobStateImpl value, $Res Function(_$StaffJobStateImpl) then) =
      __$$StaffJobStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StaffJobDto job, bool isUpdating, String? error});

  @override
  $StaffJobDtoCopyWith<$Res> get job;
}

/// @nodoc
class __$$StaffJobStateImplCopyWithImpl<$Res>
    extends _$StaffJobStateCopyWithImpl<$Res, _$StaffJobStateImpl>
    implements _$$StaffJobStateImplCopyWith<$Res> {
  __$$StaffJobStateImplCopyWithImpl(
      _$StaffJobStateImpl _value, $Res Function(_$StaffJobStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? isUpdating = null,
    Object? error = freezed,
  }) {
    return _then(_$StaffJobStateImpl(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as StaffJobDto,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StaffJobStateImpl implements _StaffJobState {
  const _$StaffJobStateImpl(
      {required this.job, this.isUpdating = false, this.error});

  @override
  final StaffJobDto job;
  @override
  @JsonKey()
  final bool isUpdating;
  @override
  final String? error;

  @override
  String toString() {
    return 'StaffJobState(job: $job, isUpdating: $isUpdating, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffJobStateImpl &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, job, isUpdating, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffJobStateImplCopyWith<_$StaffJobStateImpl> get copyWith =>
      __$$StaffJobStateImplCopyWithImpl<_$StaffJobStateImpl>(this, _$identity);
}

abstract class _StaffJobState implements StaffJobState {
  const factory _StaffJobState(
      {required final StaffJobDto job,
      final bool isUpdating,
      final String? error}) = _$StaffJobStateImpl;

  @override
  StaffJobDto get job;
  @override
  bool get isUpdating;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$StaffJobStateImplCopyWith<_$StaffJobStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
