// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemDtoImpl _$$CartItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$CartItemDtoImpl(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String,
      productImage: json['product_image'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: json['unit_price'] as String,
      lineTotal: json['line_total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
    );

Map<String, dynamic> _$$CartItemDtoImplToJson(_$CartItemDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_image': instance.productImage,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'line_total': instance.lineTotal,
      'currency': instance.currency,
    };

_$CartDtoImpl _$$CartDtoImplFromJson(Map<String, dynamic> json) =>
    _$CartDtoImpl(
      id: (json['id'] as num).toInt(),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: json['subtotal'] as String,
      discountAmount: json['discount_amount'] as String? ?? '0.00',
      total: json['total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      promoCode: json['promo_code'] as String?,
    );

Map<String, dynamic> _$$CartDtoImplToJson(_$CartDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'subtotal': instance.subtotal,
      'discount_amount': instance.discountAmount,
      'total': instance.total,
      'currency': instance.currency,
      'promo_code': instance.promoCode,
    };

_$AddCartItemDtoImpl _$$AddCartItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$AddCartItemDtoImpl(
      productId: (json['product_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$AddCartItemDtoImplToJson(
        _$AddCartItemDtoImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quantity': instance.quantity,
    };

_$PromoResponseDtoImpl _$$PromoResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PromoResponseDtoImpl(
      valid: json['valid'] as bool,
      message: json['message'] as String?,
      discountAmount: json['discount_amount'] as String?,
    );

Map<String, dynamic> _$$PromoResponseDtoImplToJson(
        _$PromoResponseDtoImpl instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'message': instance.message,
      'discount_amount': instance.discountAmount,
    };
