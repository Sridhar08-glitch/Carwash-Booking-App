// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeSectionDtoImpl _$$HomeSectionDtoImplFromJson(Map<String, dynamic> json) =>
    _$HomeSectionDtoImpl(
      type: json['type'] as String,
      title: json['title'] as String?,
      text: json['text'] as String?,
      cta: json['cta'] as String?,
      image: json['image'] as String?,
      deepLink: json['deep_link'] as String?,
      source: json['source'] as String?,
      validFrom: json['valid_from'] as String?,
      validUntil: json['valid_until'] as String?,
      banners: (json['banners'] as List<dynamic>?)
              ?.map((e) => BannerDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HomeSectionDtoImplToJson(
        _$HomeSectionDtoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'text': instance.text,
      'cta': instance.cta,
      'image': instance.image,
      'deep_link': instance.deepLink,
      'source': instance.source,
      'valid_from': instance.validFrom,
      'valid_until': instance.validUntil,
      'banners': instance.banners,
    };

_$BannerDtoImpl _$$BannerDtoImplFromJson(Map<String, dynamic> json) =>
    _$BannerDtoImpl(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      cta: json['cta'] as String?,
      image: json['image'] as String?,
      gradient: json['gradient'] as String?,
      deepLink: json['deep_link'] as String?,
      validUntil: json['valid_until'] as String?,
    );

Map<String, dynamic> _$$BannerDtoImplToJson(_$BannerDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'cta': instance.cta,
      'image': instance.image,
      'gradient': instance.gradient,
      'deep_link': instance.deepLink,
      'valid_until': instance.validUntil,
    };
