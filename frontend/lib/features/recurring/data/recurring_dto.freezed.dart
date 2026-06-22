// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecurringRuleDto _$RecurringRuleDtoFromJson(Map<String, dynamic> json) {
  return _RecurringRuleDto.fromJson(json);
}

/// @nodoc
mixin _$RecurringRuleDto {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  int get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  int? get branchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String? get branchName => throw _privateConstructorUsedError;

  /// e.g. "weekly", "biweekly", "monthly"
  String get frequency => throw _privateConstructorUsedError;

  /// day-of-week 0=Mon…6=Sun for weekly/biweekly; day-of-month 1..28 for monthly
  @JsonKey(name: 'day_value')
  int get dayValue => throw _privateConstructorUsedError;

  /// "HH:mm" preferred start time
  @JsonKey(name: 'preferred_time')
  String get preferredTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_booking_date')
  String? get nextBookingDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecurringRuleDtoCopyWith<RecurringRuleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringRuleDtoCopyWith<$Res> {
  factory $RecurringRuleDtoCopyWith(
          RecurringRuleDto value, $Res Function(RecurringRuleDto) then) =
      _$RecurringRuleDtoCopyWithImpl<$Res, RecurringRuleDto>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'branch_id') int? branchId,
      @JsonKey(name: 'branch_name') String? branchName,
      String frequency,
      @JsonKey(name: 'day_value') int dayValue,
      @JsonKey(name: 'preferred_time') String preferredTime,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'next_booking_date') String? nextBookingDate});
}

/// @nodoc
class _$RecurringRuleDtoCopyWithImpl<$Res, $Val extends RecurringRuleDto>
    implements $RecurringRuleDtoCopyWith<$Res> {
  _$RecurringRuleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? serviceName = null,
    Object? branchId = freezed,
    Object? branchName = freezed,
    Object? frequency = null,
    Object? dayValue = null,
    Object? preferredTime = null,
    Object? locationType = null,
    Object? isActive = null,
    Object? nextBookingDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      dayValue: null == dayValue
          ? _value.dayValue
          : dayValue // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTime: null == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      nextBookingDate: freezed == nextBookingDate
          ? _value.nextBookingDate
          : nextBookingDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringRuleDtoImplCopyWith<$Res>
    implements $RecurringRuleDtoCopyWith<$Res> {
  factory _$$RecurringRuleDtoImplCopyWith(_$RecurringRuleDtoImpl value,
          $Res Function(_$RecurringRuleDtoImpl) then) =
      __$$RecurringRuleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'branch_id') int? branchId,
      @JsonKey(name: 'branch_name') String? branchName,
      String frequency,
      @JsonKey(name: 'day_value') int dayValue,
      @JsonKey(name: 'preferred_time') String preferredTime,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'next_booking_date') String? nextBookingDate});
}

/// @nodoc
class __$$RecurringRuleDtoImplCopyWithImpl<$Res>
    extends _$RecurringRuleDtoCopyWithImpl<$Res, _$RecurringRuleDtoImpl>
    implements _$$RecurringRuleDtoImplCopyWith<$Res> {
  __$$RecurringRuleDtoImplCopyWithImpl(_$RecurringRuleDtoImpl _value,
      $Res Function(_$RecurringRuleDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? serviceName = null,
    Object? branchId = freezed,
    Object? branchName = freezed,
    Object? frequency = null,
    Object? dayValue = null,
    Object? preferredTime = null,
    Object? locationType = null,
    Object? isActive = null,
    Object? nextBookingDate = freezed,
  }) {
    return _then(_$RecurringRuleDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      dayValue: null == dayValue
          ? _value.dayValue
          : dayValue // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTime: null == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      nextBookingDate: freezed == nextBookingDate
          ? _value.nextBookingDate
          : nextBookingDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurringRuleDtoImpl implements _RecurringRuleDto {
  const _$RecurringRuleDtoImpl(
      {required this.id,
      @JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'service_name') required this.serviceName,
      @JsonKey(name: 'branch_id') this.branchId,
      @JsonKey(name: 'branch_name') this.branchName,
      required this.frequency,
      @JsonKey(name: 'day_value') required this.dayValue,
      @JsonKey(name: 'preferred_time') required this.preferredTime,
      @JsonKey(name: 'location_type') required this.locationType,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'next_booking_date') this.nextBookingDate});

  factory _$RecurringRuleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurringRuleDtoImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'service_id')
  final int serviceId;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  @JsonKey(name: 'branch_id')
  final int? branchId;
  @override
  @JsonKey(name: 'branch_name')
  final String? branchName;

  /// e.g. "weekly", "biweekly", "monthly"
  @override
  final String frequency;

  /// day-of-week 0=Mon…6=Sun for weekly/biweekly; day-of-month 1..28 for monthly
  @override
  @JsonKey(name: 'day_value')
  final int dayValue;

  /// "HH:mm" preferred start time
  @override
  @JsonKey(name: 'preferred_time')
  final String preferredTime;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'next_booking_date')
  final String? nextBookingDate;

  @override
  String toString() {
    return 'RecurringRuleDto(id: $id, serviceId: $serviceId, serviceName: $serviceName, branchId: $branchId, branchName: $branchName, frequency: $frequency, dayValue: $dayValue, preferredTime: $preferredTime, locationType: $locationType, isActive: $isActive, nextBookingDate: $nextBookingDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringRuleDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.dayValue, dayValue) ||
                other.dayValue == dayValue) &&
            (identical(other.preferredTime, preferredTime) ||
                other.preferredTime == preferredTime) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.nextBookingDate, nextBookingDate) ||
                other.nextBookingDate == nextBookingDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      serviceId,
      serviceName,
      branchId,
      branchName,
      frequency,
      dayValue,
      preferredTime,
      locationType,
      isActive,
      nextBookingDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringRuleDtoImplCopyWith<_$RecurringRuleDtoImpl> get copyWith =>
      __$$RecurringRuleDtoImplCopyWithImpl<_$RecurringRuleDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurringRuleDtoImplToJson(
      this,
    );
  }
}

abstract class _RecurringRuleDto implements RecurringRuleDto {
  const factory _RecurringRuleDto(
          {required final int id,
          @JsonKey(name: 'service_id') required final int serviceId,
          @JsonKey(name: 'service_name') required final String serviceName,
          @JsonKey(name: 'branch_id') final int? branchId,
          @JsonKey(name: 'branch_name') final String? branchName,
          required final String frequency,
          @JsonKey(name: 'day_value') required final int dayValue,
          @JsonKey(name: 'preferred_time') required final String preferredTime,
          @JsonKey(name: 'location_type') required final String locationType,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'next_booking_date') final String? nextBookingDate}) =
      _$RecurringRuleDtoImpl;

  factory _RecurringRuleDto.fromJson(Map<String, dynamic> json) =
      _$RecurringRuleDtoImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'service_id')
  int get serviceId;
  @override
  @JsonKey(name: 'service_name')
  String get serviceName;
  @override
  @JsonKey(name: 'branch_id')
  int? get branchId;
  @override
  @JsonKey(name: 'branch_name')
  String? get branchName;
  @override

  /// e.g. "weekly", "biweekly", "monthly"
  String get frequency;
  @override

  /// day-of-week 0=Mon…6=Sun for weekly/biweekly; day-of-month 1..28 for monthly
  @JsonKey(name: 'day_value')
  int get dayValue;
  @override

  /// "HH:mm" preferred start time
  @JsonKey(name: 'preferred_time')
  String get preferredTime;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'next_booking_date')
  String? get nextBookingDate;
  @override
  @JsonKey(ignore: true)
  _$$RecurringRuleDtoImplCopyWith<_$RecurringRuleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateRecurringDto _$CreateRecurringDtoFromJson(Map<String, dynamic> json) {
  return _CreateRecurringDto.fromJson(json);
}

/// @nodoc
mixin _$CreateRecurringDto {
  @JsonKey(name: 'service_id')
  int get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  int? get branchId => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_value')
  int get dayValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_time')
  String get preferredTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateRecurringDtoCopyWith<CreateRecurringDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRecurringDtoCopyWith<$Res> {
  factory $CreateRecurringDtoCopyWith(
          CreateRecurringDto value, $Res Function(CreateRecurringDto) then) =
      _$CreateRecurringDtoCopyWithImpl<$Res, CreateRecurringDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'branch_id') int? branchId,
      String frequency,
      @JsonKey(name: 'day_value') int dayValue,
      @JsonKey(name: 'preferred_time') String preferredTime,
      @JsonKey(name: 'location_type') String locationType});
}

/// @nodoc
class _$CreateRecurringDtoCopyWithImpl<$Res, $Val extends CreateRecurringDto>
    implements $CreateRecurringDtoCopyWith<$Res> {
  _$CreateRecurringDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? branchId = freezed,
    Object? frequency = null,
    Object? dayValue = null,
    Object? preferredTime = null,
    Object? locationType = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      dayValue: null == dayValue
          ? _value.dayValue
          : dayValue // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTime: null == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateRecurringDtoImplCopyWith<$Res>
    implements $CreateRecurringDtoCopyWith<$Res> {
  factory _$$CreateRecurringDtoImplCopyWith(_$CreateRecurringDtoImpl value,
          $Res Function(_$CreateRecurringDtoImpl) then) =
      __$$CreateRecurringDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'branch_id') int? branchId,
      String frequency,
      @JsonKey(name: 'day_value') int dayValue,
      @JsonKey(name: 'preferred_time') String preferredTime,
      @JsonKey(name: 'location_type') String locationType});
}

/// @nodoc
class __$$CreateRecurringDtoImplCopyWithImpl<$Res>
    extends _$CreateRecurringDtoCopyWithImpl<$Res, _$CreateRecurringDtoImpl>
    implements _$$CreateRecurringDtoImplCopyWith<$Res> {
  __$$CreateRecurringDtoImplCopyWithImpl(_$CreateRecurringDtoImpl _value,
      $Res Function(_$CreateRecurringDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? branchId = freezed,
    Object? frequency = null,
    Object? dayValue = null,
    Object? preferredTime = null,
    Object? locationType = null,
  }) {
    return _then(_$CreateRecurringDtoImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      dayValue: null == dayValue
          ? _value.dayValue
          : dayValue // ignore: cast_nullable_to_non_nullable
              as int,
      preferredTime: null == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateRecurringDtoImpl implements _CreateRecurringDto {
  const _$CreateRecurringDtoImpl(
      {@JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'branch_id') this.branchId,
      required this.frequency,
      @JsonKey(name: 'day_value') required this.dayValue,
      @JsonKey(name: 'preferred_time') required this.preferredTime,
      @JsonKey(name: 'location_type') required this.locationType});

  factory _$CreateRecurringDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateRecurringDtoImplFromJson(json);

  @override
  @JsonKey(name: 'service_id')
  final int serviceId;
  @override
  @JsonKey(name: 'branch_id')
  final int? branchId;
  @override
  final String frequency;
  @override
  @JsonKey(name: 'day_value')
  final int dayValue;
  @override
  @JsonKey(name: 'preferred_time')
  final String preferredTime;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;

  @override
  String toString() {
    return 'CreateRecurringDto(serviceId: $serviceId, branchId: $branchId, frequency: $frequency, dayValue: $dayValue, preferredTime: $preferredTime, locationType: $locationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRecurringDtoImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.dayValue, dayValue) ||
                other.dayValue == dayValue) &&
            (identical(other.preferredTime, preferredTime) ||
                other.preferredTime == preferredTime) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, branchId, frequency,
      dayValue, preferredTime, locationType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRecurringDtoImplCopyWith<_$CreateRecurringDtoImpl> get copyWith =>
      __$$CreateRecurringDtoImplCopyWithImpl<_$CreateRecurringDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateRecurringDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateRecurringDto implements CreateRecurringDto {
  const factory _CreateRecurringDto(
          {@JsonKey(name: 'service_id') required final int serviceId,
          @JsonKey(name: 'branch_id') final int? branchId,
          required final String frequency,
          @JsonKey(name: 'day_value') required final int dayValue,
          @JsonKey(name: 'preferred_time') required final String preferredTime,
          @JsonKey(name: 'location_type') required final String locationType}) =
      _$CreateRecurringDtoImpl;

  factory _CreateRecurringDto.fromJson(Map<String, dynamic> json) =
      _$CreateRecurringDtoImpl.fromJson;

  @override
  @JsonKey(name: 'service_id')
  int get serviceId;
  @override
  @JsonKey(name: 'branch_id')
  int? get branchId;
  @override
  String get frequency;
  @override
  @JsonKey(name: 'day_value')
  int get dayValue;
  @override
  @JsonKey(name: 'preferred_time')
  String get preferredTime;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(ignore: true)
  _$$CreateRecurringDtoImplCopyWith<_$CreateRecurringDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
