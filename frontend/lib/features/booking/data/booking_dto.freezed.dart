// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SlotDto _$SlotDtoFromJson(Map<String, dynamic> json) {
  return _SlotDto.fromJson(json);
}

/// @nodoc
mixin _$SlotDto {
  int get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity_left')
  int get capacityLeft => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlotDtoCopyWith<SlotDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotDtoCopyWith<$Res> {
  factory $SlotDtoCopyWith(SlotDto value, $Res Function(SlotDto) then) =
      _$SlotDtoCopyWithImpl<$Res, SlotDto>;
  @useResult
  $Res call(
      {int id,
      String date,
      @JsonKey(name: 'start_time') String startTime,
      @JsonKey(name: 'end_time') String endTime,
      @JsonKey(name: 'capacity_left') int capacityLeft,
      @JsonKey(name: 'is_available') bool isAvailable});
}

/// @nodoc
class _$SlotDtoCopyWithImpl<$Res, $Val extends SlotDto>
    implements $SlotDtoCopyWith<$Res> {
  _$SlotDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacityLeft = null,
    Object? isAvailable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      capacityLeft: null == capacityLeft
          ? _value.capacityLeft
          : capacityLeft // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlotDtoImplCopyWith<$Res> implements $SlotDtoCopyWith<$Res> {
  factory _$$SlotDtoImplCopyWith(
          _$SlotDtoImpl value, $Res Function(_$SlotDtoImpl) then) =
      __$$SlotDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String date,
      @JsonKey(name: 'start_time') String startTime,
      @JsonKey(name: 'end_time') String endTime,
      @JsonKey(name: 'capacity_left') int capacityLeft,
      @JsonKey(name: 'is_available') bool isAvailable});
}

/// @nodoc
class __$$SlotDtoImplCopyWithImpl<$Res>
    extends _$SlotDtoCopyWithImpl<$Res, _$SlotDtoImpl>
    implements _$$SlotDtoImplCopyWith<$Res> {
  __$$SlotDtoImplCopyWithImpl(
      _$SlotDtoImpl _value, $Res Function(_$SlotDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? capacityLeft = null,
    Object? isAvailable = null,
  }) {
    return _then(_$SlotDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      capacityLeft: null == capacityLeft
          ? _value.capacityLeft
          : capacityLeft // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotDtoImpl implements _SlotDto {
  const _$SlotDtoImpl(
      {required this.id,
      required this.date,
      @JsonKey(name: 'start_time') required this.startTime,
      @JsonKey(name: 'end_time') required this.endTime,
      @JsonKey(name: 'capacity_left') this.capacityLeft = 0,
      @JsonKey(name: 'is_available') this.isAvailable = false});

  factory _$SlotDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlotDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String date;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  @JsonKey(name: 'capacity_left')
  final int capacityLeft;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  @override
  String toString() {
    return 'SlotDto(id: $id, date: $date, startTime: $startTime, endTime: $endTime, capacityLeft: $capacityLeft, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.capacityLeft, capacityLeft) ||
                other.capacityLeft == capacityLeft) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, startTime, endTime, capacityLeft, isAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotDtoImplCopyWith<_$SlotDtoImpl> get copyWith =>
      __$$SlotDtoImplCopyWithImpl<_$SlotDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotDtoImplToJson(
      this,
    );
  }
}

abstract class _SlotDto implements SlotDto {
  const factory _SlotDto(
      {required final int id,
      required final String date,
      @JsonKey(name: 'start_time') required final String startTime,
      @JsonKey(name: 'end_time') required final String endTime,
      @JsonKey(name: 'capacity_left') final int capacityLeft,
      @JsonKey(name: 'is_available') final bool isAvailable}) = _$SlotDtoImpl;

  factory _SlotDto.fromJson(Map<String, dynamic> json) = _$SlotDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get date;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  @JsonKey(name: 'capacity_left')
  int get capacityLeft;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  @JsonKey(ignore: true)
  _$$SlotDtoImplCopyWith<_$SlotDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateBookingDto _$CreateBookingDtoFromJson(Map<String, dynamic> json) {
  return _CreateBookingDto.fromJson(json);
}

/// @nodoc
mixin _$CreateBookingDto {
  @JsonKey(name: 'service_id')
  int get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'slot_id')
  int get slotId => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_id')
  int? get vehicleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_id')
  int? get addressId => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile_lat')
  String? get mobileLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile_lng')
  String? get mobileLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_code')
  String? get promoCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateBookingDtoCopyWith<CreateBookingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateBookingDtoCopyWith<$Res> {
  factory $CreateBookingDtoCopyWith(
          CreateBookingDto value, $Res Function(CreateBookingDto) then) =
      _$CreateBookingDtoCopyWithImpl<$Res, CreateBookingDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'slot_id') int slotId,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'vehicle_id') int? vehicleId,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'mobile_lat') String? mobileLat,
      @JsonKey(name: 'mobile_lng') String? mobileLng,
      @JsonKey(name: 'promo_code') String? promoCode});
}

/// @nodoc
class _$CreateBookingDtoCopyWithImpl<$Res, $Val extends CreateBookingDto>
    implements $CreateBookingDtoCopyWith<$Res> {
  _$CreateBookingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? slotId = null,
    Object? locationType = null,
    Object? vehicleId = freezed,
    Object? addressId = freezed,
    Object? mobileLat = freezed,
    Object? mobileLng = freezed,
    Object? promoCode = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      mobileLat: freezed == mobileLat
          ? _value.mobileLat
          : mobileLat // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileLng: freezed == mobileLng
          ? _value.mobileLng
          : mobileLng // ignore: cast_nullable_to_non_nullable
              as String?,
      promoCode: freezed == promoCode
          ? _value.promoCode
          : promoCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateBookingDtoImplCopyWith<$Res>
    implements $CreateBookingDtoCopyWith<$Res> {
  factory _$$CreateBookingDtoImplCopyWith(_$CreateBookingDtoImpl value,
          $Res Function(_$CreateBookingDtoImpl) then) =
      __$$CreateBookingDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int serviceId,
      @JsonKey(name: 'slot_id') int slotId,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'vehicle_id') int? vehicleId,
      @JsonKey(name: 'address_id') int? addressId,
      @JsonKey(name: 'mobile_lat') String? mobileLat,
      @JsonKey(name: 'mobile_lng') String? mobileLng,
      @JsonKey(name: 'promo_code') String? promoCode});
}

/// @nodoc
class __$$CreateBookingDtoImplCopyWithImpl<$Res>
    extends _$CreateBookingDtoCopyWithImpl<$Res, _$CreateBookingDtoImpl>
    implements _$$CreateBookingDtoImplCopyWith<$Res> {
  __$$CreateBookingDtoImplCopyWithImpl(_$CreateBookingDtoImpl _value,
      $Res Function(_$CreateBookingDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? slotId = null,
    Object? locationType = null,
    Object? vehicleId = freezed,
    Object? addressId = freezed,
    Object? mobileLat = freezed,
    Object? mobileLng = freezed,
    Object? promoCode = freezed,
  }) {
    return _then(_$CreateBookingDtoImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      mobileLat: freezed == mobileLat
          ? _value.mobileLat
          : mobileLat // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileLng: freezed == mobileLng
          ? _value.mobileLng
          : mobileLng // ignore: cast_nullable_to_non_nullable
              as String?,
      promoCode: freezed == promoCode
          ? _value.promoCode
          : promoCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateBookingDtoImpl implements _CreateBookingDto {
  const _$CreateBookingDtoImpl(
      {@JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'slot_id') required this.slotId,
      @JsonKey(name: 'location_type') required this.locationType,
      @JsonKey(name: 'vehicle_id') this.vehicleId,
      @JsonKey(name: 'address_id') this.addressId,
      @JsonKey(name: 'mobile_lat') this.mobileLat,
      @JsonKey(name: 'mobile_lng') this.mobileLng,
      @JsonKey(name: 'promo_code') this.promoCode});

  factory _$CreateBookingDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateBookingDtoImplFromJson(json);

  @override
  @JsonKey(name: 'service_id')
  final int serviceId;
  @override
  @JsonKey(name: 'slot_id')
  final int slotId;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'vehicle_id')
  final int? vehicleId;
  @override
  @JsonKey(name: 'address_id')
  final int? addressId;
  @override
  @JsonKey(name: 'mobile_lat')
  final String? mobileLat;
  @override
  @JsonKey(name: 'mobile_lng')
  final String? mobileLng;
  @override
  @JsonKey(name: 'promo_code')
  final String? promoCode;

  @override
  String toString() {
    return 'CreateBookingDto(serviceId: $serviceId, slotId: $slotId, locationType: $locationType, vehicleId: $vehicleId, addressId: $addressId, mobileLat: $mobileLat, mobileLng: $mobileLng, promoCode: $promoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateBookingDtoImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.mobileLat, mobileLat) ||
                other.mobileLat == mobileLat) &&
            (identical(other.mobileLng, mobileLng) ||
                other.mobileLng == mobileLng) &&
            (identical(other.promoCode, promoCode) ||
                other.promoCode == promoCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, slotId, locationType,
      vehicleId, addressId, mobileLat, mobileLng, promoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBookingDtoImplCopyWith<_$CreateBookingDtoImpl> get copyWith =>
      __$$CreateBookingDtoImplCopyWithImpl<_$CreateBookingDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateBookingDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateBookingDto implements CreateBookingDto {
  const factory _CreateBookingDto(
          {@JsonKey(name: 'service_id') required final int serviceId,
          @JsonKey(name: 'slot_id') required final int slotId,
          @JsonKey(name: 'location_type') required final String locationType,
          @JsonKey(name: 'vehicle_id') final int? vehicleId,
          @JsonKey(name: 'address_id') final int? addressId,
          @JsonKey(name: 'mobile_lat') final String? mobileLat,
          @JsonKey(name: 'mobile_lng') final String? mobileLng,
          @JsonKey(name: 'promo_code') final String? promoCode}) =
      _$CreateBookingDtoImpl;

  factory _CreateBookingDto.fromJson(Map<String, dynamic> json) =
      _$CreateBookingDtoImpl.fromJson;

  @override
  @JsonKey(name: 'service_id')
  int get serviceId;
  @override
  @JsonKey(name: 'slot_id')
  int get slotId;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'vehicle_id')
  int? get vehicleId;
  @override
  @JsonKey(name: 'address_id')
  int? get addressId;
  @override
  @JsonKey(name: 'mobile_lat')
  String? get mobileLat;
  @override
  @JsonKey(name: 'mobile_lng')
  String? get mobileLng;
  @override
  @JsonKey(name: 'promo_code')
  String? get promoCode;
  @override
  @JsonKey(ignore: true)
  _$$CreateBookingDtoImplCopyWith<_$CreateBookingDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingPaymentDto _$BookingPaymentDtoFromJson(Map<String, dynamic> json) {
  return _BookingPaymentDto.fromJson(json);
}

/// @nodoc
mixin _$BookingPaymentDto {
  int get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_secret')
  String? get clientSecret => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingPaymentDtoCopyWith<BookingPaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingPaymentDtoCopyWith<$Res> {
  factory $BookingPaymentDtoCopyWith(
          BookingPaymentDto value, $Res Function(BookingPaymentDto) then) =
      _$BookingPaymentDtoCopyWithImpl<$Res, BookingPaymentDto>;
  @useResult
  $Res call(
      {int id,
      String method,
      String status,
      @JsonKey(name: 'client_secret') String? clientSecret});
}

/// @nodoc
class _$BookingPaymentDtoCopyWithImpl<$Res, $Val extends BookingPaymentDto>
    implements $BookingPaymentDtoCopyWith<$Res> {
  _$BookingPaymentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? status = null,
    Object? clientSecret = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: freezed == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingPaymentDtoImplCopyWith<$Res>
    implements $BookingPaymentDtoCopyWith<$Res> {
  factory _$$BookingPaymentDtoImplCopyWith(_$BookingPaymentDtoImpl value,
          $Res Function(_$BookingPaymentDtoImpl) then) =
      __$$BookingPaymentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String method,
      String status,
      @JsonKey(name: 'client_secret') String? clientSecret});
}

/// @nodoc
class __$$BookingPaymentDtoImplCopyWithImpl<$Res>
    extends _$BookingPaymentDtoCopyWithImpl<$Res, _$BookingPaymentDtoImpl>
    implements _$$BookingPaymentDtoImplCopyWith<$Res> {
  __$$BookingPaymentDtoImplCopyWithImpl(_$BookingPaymentDtoImpl _value,
      $Res Function(_$BookingPaymentDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? status = null,
    Object? clientSecret = freezed,
  }) {
    return _then(_$BookingPaymentDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: freezed == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingPaymentDtoImpl implements _BookingPaymentDto {
  const _$BookingPaymentDtoImpl(
      {required this.id,
      required this.method,
      required this.status,
      @JsonKey(name: 'client_secret') this.clientSecret});

  factory _$BookingPaymentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingPaymentDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String method;
  @override
  final String status;
  @override
  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  @override
  String toString() {
    return 'BookingPaymentDto(id: $id, method: $method, status: $status, clientSecret: $clientSecret)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingPaymentDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, method, status, clientSecret);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingPaymentDtoImplCopyWith<_$BookingPaymentDtoImpl> get copyWith =>
      __$$BookingPaymentDtoImplCopyWithImpl<_$BookingPaymentDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingPaymentDtoImplToJson(
      this,
    );
  }
}

abstract class _BookingPaymentDto implements BookingPaymentDto {
  const factory _BookingPaymentDto(
          {required final int id,
          required final String method,
          required final String status,
          @JsonKey(name: 'client_secret') final String? clientSecret}) =
      _$BookingPaymentDtoImpl;

  factory _BookingPaymentDto.fromJson(Map<String, dynamic> json) =
      _$BookingPaymentDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get method;
  @override
  String get status;
  @override
  @JsonKey(name: 'client_secret')
  String? get clientSecret;
  @override
  @JsonKey(ignore: true)
  _$$BookingPaymentDtoImplCopyWith<_$BookingPaymentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingSlotSummaryDto _$BookingSlotSummaryDtoFromJson(
    Map<String, dynamic> json) {
  return _BookingSlotSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$BookingSlotSummaryDto {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingSlotSummaryDtoCopyWith<BookingSlotSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingSlotSummaryDtoCopyWith<$Res> {
  factory $BookingSlotSummaryDtoCopyWith(BookingSlotSummaryDto value,
          $Res Function(BookingSlotSummaryDto) then) =
      _$BookingSlotSummaryDtoCopyWithImpl<$Res, BookingSlotSummaryDto>;
  @useResult
  $Res call({String date, @JsonKey(name: 'start_time') String startTime});
}

/// @nodoc
class _$BookingSlotSummaryDtoCopyWithImpl<$Res,
        $Val extends BookingSlotSummaryDto>
    implements $BookingSlotSummaryDtoCopyWith<$Res> {
  _$BookingSlotSummaryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingSlotSummaryDtoImplCopyWith<$Res>
    implements $BookingSlotSummaryDtoCopyWith<$Res> {
  factory _$$BookingSlotSummaryDtoImplCopyWith(
          _$BookingSlotSummaryDtoImpl value,
          $Res Function(_$BookingSlotSummaryDtoImpl) then) =
      __$$BookingSlotSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, @JsonKey(name: 'start_time') String startTime});
}

/// @nodoc
class __$$BookingSlotSummaryDtoImplCopyWithImpl<$Res>
    extends _$BookingSlotSummaryDtoCopyWithImpl<$Res,
        _$BookingSlotSummaryDtoImpl>
    implements _$$BookingSlotSummaryDtoImplCopyWith<$Res> {
  __$$BookingSlotSummaryDtoImplCopyWithImpl(_$BookingSlotSummaryDtoImpl _value,
      $Res Function(_$BookingSlotSummaryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
  }) {
    return _then(_$BookingSlotSummaryDtoImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingSlotSummaryDtoImpl implements _BookingSlotSummaryDto {
  const _$BookingSlotSummaryDtoImpl(
      {required this.date,
      @JsonKey(name: 'start_time') required this.startTime});

  factory _$BookingSlotSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingSlotSummaryDtoImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;

  @override
  String toString() {
    return 'BookingSlotSummaryDto(date: $date, startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingSlotSummaryDtoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, startTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingSlotSummaryDtoImplCopyWith<_$BookingSlotSummaryDtoImpl>
      get copyWith => __$$BookingSlotSummaryDtoImplCopyWithImpl<
          _$BookingSlotSummaryDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingSlotSummaryDtoImplToJson(
      this,
    );
  }
}

abstract class _BookingSlotSummaryDto implements BookingSlotSummaryDto {
  const factory _BookingSlotSummaryDto(
          {required final String date,
          @JsonKey(name: 'start_time') required final String startTime}) =
      _$BookingSlotSummaryDtoImpl;

  factory _BookingSlotSummaryDto.fromJson(Map<String, dynamic> json) =
      _$BookingSlotSummaryDtoImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(ignore: true)
  _$$BookingSlotSummaryDtoImplCopyWith<_$BookingSlotSummaryDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) {
  return _BookingDto.fromJson(json);
}

/// @nodoc
mixin _$BookingDto {
  int get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_charged')
  String get priceCharged => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  BookingPaymentDto get payment => throw _privateConstructorUsedError;
  BookingSlotSummaryDto get slot => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String? get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String? get branchName => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_plate')
  String? get vehiclePlate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_cancel')
  bool get canCancel => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_reschedule')
  bool get canReschedule => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingDtoCopyWith<BookingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDtoCopyWith<$Res> {
  factory $BookingDtoCopyWith(
          BookingDto value, $Res Function(BookingDto) then) =
      _$BookingDtoCopyWithImpl<$Res, BookingDto>;
  @useResult
  $Res call(
      {int id,
      String status,
      @JsonKey(name: 'price_charged') String priceCharged,
      String currency,
      BookingPaymentDto payment,
      BookingSlotSummaryDto slot,
      @JsonKey(name: 'service_name') String? serviceName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'branch_name') String? branchName,
      @JsonKey(name: 'vehicle_plate') String? vehiclePlate,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'can_cancel') bool canCancel,
      @JsonKey(name: 'can_reschedule') bool canReschedule});

  $BookingPaymentDtoCopyWith<$Res> get payment;
  $BookingSlotSummaryDtoCopyWith<$Res> get slot;
}

/// @nodoc
class _$BookingDtoCopyWithImpl<$Res, $Val extends BookingDto>
    implements $BookingDtoCopyWith<$Res> {
  _$BookingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? priceCharged = null,
    Object? currency = null,
    Object? payment = null,
    Object? slot = null,
    Object? serviceName = freezed,
    Object? locationType = null,
    Object? branchName = freezed,
    Object? vehiclePlate = freezed,
    Object? createdAt = freezed,
    Object? canCancel = null,
    Object? canReschedule = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priceCharged: null == priceCharged
          ? _value.priceCharged
          : priceCharged // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as BookingPaymentDto,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BookingSlotSummaryDto,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      canCancel: null == canCancel
          ? _value.canCancel
          : canCancel // ignore: cast_nullable_to_non_nullable
              as bool,
      canReschedule: null == canReschedule
          ? _value.canReschedule
          : canReschedule // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BookingPaymentDtoCopyWith<$Res> get payment {
    return $BookingPaymentDtoCopyWith<$Res>(_value.payment, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BookingSlotSummaryDtoCopyWith<$Res> get slot {
    return $BookingSlotSummaryDtoCopyWith<$Res>(_value.slot, (value) {
      return _then(_value.copyWith(slot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingDtoImplCopyWith<$Res>
    implements $BookingDtoCopyWith<$Res> {
  factory _$$BookingDtoImplCopyWith(
          _$BookingDtoImpl value, $Res Function(_$BookingDtoImpl) then) =
      __$$BookingDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String status,
      @JsonKey(name: 'price_charged') String priceCharged,
      String currency,
      BookingPaymentDto payment,
      BookingSlotSummaryDto slot,
      @JsonKey(name: 'service_name') String? serviceName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'branch_name') String? branchName,
      @JsonKey(name: 'vehicle_plate') String? vehiclePlate,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'can_cancel') bool canCancel,
      @JsonKey(name: 'can_reschedule') bool canReschedule});

  @override
  $BookingPaymentDtoCopyWith<$Res> get payment;
  @override
  $BookingSlotSummaryDtoCopyWith<$Res> get slot;
}

/// @nodoc
class __$$BookingDtoImplCopyWithImpl<$Res>
    extends _$BookingDtoCopyWithImpl<$Res, _$BookingDtoImpl>
    implements _$$BookingDtoImplCopyWith<$Res> {
  __$$BookingDtoImplCopyWithImpl(
      _$BookingDtoImpl _value, $Res Function(_$BookingDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? priceCharged = null,
    Object? currency = null,
    Object? payment = null,
    Object? slot = null,
    Object? serviceName = freezed,
    Object? locationType = null,
    Object? branchName = freezed,
    Object? vehiclePlate = freezed,
    Object? createdAt = freezed,
    Object? canCancel = null,
    Object? canReschedule = null,
  }) {
    return _then(_$BookingDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priceCharged: null == priceCharged
          ? _value.priceCharged
          : priceCharged // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as BookingPaymentDto,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BookingSlotSummaryDto,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      canCancel: null == canCancel
          ? _value.canCancel
          : canCancel // ignore: cast_nullable_to_non_nullable
              as bool,
      canReschedule: null == canReschedule
          ? _value.canReschedule
          : canReschedule // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingDtoImpl implements _BookingDto {
  const _$BookingDtoImpl(
      {required this.id,
      required this.status,
      @JsonKey(name: 'price_charged') required this.priceCharged,
      this.currency = 'SAR',
      required this.payment,
      required this.slot,
      @JsonKey(name: 'service_name') this.serviceName,
      @JsonKey(name: 'location_type') this.locationType = 'branch',
      @JsonKey(name: 'branch_name') this.branchName,
      @JsonKey(name: 'vehicle_plate') this.vehiclePlate,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'can_cancel') this.canCancel = false,
      @JsonKey(name: 'can_reschedule') this.canReschedule = false});

  factory _$BookingDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String status;
  @override
  @JsonKey(name: 'price_charged')
  final String priceCharged;
  @override
  @JsonKey()
  final String currency;
  @override
  final BookingPaymentDto payment;
  @override
  final BookingSlotSummaryDto slot;
  @override
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @override
  @JsonKey(name: 'vehicle_plate')
  final String? vehiclePlate;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'can_cancel')
  final bool canCancel;
  @override
  @JsonKey(name: 'can_reschedule')
  final bool canReschedule;

  @override
  String toString() {
    return 'BookingDto(id: $id, status: $status, priceCharged: $priceCharged, currency: $currency, payment: $payment, slot: $slot, serviceName: $serviceName, locationType: $locationType, branchName: $branchName, vehiclePlate: $vehiclePlate, createdAt: $createdAt, canCancel: $canCancel, canReschedule: $canReschedule)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priceCharged, priceCharged) ||
                other.priceCharged == priceCharged) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.vehiclePlate, vehiclePlate) ||
                other.vehiclePlate == vehiclePlate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.canCancel, canCancel) ||
                other.canCancel == canCancel) &&
            (identical(other.canReschedule, canReschedule) ||
                other.canReschedule == canReschedule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      priceCharged,
      currency,
      payment,
      slot,
      serviceName,
      locationType,
      branchName,
      vehiclePlate,
      createdAt,
      canCancel,
      canReschedule);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDtoImplCopyWith<_$BookingDtoImpl> get copyWith =>
      __$$BookingDtoImplCopyWithImpl<_$BookingDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDtoImplToJson(
      this,
    );
  }
}

abstract class _BookingDto implements BookingDto {
  const factory _BookingDto(
          {required final int id,
          required final String status,
          @JsonKey(name: 'price_charged') required final String priceCharged,
          final String currency,
          required final BookingPaymentDto payment,
          required final BookingSlotSummaryDto slot,
          @JsonKey(name: 'service_name') final String? serviceName,
          @JsonKey(name: 'location_type') final String locationType,
          @JsonKey(name: 'branch_name') final String? branchName,
          @JsonKey(name: 'vehicle_plate') final String? vehiclePlate,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'can_cancel') final bool canCancel,
          @JsonKey(name: 'can_reschedule') final bool canReschedule}) =
      _$BookingDtoImpl;

  factory _BookingDto.fromJson(Map<String, dynamic> json) =
      _$BookingDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get status;
  @override
  @JsonKey(name: 'price_charged')
  String get priceCharged;
  @override
  String get currency;
  @override
  BookingPaymentDto get payment;
  @override
  BookingSlotSummaryDto get slot;
  @override
  @JsonKey(name: 'service_name')
  String? get serviceName;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'branch_name')
  String? get branchName;
  @override
  @JsonKey(name: 'vehicle_plate')
  String? get vehiclePlate;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'can_cancel')
  bool get canCancel;
  @override
  @JsonKey(name: 'can_reschedule')
  bool get canReschedule;
  @override
  @JsonKey(ignore: true)
  _$$BookingDtoImplCopyWith<_$BookingDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingListItemDto _$BookingListItemDtoFromJson(Map<String, dynamic> json) {
  return _BookingListItemDto.fromJson(json);
}

/// @nodoc
mixin _$BookingListItemDto {
  int get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_charged')
  String get priceCharged => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String? get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'slot_date')
  String? get slotDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'slot_start_time')
  String? get slotStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String? get branchName => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_cancel')
  bool get canCancel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingListItemDtoCopyWith<BookingListItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingListItemDtoCopyWith<$Res> {
  factory $BookingListItemDtoCopyWith(
          BookingListItemDto value, $Res Function(BookingListItemDto) then) =
      _$BookingListItemDtoCopyWithImpl<$Res, BookingListItemDto>;
  @useResult
  $Res call(
      {int id,
      String status,
      @JsonKey(name: 'price_charged') String priceCharged,
      String currency,
      @JsonKey(name: 'service_name') String? serviceName,
      @JsonKey(name: 'slot_date') String? slotDate,
      @JsonKey(name: 'slot_start_time') String? slotStartTime,
      @JsonKey(name: 'branch_name') String? branchName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'can_cancel') bool canCancel});
}

/// @nodoc
class _$BookingListItemDtoCopyWithImpl<$Res, $Val extends BookingListItemDto>
    implements $BookingListItemDtoCopyWith<$Res> {
  _$BookingListItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? priceCharged = null,
    Object? currency = null,
    Object? serviceName = freezed,
    Object? slotDate = freezed,
    Object? slotStartTime = freezed,
    Object? branchName = freezed,
    Object? locationType = null,
    Object? canCancel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priceCharged: null == priceCharged
          ? _value.priceCharged
          : priceCharged // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      slotDate: freezed == slotDate
          ? _value.slotDate
          : slotDate // ignore: cast_nullable_to_non_nullable
              as String?,
      slotStartTime: freezed == slotStartTime
          ? _value.slotStartTime
          : slotStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      canCancel: null == canCancel
          ? _value.canCancel
          : canCancel // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingListItemDtoImplCopyWith<$Res>
    implements $BookingListItemDtoCopyWith<$Res> {
  factory _$$BookingListItemDtoImplCopyWith(_$BookingListItemDtoImpl value,
          $Res Function(_$BookingListItemDtoImpl) then) =
      __$$BookingListItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String status,
      @JsonKey(name: 'price_charged') String priceCharged,
      String currency,
      @JsonKey(name: 'service_name') String? serviceName,
      @JsonKey(name: 'slot_date') String? slotDate,
      @JsonKey(name: 'slot_start_time') String? slotStartTime,
      @JsonKey(name: 'branch_name') String? branchName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'can_cancel') bool canCancel});
}

/// @nodoc
class __$$BookingListItemDtoImplCopyWithImpl<$Res>
    extends _$BookingListItemDtoCopyWithImpl<$Res, _$BookingListItemDtoImpl>
    implements _$$BookingListItemDtoImplCopyWith<$Res> {
  __$$BookingListItemDtoImplCopyWithImpl(_$BookingListItemDtoImpl _value,
      $Res Function(_$BookingListItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? priceCharged = null,
    Object? currency = null,
    Object? serviceName = freezed,
    Object? slotDate = freezed,
    Object? slotStartTime = freezed,
    Object? branchName = freezed,
    Object? locationType = null,
    Object? canCancel = null,
  }) {
    return _then(_$BookingListItemDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priceCharged: null == priceCharged
          ? _value.priceCharged
          : priceCharged // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: freezed == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      slotDate: freezed == slotDate
          ? _value.slotDate
          : slotDate // ignore: cast_nullable_to_non_nullable
              as String?,
      slotStartTime: freezed == slotStartTime
          ? _value.slotStartTime
          : slotStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      canCancel: null == canCancel
          ? _value.canCancel
          : canCancel // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingListItemDtoImpl implements _BookingListItemDto {
  const _$BookingListItemDtoImpl(
      {required this.id,
      required this.status,
      @JsonKey(name: 'price_charged') this.priceCharged = '0.00',
      this.currency = 'SAR',
      @JsonKey(name: 'service_name') this.serviceName,
      @JsonKey(name: 'slot_date') this.slotDate,
      @JsonKey(name: 'slot_start_time') this.slotStartTime,
      @JsonKey(name: 'branch_name') this.branchName,
      @JsonKey(name: 'location_type') this.locationType = 'branch',
      @JsonKey(name: 'can_cancel') this.canCancel = false});

  factory _$BookingListItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingListItemDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String status;
  @override
  @JsonKey(name: 'price_charged')
  final String priceCharged;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @override
  @JsonKey(name: 'slot_date')
  final String? slotDate;
  @override
  @JsonKey(name: 'slot_start_time')
  final String? slotStartTime;
  @override
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'can_cancel')
  final bool canCancel;

  @override
  String toString() {
    return 'BookingListItemDto(id: $id, status: $status, priceCharged: $priceCharged, currency: $currency, serviceName: $serviceName, slotDate: $slotDate, slotStartTime: $slotStartTime, branchName: $branchName, locationType: $locationType, canCancel: $canCancel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingListItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priceCharged, priceCharged) ||
                other.priceCharged == priceCharged) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.slotDate, slotDate) ||
                other.slotDate == slotDate) &&
            (identical(other.slotStartTime, slotStartTime) ||
                other.slotStartTime == slotStartTime) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.canCancel, canCancel) ||
                other.canCancel == canCancel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      priceCharged,
      currency,
      serviceName,
      slotDate,
      slotStartTime,
      branchName,
      locationType,
      canCancel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingListItemDtoImplCopyWith<_$BookingListItemDtoImpl> get copyWith =>
      __$$BookingListItemDtoImplCopyWithImpl<_$BookingListItemDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingListItemDtoImplToJson(
      this,
    );
  }
}

abstract class _BookingListItemDto implements BookingListItemDto {
  const factory _BookingListItemDto(
          {required final int id,
          required final String status,
          @JsonKey(name: 'price_charged') final String priceCharged,
          final String currency,
          @JsonKey(name: 'service_name') final String? serviceName,
          @JsonKey(name: 'slot_date') final String? slotDate,
          @JsonKey(name: 'slot_start_time') final String? slotStartTime,
          @JsonKey(name: 'branch_name') final String? branchName,
          @JsonKey(name: 'location_type') final String locationType,
          @JsonKey(name: 'can_cancel') final bool canCancel}) =
      _$BookingListItemDtoImpl;

  factory _BookingListItemDto.fromJson(Map<String, dynamic> json) =
      _$BookingListItemDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get status;
  @override
  @JsonKey(name: 'price_charged')
  String get priceCharged;
  @override
  String get currency;
  @override
  @JsonKey(name: 'service_name')
  String? get serviceName;
  @override
  @JsonKey(name: 'slot_date')
  String? get slotDate;
  @override
  @JsonKey(name: 'slot_start_time')
  String? get slotStartTime;
  @override
  @JsonKey(name: 'branch_name')
  String? get branchName;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'can_cancel')
  bool get canCancel;
  @override
  @JsonKey(ignore: true)
  _$$BookingListItemDtoImplCopyWith<_$BookingListItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedBookingsDto _$PaginatedBookingsDtoFromJson(Map<String, dynamic> json) {
  return _PaginatedBookingsDto.fromJson(json);
}

/// @nodoc
mixin _$PaginatedBookingsDto {
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<BookingListItemDto> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginatedBookingsDtoCopyWith<PaginatedBookingsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedBookingsDtoCopyWith<$Res> {
  factory $PaginatedBookingsDtoCopyWith(PaginatedBookingsDto value,
          $Res Function(PaginatedBookingsDto) then) =
      _$PaginatedBookingsDtoCopyWithImpl<$Res, PaginatedBookingsDto>;
  @useResult
  $Res call({String? next, String? previous, List<BookingListItemDto> results});
}

/// @nodoc
class _$PaginatedBookingsDtoCopyWithImpl<$Res,
        $Val extends PaginatedBookingsDto>
    implements $PaginatedBookingsDtoCopyWith<$Res> {
  _$PaginatedBookingsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookingListItemDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedBookingsDtoImplCopyWith<$Res>
    implements $PaginatedBookingsDtoCopyWith<$Res> {
  factory _$$PaginatedBookingsDtoImplCopyWith(_$PaginatedBookingsDtoImpl value,
          $Res Function(_$PaginatedBookingsDtoImpl) then) =
      __$$PaginatedBookingsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? next, String? previous, List<BookingListItemDto> results});
}

/// @nodoc
class __$$PaginatedBookingsDtoImplCopyWithImpl<$Res>
    extends _$PaginatedBookingsDtoCopyWithImpl<$Res, _$PaginatedBookingsDtoImpl>
    implements _$$PaginatedBookingsDtoImplCopyWith<$Res> {
  __$$PaginatedBookingsDtoImplCopyWithImpl(_$PaginatedBookingsDtoImpl _value,
      $Res Function(_$PaginatedBookingsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_$PaginatedBookingsDtoImpl(
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookingListItemDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedBookingsDtoImpl implements _PaginatedBookingsDto {
  const _$PaginatedBookingsDtoImpl(
      {this.next,
      this.previous,
      final List<BookingListItemDto> results = const []})
      : _results = results;

  factory _$PaginatedBookingsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedBookingsDtoImplFromJson(json);

  @override
  final String? next;
  @override
  final String? previous;
  final List<BookingListItemDto> _results;
  @override
  @JsonKey()
  List<BookingListItemDto> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'PaginatedBookingsDto(next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedBookingsDtoImpl &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, next, previous,
      const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedBookingsDtoImplCopyWith<_$PaginatedBookingsDtoImpl>
      get copyWith =>
          __$$PaginatedBookingsDtoImplCopyWithImpl<_$PaginatedBookingsDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedBookingsDtoImplToJson(
      this,
    );
  }
}

abstract class _PaginatedBookingsDto implements PaginatedBookingsDto {
  const factory _PaginatedBookingsDto(
      {final String? next,
      final String? previous,
      final List<BookingListItemDto> results}) = _$PaginatedBookingsDtoImpl;

  factory _PaginatedBookingsDto.fromJson(Map<String, dynamic> json) =
      _$PaginatedBookingsDtoImpl.fromJson;

  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<BookingListItemDto> get results;
  @override
  @JsonKey(ignore: true)
  _$$PaginatedBookingsDtoImplCopyWith<_$PaginatedBookingsDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
