// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payments_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckoutRequestDto _$CheckoutRequestDtoFromJson(Map<String, dynamic> json) {
  return _CheckoutRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CheckoutRequestDto {
  @JsonKey(name: 'delivery_method')
  String get deliveryMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_address_id')
  int? get shippingAddressId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckoutRequestDtoCopyWith<CheckoutRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutRequestDtoCopyWith<$Res> {
  factory $CheckoutRequestDtoCopyWith(
          CheckoutRequestDto value, $Res Function(CheckoutRequestDto) then) =
      _$CheckoutRequestDtoCopyWithImpl<$Res, CheckoutRequestDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'delivery_method') String deliveryMethod,
      @JsonKey(name: 'shipping_address_id') int? shippingAddressId});
}

/// @nodoc
class _$CheckoutRequestDtoCopyWithImpl<$Res, $Val extends CheckoutRequestDto>
    implements $CheckoutRequestDtoCopyWith<$Res> {
  _$CheckoutRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryMethod = null,
    Object? shippingAddressId = freezed,
  }) {
    return _then(_value.copyWith(
      deliveryMethod: null == deliveryMethod
          ? _value.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as String,
      shippingAddressId: freezed == shippingAddressId
          ? _value.shippingAddressId
          : shippingAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutRequestDtoImplCopyWith<$Res>
    implements $CheckoutRequestDtoCopyWith<$Res> {
  factory _$$CheckoutRequestDtoImplCopyWith(_$CheckoutRequestDtoImpl value,
          $Res Function(_$CheckoutRequestDtoImpl) then) =
      __$$CheckoutRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'delivery_method') String deliveryMethod,
      @JsonKey(name: 'shipping_address_id') int? shippingAddressId});
}

/// @nodoc
class __$$CheckoutRequestDtoImplCopyWithImpl<$Res>
    extends _$CheckoutRequestDtoCopyWithImpl<$Res, _$CheckoutRequestDtoImpl>
    implements _$$CheckoutRequestDtoImplCopyWith<$Res> {
  __$$CheckoutRequestDtoImplCopyWithImpl(_$CheckoutRequestDtoImpl _value,
      $Res Function(_$CheckoutRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryMethod = null,
    Object? shippingAddressId = freezed,
  }) {
    return _then(_$CheckoutRequestDtoImpl(
      deliveryMethod: null == deliveryMethod
          ? _value.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as String,
      shippingAddressId: freezed == shippingAddressId
          ? _value.shippingAddressId
          : shippingAddressId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckoutRequestDtoImpl implements _CheckoutRequestDto {
  const _$CheckoutRequestDtoImpl(
      {@JsonKey(name: 'delivery_method') required this.deliveryMethod,
      @JsonKey(name: 'shipping_address_id') this.shippingAddressId});

  factory _$CheckoutRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckoutRequestDtoImplFromJson(json);

  @override
  @JsonKey(name: 'delivery_method')
  final String deliveryMethod;
  @override
  @JsonKey(name: 'shipping_address_id')
  final int? shippingAddressId;

  @override
  String toString() {
    return 'CheckoutRequestDto(deliveryMethod: $deliveryMethod, shippingAddressId: $shippingAddressId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutRequestDtoImpl &&
            (identical(other.deliveryMethod, deliveryMethod) ||
                other.deliveryMethod == deliveryMethod) &&
            (identical(other.shippingAddressId, shippingAddressId) ||
                other.shippingAddressId == shippingAddressId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, deliveryMethod, shippingAddressId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutRequestDtoImplCopyWith<_$CheckoutRequestDtoImpl> get copyWith =>
      __$$CheckoutRequestDtoImplCopyWithImpl<_$CheckoutRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckoutRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _CheckoutRequestDto implements CheckoutRequestDto {
  const factory _CheckoutRequestDto(
      {@JsonKey(name: 'delivery_method') required final String deliveryMethod,
      @JsonKey(name: 'shipping_address_id')
      final int? shippingAddressId}) = _$CheckoutRequestDtoImpl;

  factory _CheckoutRequestDto.fromJson(Map<String, dynamic> json) =
      _$CheckoutRequestDtoImpl.fromJson;

  @override
  @JsonKey(name: 'delivery_method')
  String get deliveryMethod;
  @override
  @JsonKey(name: 'shipping_address_id')
  int? get shippingAddressId;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutRequestDtoImplCopyWith<_$CheckoutRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentSummaryDto _$PaymentSummaryDtoFromJson(Map<String, dynamic> json) {
  return _PaymentSummaryDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentSummaryDto {
  int get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentSummaryDtoCopyWith<PaymentSummaryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentSummaryDtoCopyWith<$Res> {
  factory $PaymentSummaryDtoCopyWith(
          PaymentSummaryDto value, $Res Function(PaymentSummaryDto) then) =
      _$PaymentSummaryDtoCopyWithImpl<$Res, PaymentSummaryDto>;
  @useResult
  $Res call({int id, String method, String status});
}

/// @nodoc
class _$PaymentSummaryDtoCopyWithImpl<$Res, $Val extends PaymentSummaryDto>
    implements $PaymentSummaryDtoCopyWith<$Res> {
  _$PaymentSummaryDtoCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentSummaryDtoImplCopyWith<$Res>
    implements $PaymentSummaryDtoCopyWith<$Res> {
  factory _$$PaymentSummaryDtoImplCopyWith(_$PaymentSummaryDtoImpl value,
          $Res Function(_$PaymentSummaryDtoImpl) then) =
      __$$PaymentSummaryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String method, String status});
}

/// @nodoc
class __$$PaymentSummaryDtoImplCopyWithImpl<$Res>
    extends _$PaymentSummaryDtoCopyWithImpl<$Res, _$PaymentSummaryDtoImpl>
    implements _$$PaymentSummaryDtoImplCopyWith<$Res> {
  __$$PaymentSummaryDtoImplCopyWithImpl(_$PaymentSummaryDtoImpl _value,
      $Res Function(_$PaymentSummaryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? status = null,
  }) {
    return _then(_$PaymentSummaryDtoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentSummaryDtoImpl implements _PaymentSummaryDto {
  const _$PaymentSummaryDtoImpl(
      {required this.id, required this.method, required this.status});

  factory _$PaymentSummaryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentSummaryDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String method;
  @override
  final String status;

  @override
  String toString() {
    return 'PaymentSummaryDto(id: $id, method: $method, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentSummaryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, method, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentSummaryDtoImplCopyWith<_$PaymentSummaryDtoImpl> get copyWith =>
      __$$PaymentSummaryDtoImplCopyWithImpl<_$PaymentSummaryDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentSummaryDtoImplToJson(
      this,
    );
  }
}

abstract class _PaymentSummaryDto implements PaymentSummaryDto {
  const factory _PaymentSummaryDto(
      {required final int id,
      required final String method,
      required final String status}) = _$PaymentSummaryDtoImpl;

  factory _PaymentSummaryDto.fromJson(Map<String, dynamic> json) =
      _$PaymentSummaryDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get method;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$PaymentSummaryDtoImplCopyWith<_$PaymentSummaryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CheckoutResponseDto _$CheckoutResponseDtoFromJson(Map<String, dynamic> json) {
  return _CheckoutResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CheckoutResponseDto {
  int get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  PaymentSummaryDto get payment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckoutResponseDtoCopyWith<CheckoutResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutResponseDtoCopyWith<$Res> {
  factory $CheckoutResponseDtoCopyWith(
          CheckoutResponseDto value, $Res Function(CheckoutResponseDto) then) =
      _$CheckoutResponseDtoCopyWithImpl<$Res, CheckoutResponseDto>;
  @useResult
  $Res call(
      {int id,
      String status,
      String total,
      String currency,
      PaymentSummaryDto payment});

  $PaymentSummaryDtoCopyWith<$Res> get payment;
}

/// @nodoc
class _$CheckoutResponseDtoCopyWithImpl<$Res, $Val extends CheckoutResponseDto>
    implements $CheckoutResponseDtoCopyWith<$Res> {
  _$CheckoutResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? total = null,
    Object? currency = null,
    Object? payment = null,
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
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as PaymentSummaryDto,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentSummaryDtoCopyWith<$Res> get payment {
    return $PaymentSummaryDtoCopyWith<$Res>(_value.payment, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckoutResponseDtoImplCopyWith<$Res>
    implements $CheckoutResponseDtoCopyWith<$Res> {
  factory _$$CheckoutResponseDtoImplCopyWith(_$CheckoutResponseDtoImpl value,
          $Res Function(_$CheckoutResponseDtoImpl) then) =
      __$$CheckoutResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String status,
      String total,
      String currency,
      PaymentSummaryDto payment});

  @override
  $PaymentSummaryDtoCopyWith<$Res> get payment;
}

/// @nodoc
class __$$CheckoutResponseDtoImplCopyWithImpl<$Res>
    extends _$CheckoutResponseDtoCopyWithImpl<$Res, _$CheckoutResponseDtoImpl>
    implements _$$CheckoutResponseDtoImplCopyWith<$Res> {
  __$$CheckoutResponseDtoImplCopyWithImpl(_$CheckoutResponseDtoImpl _value,
      $Res Function(_$CheckoutResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? total = null,
    Object? currency = null,
    Object? payment = null,
  }) {
    return _then(_$CheckoutResponseDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as PaymentSummaryDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckoutResponseDtoImpl implements _CheckoutResponseDto {
  const _$CheckoutResponseDtoImpl(
      {required this.id,
      required this.status,
      required this.total,
      this.currency = 'SAR',
      required this.payment});

  factory _$CheckoutResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckoutResponseDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String status;
  @override
  final String total;
  @override
  @JsonKey()
  final String currency;
  @override
  final PaymentSummaryDto payment;

  @override
  String toString() {
    return 'CheckoutResponseDto(id: $id, status: $status, total: $total, currency: $currency, payment: $payment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.payment, payment) || other.payment == payment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, total, currency, payment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutResponseDtoImplCopyWith<_$CheckoutResponseDtoImpl> get copyWith =>
      __$$CheckoutResponseDtoImplCopyWithImpl<_$CheckoutResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckoutResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CheckoutResponseDto implements CheckoutResponseDto {
  const factory _CheckoutResponseDto(
      {required final int id,
      required final String status,
      required final String total,
      final String currency,
      required final PaymentSummaryDto payment}) = _$CheckoutResponseDtoImpl;

  factory _CheckoutResponseDto.fromJson(Map<String, dynamic> json) =
      _$CheckoutResponseDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get status;
  @override
  String get total;
  @override
  String get currency;
  @override
  PaymentSummaryDto get payment;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutResponseDtoImplCopyWith<_$CheckoutResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentIntentDto _$PaymentIntentDtoFromJson(Map<String, dynamic> json) {
  return _PaymentIntentDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentIntentDto {
  @JsonKey(name: 'client_secret')
  String get clientSecret => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentIntentDtoCopyWith<PaymentIntentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentIntentDtoCopyWith<$Res> {
  factory $PaymentIntentDtoCopyWith(
          PaymentIntentDto value, $Res Function(PaymentIntentDto) then) =
      _$PaymentIntentDtoCopyWithImpl<$Res, PaymentIntentDto>;
  @useResult
  $Res call({@JsonKey(name: 'client_secret') String clientSecret});
}

/// @nodoc
class _$PaymentIntentDtoCopyWithImpl<$Res, $Val extends PaymentIntentDto>
    implements $PaymentIntentDtoCopyWith<$Res> {
  _$PaymentIntentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientSecret = null,
  }) {
    return _then(_value.copyWith(
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentIntentDtoImplCopyWith<$Res>
    implements $PaymentIntentDtoCopyWith<$Res> {
  factory _$$PaymentIntentDtoImplCopyWith(_$PaymentIntentDtoImpl value,
          $Res Function(_$PaymentIntentDtoImpl) then) =
      __$$PaymentIntentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'client_secret') String clientSecret});
}

/// @nodoc
class __$$PaymentIntentDtoImplCopyWithImpl<$Res>
    extends _$PaymentIntentDtoCopyWithImpl<$Res, _$PaymentIntentDtoImpl>
    implements _$$PaymentIntentDtoImplCopyWith<$Res> {
  __$$PaymentIntentDtoImplCopyWithImpl(_$PaymentIntentDtoImpl _value,
      $Res Function(_$PaymentIntentDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientSecret = null,
  }) {
    return _then(_$PaymentIntentDtoImpl(
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentIntentDtoImpl implements _PaymentIntentDto {
  const _$PaymentIntentDtoImpl(
      {@JsonKey(name: 'client_secret') required this.clientSecret});

  factory _$PaymentIntentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentIntentDtoImplFromJson(json);

  @override
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @override
  String toString() {
    return 'PaymentIntentDto(clientSecret: $clientSecret)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentIntentDtoImpl &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clientSecret);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentIntentDtoImplCopyWith<_$PaymentIntentDtoImpl> get copyWith =>
      __$$PaymentIntentDtoImplCopyWithImpl<_$PaymentIntentDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentIntentDtoImplToJson(
      this,
    );
  }
}

abstract class _PaymentIntentDto implements PaymentIntentDto {
  const factory _PaymentIntentDto(
      {@JsonKey(name: 'client_secret')
      required final String clientSecret}) = _$PaymentIntentDtoImpl;

  factory _PaymentIntentDto.fromJson(Map<String, dynamic> json) =
      _$PaymentIntentDtoImpl.fromJson;

  @override
  @JsonKey(name: 'client_secret')
  String get clientSecret;
  @override
  @JsonKey(ignore: true)
  _$$PaymentIntentDtoImplCopyWith<_$PaymentIntentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletTransactionDto _$WalletTransactionDtoFromJson(Map<String, dynamic> json) {
  return _WalletTransactionDto.fromJson(json);
}

/// @nodoc
mixin _$WalletTransactionDto {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletTransactionDtoCopyWith<WalletTransactionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTransactionDtoCopyWith<$Res> {
  factory $WalletTransactionDtoCopyWith(WalletTransactionDto value,
          $Res Function(WalletTransactionDto) then) =
      _$WalletTransactionDtoCopyWithImpl<$Res, WalletTransactionDto>;
  @useResult
  $Res call(
      {int id,
      String type,
      String amount,
      String description,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$WalletTransactionDtoCopyWithImpl<$Res,
        $Val extends WalletTransactionDto>
    implements $WalletTransactionDtoCopyWith<$Res> {
  _$WalletTransactionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletTransactionDtoImplCopyWith<$Res>
    implements $WalletTransactionDtoCopyWith<$Res> {
  factory _$$WalletTransactionDtoImplCopyWith(_$WalletTransactionDtoImpl value,
          $Res Function(_$WalletTransactionDtoImpl) then) =
      __$$WalletTransactionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String type,
      String amount,
      String description,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$WalletTransactionDtoImplCopyWithImpl<$Res>
    extends _$WalletTransactionDtoCopyWithImpl<$Res, _$WalletTransactionDtoImpl>
    implements _$$WalletTransactionDtoImplCopyWith<$Res> {
  __$$WalletTransactionDtoImplCopyWithImpl(_$WalletTransactionDtoImpl _value,
      $Res Function(_$WalletTransactionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(_$WalletTransactionDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletTransactionDtoImpl implements _WalletTransactionDto {
  const _$WalletTransactionDtoImpl(
      {required this.id,
      required this.type,
      required this.amount,
      required this.description,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$WalletTransactionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletTransactionDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String amount;
  @override
  final String description;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'WalletTransactionDto(id: $id, type: $type, amount: $amount, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTransactionDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, amount, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTransactionDtoImplCopyWith<_$WalletTransactionDtoImpl>
      get copyWith =>
          __$$WalletTransactionDtoImplCopyWithImpl<_$WalletTransactionDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletTransactionDtoImplToJson(
      this,
    );
  }
}

abstract class _WalletTransactionDto implements WalletTransactionDto {
  const factory _WalletTransactionDto(
          {required final int id,
          required final String type,
          required final String amount,
          required final String description,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$WalletTransactionDtoImpl;

  factory _WalletTransactionDto.fromJson(Map<String, dynamic> json) =
      _$WalletTransactionDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get amount;
  @override
  String get description;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$WalletTransactionDtoImplCopyWith<_$WalletTransactionDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WalletDto _$WalletDtoFromJson(Map<String, dynamic> json) {
  return _WalletDto.fromJson(json);
}

/// @nodoc
mixin _$WalletDto {
  String get balance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_transactions')
  List<WalletTransactionDto> get recentTransactions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletDtoCopyWith<WalletDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDtoCopyWith<$Res> {
  factory $WalletDtoCopyWith(WalletDto value, $Res Function(WalletDto) then) =
      _$WalletDtoCopyWithImpl<$Res, WalletDto>;
  @useResult
  $Res call(
      {String balance,
      String currency,
      @JsonKey(name: 'recent_transactions')
      List<WalletTransactionDto> recentTransactions});
}

/// @nodoc
class _$WalletDtoCopyWithImpl<$Res, $Val extends WalletDto>
    implements $WalletDtoCopyWith<$Res> {
  _$WalletDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? currency = null,
    Object? recentTransactions = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      recentTransactions: null == recentTransactions
          ? _value.recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<WalletTransactionDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletDtoImplCopyWith<$Res>
    implements $WalletDtoCopyWith<$Res> {
  factory _$$WalletDtoImplCopyWith(
          _$WalletDtoImpl value, $Res Function(_$WalletDtoImpl) then) =
      __$$WalletDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String balance,
      String currency,
      @JsonKey(name: 'recent_transactions')
      List<WalletTransactionDto> recentTransactions});
}

/// @nodoc
class __$$WalletDtoImplCopyWithImpl<$Res>
    extends _$WalletDtoCopyWithImpl<$Res, _$WalletDtoImpl>
    implements _$$WalletDtoImplCopyWith<$Res> {
  __$$WalletDtoImplCopyWithImpl(
      _$WalletDtoImpl _value, $Res Function(_$WalletDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? currency = null,
    Object? recentTransactions = null,
  }) {
    return _then(_$WalletDtoImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      recentTransactions: null == recentTransactions
          ? _value._recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<WalletTransactionDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletDtoImpl implements _WalletDto {
  const _$WalletDtoImpl(
      {required this.balance,
      this.currency = 'SAR',
      @JsonKey(name: 'recent_transactions')
      final List<WalletTransactionDto> recentTransactions = const []})
      : _recentTransactions = recentTransactions;

  factory _$WalletDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletDtoImplFromJson(json);

  @override
  final String balance;
  @override
  @JsonKey()
  final String currency;
  final List<WalletTransactionDto> _recentTransactions;
  @override
  @JsonKey(name: 'recent_transactions')
  List<WalletTransactionDto> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
  }

  @override
  String toString() {
    return 'WalletDto(balance: $balance, currency: $currency, recentTransactions: $recentTransactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletDtoImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality()
                .equals(other._recentTransactions, _recentTransactions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, balance, currency,
      const DeepCollectionEquality().hash(_recentTransactions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletDtoImplCopyWith<_$WalletDtoImpl> get copyWith =>
      __$$WalletDtoImplCopyWithImpl<_$WalletDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletDtoImplToJson(
      this,
    );
  }
}

abstract class _WalletDto implements WalletDto {
  const factory _WalletDto(
      {required final String balance,
      final String currency,
      @JsonKey(name: 'recent_transactions')
      final List<WalletTransactionDto> recentTransactions}) = _$WalletDtoImpl;

  factory _WalletDto.fromJson(Map<String, dynamic> json) =
      _$WalletDtoImpl.fromJson;

  @override
  String get balance;
  @override
  String get currency;
  @override
  @JsonKey(name: 'recent_transactions')
  List<WalletTransactionDto> get recentTransactions;
  @override
  @JsonKey(ignore: true)
  _$$WalletDtoImplCopyWith<_$WalletDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
