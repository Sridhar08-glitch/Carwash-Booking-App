import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_dto.freezed.dart';
part 'notifications_dto.g.dart';

@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required int id,
    required String title,
    required String body,
    @Default(false) bool read,
    @JsonKey(name: 'created_at') required String createdAt,
    String? type,
    Map<String, dynamic>? data,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

@freezed
class NotificationSettingsDto with _$NotificationSettingsDto {
  const factory NotificationSettingsDto({
    @JsonKey(name: 'booking_updates') @Default(true) bool bookingUpdates,
    @JsonKey(name: 'order_updates') @Default(true) bool orderUpdates,
    @JsonKey(name: 'promotions') @Default(true) bool promotions,
    @JsonKey(name: 'loyalty') @Default(true) bool loyalty,
  }) = _NotificationSettingsDto;

  factory NotificationSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsDtoFromJson(json);
}
