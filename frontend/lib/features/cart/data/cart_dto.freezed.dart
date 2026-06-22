// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) {
  return _CartItemDto.fromJson(json);
}

/// @nodoc
mixin _$CartItemDto {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_image')
  String? get productImage => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  String get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  String get lineTotal => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemDtoCopyWith<CartItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemDtoCopyWith<$Res> {
  factory $CartItemDtoCopyWith(
          CartItemDto value, $Res Function(CartItemDto) then) =
      _$CartItemDtoCopyWithImpl<$Res, CartItemDto>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_image') String? productImage,
      int quantity,
      @JsonKey(name: 'unit_price') String unitPrice,
      @JsonKey(name: 'line_total') String lineTotal,
      String currency});
}

/// @nodoc
class _$CartItemDtoCopyWithImpl<$Res, $Val extends CartItemDto>
    implements $CartItemDtoCopyWith<$Res> {
  _$CartItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? productImage = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: freezed == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartItemDtoImplCopyWith<$Res>
    implements $CartItemDtoCopyWith<$Res> {
  factory _$$CartItemDtoImplCopyWith(
          _$CartItemDtoImpl value, $Res Function(_$CartItemDtoImpl) then) =
      __$$CartItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'product_id') int productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_image') String? productImage,
      int quantity,
      @JsonKey(name: 'unit_price') String unitPrice,
      @JsonKey(name: 'line_total') String lineTotal,
      String currency});
}

/// @nodoc
class __$$CartItemDtoImplCopyWithImpl<$Res>
    extends _$CartItemDtoCopyWithImpl<$Res, _$CartItemDtoImpl>
    implements _$$CartItemDtoImplCopyWith<$Res> {
  __$$CartItemDtoImplCopyWithImpl(
      _$CartItemDtoImpl _value, $Res Function(_$CartItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? productName = null,
    Object? productImage = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
    Object? currency = null,
  }) {
    return _then(_$CartItemDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: freezed == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      lineTotal: null == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemDtoImpl implements _CartItemDto {
  const _$CartItemDtoImpl(
      {required this.id,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') required this.productName,
      @JsonKey(name: 'product_image') this.productImage,
      required this.quantity,
      @JsonKey(name: 'unit_price') required this.unitPrice,
      @JsonKey(name: 'line_total') required this.lineTotal,
      this.currency = 'SAR'});

  factory _$CartItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemDtoImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'product_image')
  final String? productImage;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final String unitPrice;
  @override
  @JsonKey(name: 'line_total')
  final String lineTotal;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'CartItemDto(id: $id, productId: $productId, productName: $productName, productImage: $productImage, quantity: $quantity, unitPrice: $unitPrice, lineTotal: $lineTotal, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, productId, productName,
      productImage, quantity, unitPrice, lineTotal, currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemDtoImplCopyWith<_$CartItemDtoImpl> get copyWith =>
      __$$CartItemDtoImplCopyWithImpl<_$CartItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemDtoImplToJson(
      this,
    );
  }
}

abstract class _CartItemDto implements CartItemDto {
  const factory _CartItemDto(
      {required final int id,
      @JsonKey(name: 'product_id') required final int productId,
      @JsonKey(name: 'product_name') required final String productName,
      @JsonKey(name: 'product_image') final String? productImage,
      required final int quantity,
      @JsonKey(name: 'unit_price') required final String unitPrice,
      @JsonKey(name: 'line_total') required final String lineTotal,
      final String currency}) = _$CartItemDtoImpl;

  factory _CartItemDto.fromJson(Map<String, dynamic> json) =
      _$CartItemDtoImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'product_image')
  String? get productImage;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price')
  String get unitPrice;
  @override
  @JsonKey(name: 'line_total')
  String get lineTotal;
  @override
  String get currency;
  @override
  @JsonKey(ignore: true)
  _$$CartItemDtoImplCopyWith<_$CartItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartDto _$CartDtoFromJson(Map<String, dynamic> json) {
  return _CartDto.fromJson(json);
}

/// @nodoc
mixin _$CartDto {
  int get id => throw _privateConstructorUsedError;
  List<CartItemDto> get items => throw _privateConstructorUsedError;
  String get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  String get discountAmount => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_code')
  String? get promoCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartDtoCopyWith<CartDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartDtoCopyWith<$Res> {
  factory $CartDtoCopyWith(CartDto value, $Res Function(CartDto) then) =
      _$CartDtoCopyWithImpl<$Res, CartDto>;
  @useResult
  $Res call(
      {int id,
      List<CartItemDto> items,
      String subtotal,
      @JsonKey(name: 'discount_amount') String discountAmount,
      String total,
      String currency,
      @JsonKey(name: 'promo_code') String? promoCode});
}

/// @nodoc
class _$CartDtoCopyWithImpl<$Res, $Val extends CartDto>
    implements $CartDtoCopyWith<$Res> {
  _$CartDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? subtotal = null,
    Object? discountAmount = null,
    Object? total = null,
    Object? currency = null,
    Object? promoCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItemDto>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      promoCode: freezed == promoCode
          ? _value.promoCode
          : promoCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartDtoImplCopyWith<$Res> implements $CartDtoCopyWith<$Res> {
  factory _$$CartDtoImplCopyWith(
          _$CartDtoImpl value, $Res Function(_$CartDtoImpl) then) =
      __$$CartDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      List<CartItemDto> items,
      String subtotal,
      @JsonKey(name: 'discount_amount') String discountAmount,
      String total,
      String currency,
      @JsonKey(name: 'promo_code') String? promoCode});
}

/// @nodoc
class __$$CartDtoImplCopyWithImpl<$Res>
    extends _$CartDtoCopyWithImpl<$Res, _$CartDtoImpl>
    implements _$$CartDtoImplCopyWith<$Res> {
  __$$CartDtoImplCopyWithImpl(
      _$CartDtoImpl _value, $Res Function(_$CartDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? items = null,
    Object? subtotal = null,
    Object? discountAmount = null,
    Object? total = null,
    Object? currency = null,
    Object? promoCode = freezed,
  }) {
    return _then(_$CartDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItemDto>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      promoCode: freezed == promoCode
          ? _value.promoCode
          : promoCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartDtoImpl implements _CartDto {
  const _$CartDtoImpl(
      {required this.id,
      final List<CartItemDto> items = const [],
      required this.subtotal,
      @JsonKey(name: 'discount_amount') this.discountAmount = '0.00',
      required this.total,
      this.currency = 'SAR',
      @JsonKey(name: 'promo_code') this.promoCode})
      : _items = items;

  factory _$CartDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartDtoImplFromJson(json);

  @override
  final int id;
  final List<CartItemDto> _items;
  @override
  @JsonKey()
  List<CartItemDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String subtotal;
  @override
  @JsonKey(name: 'discount_amount')
  final String discountAmount;
  @override
  final String total;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'promo_code')
  final String? promoCode;

  @override
  String toString() {
    return 'CartDto(id: $id, items: $items, subtotal: $subtotal, discountAmount: $discountAmount, total: $total, currency: $currency, promoCode: $promoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.promoCode, promoCode) ||
                other.promoCode == promoCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_items),
      subtotal,
      discountAmount,
      total,
      currency,
      promoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartDtoImplCopyWith<_$CartDtoImpl> get copyWith =>
      __$$CartDtoImplCopyWithImpl<_$CartDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartDtoImplToJson(
      this,
    );
  }
}

abstract class _CartDto implements CartDto {
  const factory _CartDto(
      {required final int id,
      final List<CartItemDto> items,
      required final String subtotal,
      @JsonKey(name: 'discount_amount') final String discountAmount,
      required final String total,
      final String currency,
      @JsonKey(name: 'promo_code') final String? promoCode}) = _$CartDtoImpl;

  factory _CartDto.fromJson(Map<String, dynamic> json) = _$CartDtoImpl.fromJson;

  @override
  int get id;
  @override
  List<CartItemDto> get items;
  @override
  String get subtotal;
  @override
  @JsonKey(name: 'discount_amount')
  String get discountAmount;
  @override
  String get total;
  @override
  String get currency;
  @override
  @JsonKey(name: 'promo_code')
  String? get promoCode;
  @override
  @JsonKey(ignore: true)
  _$$CartDtoImplCopyWith<_$CartDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddCartItemDto _$AddCartItemDtoFromJson(Map<String, dynamic> json) {
  return _AddCartItemDto.fromJson(json);
}

/// @nodoc
mixin _$AddCartItemDto {
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddCartItemDtoCopyWith<AddCartItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCartItemDtoCopyWith<$Res> {
  factory $AddCartItemDtoCopyWith(
          AddCartItemDto value, $Res Function(AddCartItemDto) then) =
      _$AddCartItemDtoCopyWithImpl<$Res, AddCartItemDto>;
  @useResult
  $Res call({@JsonKey(name: 'product_id') int productId, int quantity});
}

/// @nodoc
class _$AddCartItemDtoCopyWithImpl<$Res, $Val extends AddCartItemDto>
    implements $AddCartItemDtoCopyWith<$Res> {
  _$AddCartItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCartItemDtoImplCopyWith<$Res>
    implements $AddCartItemDtoCopyWith<$Res> {
  factory _$$AddCartItemDtoImplCopyWith(_$AddCartItemDtoImpl value,
          $Res Function(_$AddCartItemDtoImpl) then) =
      __$$AddCartItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'product_id') int productId, int quantity});
}

/// @nodoc
class __$$AddCartItemDtoImplCopyWithImpl<$Res>
    extends _$AddCartItemDtoCopyWithImpl<$Res, _$AddCartItemDtoImpl>
    implements _$$AddCartItemDtoImplCopyWith<$Res> {
  __$$AddCartItemDtoImplCopyWithImpl(
      _$AddCartItemDtoImpl _value, $Res Function(_$AddCartItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_$AddCartItemDtoImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddCartItemDtoImpl implements _AddCartItemDto {
  const _$AddCartItemDtoImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      required this.quantity});

  factory _$AddCartItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddCartItemDtoImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'AddCartItemDto(productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCartItemDtoImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCartItemDtoImplCopyWith<_$AddCartItemDtoImpl> get copyWith =>
      __$$AddCartItemDtoImplCopyWithImpl<_$AddCartItemDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddCartItemDtoImplToJson(
      this,
    );
  }
}

abstract class _AddCartItemDto implements AddCartItemDto {
  const factory _AddCartItemDto(
      {@JsonKey(name: 'product_id') required final int productId,
      required final int quantity}) = _$AddCartItemDtoImpl;

  factory _AddCartItemDto.fromJson(Map<String, dynamic> json) =
      _$AddCartItemDtoImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$AddCartItemDtoImplCopyWith<_$AddCartItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromoResponseDto _$PromoResponseDtoFromJson(Map<String, dynamic> json) {
  return _PromoResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PromoResponseDto {
  bool get valid => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  String? get discountAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromoResponseDtoCopyWith<PromoResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoResponseDtoCopyWith<$Res> {
  factory $PromoResponseDtoCopyWith(
          PromoResponseDto value, $Res Function(PromoResponseDto) then) =
      _$PromoResponseDtoCopyWithImpl<$Res, PromoResponseDto>;
  @useResult
  $Res call(
      {bool valid,
      String? message,
      @JsonKey(name: 'discount_amount') String? discountAmount});
}

/// @nodoc
class _$PromoResponseDtoCopyWithImpl<$Res, $Val extends PromoResponseDto>
    implements $PromoResponseDtoCopyWith<$Res> {
  _$PromoResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valid = null,
    Object? message = freezed,
    Object? discountAmount = freezed,
  }) {
    return _then(_value.copyWith(
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromoResponseDtoImplCopyWith<$Res>
    implements $PromoResponseDtoCopyWith<$Res> {
  factory _$$PromoResponseDtoImplCopyWith(_$PromoResponseDtoImpl value,
          $Res Function(_$PromoResponseDtoImpl) then) =
      __$$PromoResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool valid,
      String? message,
      @JsonKey(name: 'discount_amount') String? discountAmount});
}

/// @nodoc
class __$$PromoResponseDtoImplCopyWithImpl<$Res>
    extends _$PromoResponseDtoCopyWithImpl<$Res, _$PromoResponseDtoImpl>
    implements _$$PromoResponseDtoImplCopyWith<$Res> {
  __$$PromoResponseDtoImplCopyWithImpl(_$PromoResponseDtoImpl _value,
      $Res Function(_$PromoResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? valid = null,
    Object? message = freezed,
    Object? discountAmount = freezed,
  }) {
    return _then(_$PromoResponseDtoImpl(
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromoResponseDtoImpl implements _PromoResponseDto {
  const _$PromoResponseDtoImpl(
      {required this.valid,
      this.message,
      @JsonKey(name: 'discount_amount') this.discountAmount});

  factory _$PromoResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoResponseDtoImplFromJson(json);

  @override
  final bool valid;
  @override
  final String? message;
  @override
  @JsonKey(name: 'discount_amount')
  final String? discountAmount;

  @override
  String toString() {
    return 'PromoResponseDto(valid: $valid, message: $message, discountAmount: $discountAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoResponseDtoImpl &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, valid, message, discountAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoResponseDtoImplCopyWith<_$PromoResponseDtoImpl> get copyWith =>
      __$$PromoResponseDtoImplCopyWithImpl<_$PromoResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _PromoResponseDto implements PromoResponseDto {
  const factory _PromoResponseDto(
          {required final bool valid,
          final String? message,
          @JsonKey(name: 'discount_amount') final String? discountAmount}) =
      _$PromoResponseDtoImpl;

  factory _PromoResponseDto.fromJson(Map<String, dynamic> json) =
      _$PromoResponseDtoImpl.fromJson;

  @override
  bool get valid;
  @override
  String? get message;
  @override
  @JsonKey(name: 'discount_amount')
  String? get discountAmount;
  @override
  @JsonKey(ignore: true)
  _$$PromoResponseDtoImplCopyWith<_$PromoResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
