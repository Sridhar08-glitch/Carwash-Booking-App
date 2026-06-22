// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemDtoImpl _$$OrderItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemDtoImpl(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      productName: json['product_name'] as String,
      productImage: json['product_image'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: json['unit_price'] as String,
      lineTotal: json['line_total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
    );

Map<String, dynamic> _$$OrderItemDtoImplToJson(_$OrderItemDtoImpl instance) =>
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

_$OrderDtoImpl _$$OrderDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderDtoImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      deliveryMethod: json['delivery_method'] as String,
      createdAt: json['created_at'] as String,
      paymentStatus: json['payment_status'] as String?,
      trackingStatus: json['tracking_status'] as String?,
    );

Map<String, dynamic> _$$OrderDtoImplToJson(_$OrderDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'items': instance.items,
      'total': instance.total,
      'currency': instance.currency,
      'delivery_method': instance.deliveryMethod,
      'created_at': instance.createdAt,
      'payment_status': instance.paymentStatus,
      'tracking_status': instance.trackingStatus,
    };

_$OrderListItemDtoImpl _$$OrderListItemDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderListItemDtoImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      itemCount: (json['item_count'] as num).toInt(),
      total: json['total'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$OrderListItemDtoImplToJson(
        _$OrderListItemDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'item_count': instance.itemCount,
      'total': instance.total,
      'currency': instance.currency,
      'created_at': instance.createdAt,
    };
