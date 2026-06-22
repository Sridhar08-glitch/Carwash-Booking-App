// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpRequestDtoImpl _$$OtpRequestDtoImplFromJson(Map<String, dynamic> json) =>
    _$OtpRequestDtoImpl(
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$OtpRequestDtoImplToJson(_$OtpRequestDtoImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
    };

_$OtpVerifyDtoImpl _$$OtpVerifyDtoImplFromJson(Map<String, dynamic> json) =>
    _$OtpVerifyDtoImpl(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$$OtpVerifyDtoImplToJson(_$OtpVerifyDtoImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
    };

_$RefreshDtoImpl _$$RefreshDtoImplFromJson(Map<String, dynamic> json) =>
    _$RefreshDtoImpl(
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$$RefreshDtoImplToJson(_$RefreshDtoImpl instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
    };

_$TokensDtoImpl _$$TokensDtoImplFromJson(Map<String, dynamic> json) =>
    _$TokensDtoImpl(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$$TokensDtoImplToJson(_$TokensDtoImpl instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

_$AuthUserDtoImpl _$$AuthUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserDtoImpl(
      id: (json['id'] as num).toInt(),
      phone: json['phone'] as String,
      email: json['email'] as String?,
      role: json['role'] as String,
      isPhoneVerified: json['is_phone_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthUserDtoImplToJson(_$AuthUserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'role': instance.role,
      'is_phone_verified': instance.isPhoneVerified,
    };

_$OtpVerifyResponseDtoImpl _$$OtpVerifyResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OtpVerifyResponseDtoImpl(
      tokens: TokensDto.fromJson(json['tokens'] as Map<String, dynamic>),
      user: AuthUserDto.fromJson(json['user'] as Map<String, dynamic>),
      isNew: json['is_new'] as bool? ?? false,
    );

Map<String, dynamic> _$$OtpVerifyResponseDtoImplToJson(
        _$OtpVerifyResponseDtoImpl instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
      'user': instance.user,
      'is_new': instance.isNew,
    };
