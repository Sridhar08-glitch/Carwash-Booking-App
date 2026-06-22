import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_dto.freezed.dart';
part 'home_dto.g.dart';

/// A single section in the server-driven home layout.
/// The app renders section types it knows; unknown types are skipped
/// (forward-compatible).
@freezed
class HomeSectionDto with _$HomeSectionDto {
  const factory HomeSectionDto({
    required String type,
    String? title,
    String? text,
    String? cta,
    String? image,
    @JsonKey(name: 'deep_link') String? deepLink,
    String? source,
    @JsonKey(name: 'valid_from') String? validFrom,
    @JsonKey(name: 'valid_until') String? validUntil,
    // Hero carousel: list of banner objects
    @Default([]) List<BannerDto> banners,
  }) = _HomeSectionDto;

  factory HomeSectionDto.fromJson(Map<String, dynamic> json) =>
      _$HomeSectionDtoFromJson(json);
}

@freezed
class BannerDto with _$BannerDto {
  const factory BannerDto({
    required String title,
    String? subtitle,
    String? cta,
    String? image,
    String? gradient,
    @JsonKey(name: 'deep_link') String? deepLink,
    @JsonKey(name: 'valid_until') String? validUntil,
  }) = _BannerDto;

  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);
}
