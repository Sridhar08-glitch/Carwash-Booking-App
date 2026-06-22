import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_dto.freezed.dart';
part 'loyalty_dto.g.dart';

@freezed
class LoyaltyTierDto with _$LoyaltyTierDto {
  const factory LoyaltyTierDto({
    required int id,
    required String name,
    @JsonKey(name: 'min_washes') required int minWashes,
    @JsonKey(name: 'discount_percent') required int discountPercent,
    String? color,
  }) = _LoyaltyTierDto;

  factory LoyaltyTierDto.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyTierDtoFromJson(json);
}

@freezed
class LoyaltyStatusDto with _$LoyaltyStatusDto {
  const factory LoyaltyStatusDto({
    @JsonKey(name: 'washes_count') required int washesCount,
    required int points,
    @JsonKey(name: 'current_tier') LoyaltyTierDto? currentTier,
    @JsonKey(name: 'next_tier') LoyaltyTierDto? nextTier,
    @JsonKey(name: 'washes_to_next') int? washesToNext,
  }) = _LoyaltyStatusDto;

  factory LoyaltyStatusDto.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyStatusDtoFromJson(json);
}

@freezed
class ReferralDto with _$ReferralDto {
  const factory ReferralDto({
    @JsonKey(name: 'referral_code') required String referralCode,
    @JsonKey(name: 'total_referrals') @Default(0) int totalReferrals,
    @JsonKey(name: 'points_earned') @Default(0) int pointsEarned,
  }) = _ReferralDto;

  factory ReferralDto.fromJson(Map<String, dynamic> json) =>
      _$ReferralDtoFromJson(json);
}
