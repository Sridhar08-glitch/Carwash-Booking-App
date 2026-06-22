import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

@freezed
class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    required int id,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_image') String? productImage,
    required int quantity,
    @JsonKey(name: 'unit_price') required String unitPrice,
    @JsonKey(name: 'line_total') required String lineTotal,
    @Default('SAR') String currency,
  }) = _CartItemDto;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
}

@freezed
class CartDto with _$CartDto {
  const factory CartDto({
    required int id,
    @Default([]) List<CartItemDto> items,
    required String subtotal,
    @JsonKey(name: 'discount_amount') @Default('0.00') String discountAmount,
    required String total,
    @Default('SAR') String currency,
    @JsonKey(name: 'promo_code') String? promoCode,
  }) = _CartDto;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
}

@freezed
class AddCartItemDto with _$AddCartItemDto {
  const factory AddCartItemDto({
    @JsonKey(name: 'product_id') required int productId,
    required int quantity,
  }) = _AddCartItemDto;

  factory AddCartItemDto.fromJson(Map<String, dynamic> json) =>
      _$AddCartItemDtoFromJson(json);
}

@freezed
class PromoResponseDto with _$PromoResponseDto {
  const factory PromoResponseDto({
    required bool valid,
    String? message,
    @JsonKey(name: 'discount_amount') String? discountAmount,
  }) = _PromoResponseDto;

  factory PromoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PromoResponseDtoFromJson(json);
}
