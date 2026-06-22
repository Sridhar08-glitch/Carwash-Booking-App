import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_dto.freezed.dart';
part 'services_dto.g.dart';

@freezed
class ServiceCategoryDto with _$ServiceCategoryDto {
  const factory ServiceCategoryDto({
    required int id,
    required String name,
  }) = _ServiceCategoryDto;
  factory ServiceCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryDtoFromJson(json);
}

@freezed
class ServiceDto with _$ServiceDto {
  const factory ServiceDto({
    required int id,
    required String name,
    required String slug,
    @Default('') String description,
    @JsonKey(name: 'base_price') required String basePrice,
    @Default('SAR') String currency,
    @JsonKey(name: 'duration_minutes') @Default(60) int durationMinutes,
    ServiceCategoryDto? category,
    @Default([]) List<String> tags,
    @JsonKey(name: 'is_mobile_available') @Default(false) bool isMobileAvailable,
    String? image,
  }) = _ServiceDto;
  factory ServiceDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceDtoFromJson(json);
}

@freezed
class BranchHoursDto with _$BranchHoursDto {
  const factory BranchHoursDto({
    required int weekday,
    @JsonKey(name: 'open_time') required String openTime,
    @JsonKey(name: 'close_time') required String closeTime,
    @JsonKey(name: 'is_closed') @Default(false) bool isClosed,
  }) = _BranchHoursDto;
  factory BranchHoursDto.fromJson(Map<String, dynamic> json) =>
      _$BranchHoursDtoFromJson(json);
}

@freezed
class BranchDto with _$BranchDto {
  const factory BranchDto({
    required int id,
    required String name,
    @Default('') String city,
    @Default('0.000000') String lat,
    @Default('0.000000') String lng,
    @Default('Asia/Riyadh') String timezone,
    @Default([]) List<BranchHoursDto> hours,
  }) = _BranchDto;
  factory BranchDto.fromJson(Map<String, dynamic> json) =>
      _$BranchDtoFromJson(json);
}
