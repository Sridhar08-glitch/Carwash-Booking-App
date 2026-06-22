import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_dto.freezed.dart';
part 'staff_dto.g.dart';

@freezed
class StaffTaskDto with _$StaffTaskDto {
  const factory StaffTaskDto({
    required int id,
    required String label,
    @Default(false) bool completed,
  }) = _StaffTaskDto;

  factory StaffTaskDto.fromJson(Map<String, dynamic> json) =>
      _$StaffTaskDtoFromJson(json);
}

@freezed
class StaffJobDto with _$StaffJobDto {
  const factory StaffJobDto({
    @JsonKey(name: 'booking_id') required int bookingId,
    @JsonKey(name: 'customer_name') required String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'service_name') required String serviceName,
    @JsonKey(name: 'location_type') required String locationType,
    @JsonKey(name: 'branch_name') String? branchName,
    String? address,
    required String status,
    @JsonKey(name: 'scheduled_at') required String scheduledAt,
    @JsonKey(name: 'vehicle_info') String? vehicleInfo,
    @Default([]) List<StaffTaskDto> tasks,
    @JsonKey(name: 'before_photos') @Default([]) List<String> beforePhotos,
    @JsonKey(name: 'after_photos') @Default([]) List<String> afterPhotos,
    @JsonKey(name: 'eta_minutes') int? etaMinutes,
  }) = _StaffJobDto;

  factory StaffJobDto.fromJson(Map<String, dynamic> json) =>
      _$StaffJobDtoFromJson(json);
}

@freezed
class StaffJobListItemDto with _$StaffJobListItemDto {
  const factory StaffJobListItemDto({
    @JsonKey(name: 'booking_id') required int bookingId,
    @JsonKey(name: 'customer_name') required String customerName,
    @JsonKey(name: 'service_name') required String serviceName,
    required String status,
    @JsonKey(name: 'scheduled_at') required String scheduledAt,
    @JsonKey(name: 'location_type') required String locationType,
  }) = _StaffJobListItemDto;

  factory StaffJobListItemDto.fromJson(Map<String, dynamic> json) =>
      _$StaffJobListItemDtoFromJson(json);
}

@freezed
class PresignResponseDto with _$PresignResponseDto {
  const factory PresignResponseDto({
    @JsonKey(name: 'upload_url') required String uploadUrl,
    @JsonKey(name: 's3_key') required String s3Key,
  }) = _PresignResponseDto;

  factory PresignResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PresignResponseDtoFromJson(json);
}
