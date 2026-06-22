import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_dto.freezed.dart';
part 'orders_dto.g.dart';

@freezed
class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required int id,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_image') String? productImage,
    required int quantity,
    @JsonKey(name: 'unit_price') required String unitPrice,
    @JsonKey(name: 'line_total') required String lineTotal,
    @Default('SAR') String currency,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
}

@freezed
class OrderDto with _$OrderDto {
  const factory OrderDto({
    required int id,
    required String status,
    @Default([]) List<OrderItemDto> items,
    required String total,
    @Default('SAR') String currency,
    @JsonKey(name: 'delivery_method') required String deliveryMethod,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    @JsonKey(name: 'tracking_status') String? trackingStatus,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}

@freezed
class OrderListItemDto with _$OrderListItemDto {
  const factory OrderListItemDto({
    required int id,
    required String status,
    @JsonKey(name: 'item_count') required int itemCount,
    required String total,
    @Default('SAR') String currency,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _OrderListItemDto;

  factory OrderListItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderListItemDtoFromJson(json);
}
