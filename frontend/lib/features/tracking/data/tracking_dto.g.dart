// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingPingDtoImpl _$$TrackingPingDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TrackingPingDtoImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      etaMinutes: (json['eta_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TrackingPingDtoImplToJson(
        _$TrackingPingDtoImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'eta_minutes': instance.etaMinutes,
    };

_$TrackingStatusDtoImpl _$$TrackingStatusDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TrackingStatusDtoImpl(
      bookingStatus: json['booking_status'] as String,
    );

Map<String, dynamic> _$$TrackingStatusDtoImplToJson(
        _$TrackingStatusDtoImpl instance) =>
    <String, dynamic>{
      'booking_status': instance.bookingStatus,
    };
