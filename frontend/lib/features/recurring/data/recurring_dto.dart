import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_dto.freezed.dart';
part 'recurring_dto.g.dart';

@freezed
class RecurringRuleDto with _$RecurringRuleDto {
  const factory RecurringRuleDto({
    required int id,
    @JsonKey(name: 'service_id') required int serviceId,
    @JsonKey(name: 'service_name') required String serviceName,
    @JsonKey(name: 'branch_id') int? branchId,
    @JsonKey(name: 'branch_name') String? branchName,
    /// e.g. "weekly", "biweekly", "monthly"
    required String frequency,
    /// day-of-week 0=Mon…6=Sun for weekly/biweekly; day-of-month 1..28 for monthly
    @JsonKey(name: 'day_value') required int dayValue,
    /// "HH:mm" preferred start time
    @JsonKey(name: 'preferred_time') required String preferredTime,
    @JsonKey(name: 'location_type') required String locationType,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'next_booking_date') String? nextBookingDate,
  }) = _RecurringRuleDto;

  factory RecurringRuleDto.fromJson(Map<String, dynamic> json) =>
      _$RecurringRuleDtoFromJson(json);
}

@freezed
class CreateRecurringDto with _$CreateRecurringDto {
  const factory CreateRecurringDto({
    @JsonKey(name: 'service_id') required int serviceId,
    @JsonKey(name: 'branch_id') int? branchId,
    required String frequency,
    @JsonKey(name: 'day_value') required int dayValue,
    @JsonKey(name: 'preferred_time') required String preferredTime,
    @JsonKey(name: 'location_type') required String locationType,
  }) = _CreateRecurringDto;

  factory CreateRecurringDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRecurringDtoFromJson(json);
}
