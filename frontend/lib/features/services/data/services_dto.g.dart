// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceCategoryDtoImpl _$$ServiceCategoryDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceCategoryDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ServiceCategoryDtoImplToJson(
        _$ServiceCategoryDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$ServiceDtoImpl _$$ServiceDtoImplFromJson(Map<String, dynamic> json) =>
    _$ServiceDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String? ?? '',
      basePrice: json['base_price'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 60,
      category: json['category'] == null
          ? null
          : ServiceCategoryDto.fromJson(
              json['category'] as Map<String, dynamic>),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isMobileAvailable: json['is_mobile_available'] as bool? ?? false,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$ServiceDtoImplToJson(_$ServiceDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'base_price': instance.basePrice,
      'currency': instance.currency,
      'duration_minutes': instance.durationMinutes,
      'category': instance.category,
      'tags': instance.tags,
      'is_mobile_available': instance.isMobileAvailable,
      'image': instance.image,
    };

_$BranchHoursDtoImpl _$$BranchHoursDtoImplFromJson(Map<String, dynamic> json) =>
    _$BranchHoursDtoImpl(
      weekday: (json['weekday'] as num).toInt(),
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
      isClosed: json['is_closed'] as bool? ?? false,
    );

Map<String, dynamic> _$$BranchHoursDtoImplToJson(
        _$BranchHoursDtoImpl instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'is_closed': instance.isClosed,
    };

_$BranchDtoImpl _$$BranchDtoImplFromJson(Map<String, dynamic> json) =>
    _$BranchDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      city: json['city'] as String? ?? '',
      lat: json['lat'] as String? ?? '0.000000',
      lng: json['lng'] as String? ?? '0.000000',
      timezone: json['timezone'] as String? ?? 'Asia/Riyadh',
      hours: (json['hours'] as List<dynamic>?)
              ?.map((e) => BranchHoursDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BranchDtoImplToJson(_$BranchDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'lat': instance.lat,
      'lng': instance.lng,
      'timezone': instance.timezone,
      'hours': instance.hours,
    };
