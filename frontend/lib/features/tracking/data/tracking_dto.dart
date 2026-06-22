import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracking_dto.freezed.dart';
part 'tracking_dto.g.dart';

@freezed
class TrackingPingDto with _$TrackingPingDto {
  const factory TrackingPingDto({
    required double lat,
    required double lng,
    @JsonKey(name: 'eta_minutes') int? etaMinutes,
  }) = _TrackingPingDto;

  factory TrackingPingDto.fromJson(Map<String, dynamic> json) =>
      _$TrackingPingDtoFromJson(json);
}

@freezed
class TrackingStatusDto with _$TrackingStatusDto {
  const factory TrackingStatusDto({
    @JsonKey(name: 'booking_status') required String bookingStatus,
  }) = _TrackingStatusDto;

  factory TrackingStatusDto.fromJson(Map<String, dynamic> json) =>
      _$TrackingStatusDtoFromJson(json);
}

// Union for what the customer receives on the WS
sealed class TrackingEvent {}

class TrackingPingEvent extends TrackingEvent {
  TrackingPingEvent(this.ping);
  final TrackingPingDto ping;
}

class TrackingStatusEvent extends TrackingEvent {
  TrackingStatusEvent(this.status);
  final TrackingStatusDto status;
}

class TrackingErrorEvent extends TrackingEvent {
  TrackingErrorEvent(this.message);
  final String message;
}
