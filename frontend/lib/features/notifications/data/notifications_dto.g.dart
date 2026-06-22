// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDtoImpl _$$NotificationDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDtoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      read: json['read'] as bool? ?? false,
      createdAt: json['created_at'] as String,
      type: json['type'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationDtoImplToJson(
        _$NotificationDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'read': instance.read,
      'created_at': instance.createdAt,
      'type': instance.type,
      'data': instance.data,
    };

_$NotificationSettingsDtoImpl _$$NotificationSettingsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsDtoImpl(
      bookingUpdates: json['booking_updates'] as bool? ?? true,
      orderUpdates: json['order_updates'] as bool? ?? true,
      promotions: json['promotions'] as bool? ?? true,
      loyalty: json['loyalty'] as bool? ?? true,
    );

Map<String, dynamic> _$$NotificationSettingsDtoImplToJson(
        _$NotificationSettingsDtoImpl instance) =>
    <String, dynamic>{
      'booking_updates': instance.bookingUpdates,
      'order_updates': instance.orderUpdates,
      'promotions': instance.promotions,
      'loyalty': instance.loyalty,
    };
