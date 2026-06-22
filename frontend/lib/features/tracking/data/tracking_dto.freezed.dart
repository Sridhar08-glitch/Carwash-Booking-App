// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingPingDto _$TrackingPingDtoFromJson(Map<String, dynamic> json) {
  return _TrackingPingDto.fromJson(json);
}

/// @nodoc
mixin _$TrackingPingDto {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  @JsonKey(name: 'eta_minutes')
  int? get etaMinutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingPingDtoCopyWith<TrackingPingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingPingDtoCopyWith<$Res> {
  factory $TrackingPingDtoCopyWith(
          TrackingPingDto value, $Res Function(TrackingPingDto) then) =
      _$TrackingPingDtoCopyWithImpl<$Res, TrackingPingDto>;
  @useResult
  $Res call(
      {double lat, double lng, @JsonKey(name: 'eta_minutes') int? etaMinutes});
}

/// @nodoc
class _$TrackingPingDtoCopyWithImpl<$Res, $Val extends TrackingPingDto>
    implements $TrackingPingDtoCopyWith<$Res> {
  _$TrackingPingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? etaMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      etaMinutes: freezed == etaMinutes
          ? _value.etaMinutes
          : etaMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingPingDtoImplCopyWith<$Res>
    implements $TrackingPingDtoCopyWith<$Res> {
  factory _$$TrackingPingDtoImplCopyWith(_$TrackingPingDtoImpl value,
          $Res Function(_$TrackingPingDtoImpl) then) =
      __$$TrackingPingDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double lat, double lng, @JsonKey(name: 'eta_minutes') int? etaMinutes});
}

/// @nodoc
class __$$TrackingPingDtoImplCopyWithImpl<$Res>
    extends _$TrackingPingDtoCopyWithImpl<$Res, _$TrackingPingDtoImpl>
    implements _$$TrackingPingDtoImplCopyWith<$Res> {
  __$$TrackingPingDtoImplCopyWithImpl(
      _$TrackingPingDtoImpl _value, $Res Function(_$TrackingPingDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? etaMinutes = freezed,
  }) {
    return _then(_$TrackingPingDtoImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      etaMinutes: freezed == etaMinutes
          ? _value.etaMinutes
          : etaMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingPingDtoImpl implements _TrackingPingDto {
  const _$TrackingPingDtoImpl(
      {required this.lat,
      required this.lng,
      @JsonKey(name: 'eta_minutes') this.etaMinutes});

  factory _$TrackingPingDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingPingDtoImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  @JsonKey(name: 'eta_minutes')
  final int? etaMinutes;

  @override
  String toString() {
    return 'TrackingPingDto(lat: $lat, lng: $lng, etaMinutes: $etaMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingPingDtoImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.etaMinutes, etaMinutes) ||
                other.etaMinutes == etaMinutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, etaMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingPingDtoImplCopyWith<_$TrackingPingDtoImpl> get copyWith =>
      __$$TrackingPingDtoImplCopyWithImpl<_$TrackingPingDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingPingDtoImplToJson(
      this,
    );
  }
}

abstract class _TrackingPingDto implements TrackingPingDto {
  const factory _TrackingPingDto(
          {required final double lat,
          required final double lng,
          @JsonKey(name: 'eta_minutes') final int? etaMinutes}) =
      _$TrackingPingDtoImpl;

  factory _TrackingPingDto.fromJson(Map<String, dynamic> json) =
      _$TrackingPingDtoImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(name: 'eta_minutes')
  int? get etaMinutes;
  @override
  @JsonKey(ignore: true)
  _$$TrackingPingDtoImplCopyWith<_$TrackingPingDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrackingStatusDto _$TrackingStatusDtoFromJson(Map<String, dynamic> json) {
  return _TrackingStatusDto.fromJson(json);
}

/// @nodoc
mixin _$TrackingStatusDto {
  @JsonKey(name: 'booking_status')
  String get bookingStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingStatusDtoCopyWith<TrackingStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingStatusDtoCopyWith<$Res> {
  factory $TrackingStatusDtoCopyWith(
          TrackingStatusDto value, $Res Function(TrackingStatusDto) then) =
      _$TrackingStatusDtoCopyWithImpl<$Res, TrackingStatusDto>;
  @useResult
  $Res call({@JsonKey(name: 'booking_status') String bookingStatus});
}

/// @nodoc
class _$TrackingStatusDtoCopyWithImpl<$Res, $Val extends TrackingStatusDto>
    implements $TrackingStatusDtoCopyWith<$Res> {
  _$TrackingStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingStatus = null,
  }) {
    return _then(_value.copyWith(
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingStatusDtoImplCopyWith<$Res>
    implements $TrackingStatusDtoCopyWith<$Res> {
  factory _$$TrackingStatusDtoImplCopyWith(_$TrackingStatusDtoImpl value,
          $Res Function(_$TrackingStatusDtoImpl) then) =
      __$$TrackingStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'booking_status') String bookingStatus});
}

/// @nodoc
class __$$TrackingStatusDtoImplCopyWithImpl<$Res>
    extends _$TrackingStatusDtoCopyWithImpl<$Res, _$TrackingStatusDtoImpl>
    implements _$$TrackingStatusDtoImplCopyWith<$Res> {
  __$$TrackingStatusDtoImplCopyWithImpl(_$TrackingStatusDtoImpl _value,
      $Res Function(_$TrackingStatusDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingStatus = null,
  }) {
    return _then(_$TrackingStatusDtoImpl(
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingStatusDtoImpl implements _TrackingStatusDto {
  const _$TrackingStatusDtoImpl(
      {@JsonKey(name: 'booking_status') required this.bookingStatus});

  factory _$TrackingStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingStatusDtoImplFromJson(json);

  @override
  @JsonKey(name: 'booking_status')
  final String bookingStatus;

  @override
  String toString() {
    return 'TrackingStatusDto(bookingStatus: $bookingStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingStatusDtoImpl &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bookingStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingStatusDtoImplCopyWith<_$TrackingStatusDtoImpl> get copyWith =>
      __$$TrackingStatusDtoImplCopyWithImpl<_$TrackingStatusDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingStatusDtoImplToJson(
      this,
    );
  }
}

abstract class _TrackingStatusDto implements TrackingStatusDto {
  const factory _TrackingStatusDto(
      {@JsonKey(name: 'booking_status')
      required final String bookingStatus}) = _$TrackingStatusDtoImpl;

  factory _TrackingStatusDto.fromJson(Map<String, dynamic> json) =
      _$TrackingStatusDtoImpl.fromJson;

  @override
  @JsonKey(name: 'booking_status')
  String get bookingStatus;
  @override
  @JsonKey(ignore: true)
  _$$TrackingStatusDtoImplCopyWith<_$TrackingStatusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
