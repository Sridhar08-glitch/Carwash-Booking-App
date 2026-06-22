import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

// ---------------------------------------------------------------------------
// Request DTOs
// ---------------------------------------------------------------------------

@freezed
class OtpRequestDto with _$OtpRequestDto {
  const factory OtpRequestDto({required String phone}) = _OtpRequestDto;
  factory OtpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestDtoFromJson(json);
}

@freezed
class OtpVerifyDto with _$OtpVerifyDto {
  const factory OtpVerifyDto({
    required String phone,
    required String code,
  }) = _OtpVerifyDto;
  factory OtpVerifyDto.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyDtoFromJson(json);
}

@freezed
class RefreshDto with _$RefreshDto {
  const factory RefreshDto({required String refresh}) = _RefreshDto;
  factory RefreshDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshDtoFromJson(json);
}

// ---------------------------------------------------------------------------
// Response DTOs — map directly to the backend contract
// ---------------------------------------------------------------------------

@freezed
class TokensDto with _$TokensDto {
  const factory TokensDto({
    required String access,
    required String refresh,
  }) = _TokensDto;
  factory TokensDto.fromJson(Map<String, dynamic> json) =>
      _$TokensDtoFromJson(json);
}

@freezed
class AuthUserDto with _$AuthUserDto {
  const factory AuthUserDto({
    required int id,
    required String phone,
    String? email,
    required String role,
    @JsonKey(name: 'is_phone_verified') @Default(false) bool isPhoneVerified,
  }) = _AuthUserDto;
  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);
}

@freezed
class OtpVerifyResponseDto with _$OtpVerifyResponseDto {
  const factory OtpVerifyResponseDto({
    required TokensDto tokens,
    required AuthUserDto user,
    @JsonKey(name: 'is_new') @Default(false) bool isNew,
  }) = _OtpVerifyResponseDto;
  factory OtpVerifyResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseDtoFromJson(json);
}
