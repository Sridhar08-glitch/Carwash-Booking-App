import 'package:freezed_annotation/freezed_annotation.dart';

part 'memberships_dto.freezed.dart';
part 'memberships_dto.g.dart';

@freezed
class MembershipPlanDto with _$MembershipPlanDto {
  const factory MembershipPlanDto({
    required int id,
    required String name,
    required String description,
    required String price,
    @Default('SAR') String currency,
    @JsonKey(name: 'billing_period') required String billingPeriod,
    @JsonKey(name: 'washes_per_period') required int washesPerPeriod,
    @JsonKey(name: 'discount_percent') @Default(0) int discountPercent,
    @Default([]) List<String> features,
  }) = _MembershipPlanDto;

  factory MembershipPlanDto.fromJson(Map<String, dynamic> json) =>
      _$MembershipPlanDtoFromJson(json);
}

@freezed
class MyMembershipDto with _$MyMembershipDto {
  const factory MyMembershipDto({
    required int id,
    required MembershipPlanDto plan,
    required String status,
    @JsonKey(name: 'current_period_start') required String currentPeriodStart,
    @JsonKey(name: 'current_period_end') required String currentPeriodEnd,
    @JsonKey(name: 'washes_used') required int washesUsed,
    @JsonKey(name: 'cancel_at_period_end') @Default(false) bool cancelAtPeriodEnd,
  }) = _MyMembershipDto;

  factory MyMembershipDto.fromJson(Map<String, dynamic> json) =>
      _$MyMembershipDtoFromJson(json);
}
