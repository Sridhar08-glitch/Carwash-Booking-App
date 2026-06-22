// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoyaltyTierDtoImpl _$$LoyaltyTierDtoImplFromJson(Map<String, dynamic> json) =>
    _$LoyaltyTierDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      minWashes: (json['min_washes'] as num).toInt(),
      discountPercent: (json['discount_percent'] as num).toInt(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$LoyaltyTierDtoImplToJson(
        _$LoyaltyTierDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'min_washes': instance.minWashes,
      'discount_percent': instance.discountPercent,
      'color': instance.color,
    };

_$LoyaltyStatusDtoImpl _$$LoyaltyStatusDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$LoyaltyStatusDtoImpl(
      washesCount: (json['washes_count'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      currentTier: json['current_tier'] == null
          ? null
          : LoyaltyTierDto.fromJson(
              json['current_tier'] as Map<String, dynamic>),
      nextTier: json['next_tier'] == null
          ? null
          : LoyaltyTierDto.fromJson(json['next_tier'] as Map<String, dynamic>),
      washesToNext: (json['washes_to_next'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LoyaltyStatusDtoImplToJson(
        _$LoyaltyStatusDtoImpl instance) =>
    <String, dynamic>{
      'washes_count': instance.washesCount,
      'points': instance.points,
      'current_tier': instance.currentTier,
      'next_tier': instance.nextTier,
      'washes_to_next': instance.washesToNext,
    };

_$ReferralDtoImpl _$$ReferralDtoImplFromJson(Map<String, dynamic> json) =>
    _$ReferralDtoImpl(
      referralCode: json['referral_code'] as String,
      totalReferrals: (json['total_referrals'] as num?)?.toInt() ?? 0,
      pointsEarned: (json['points_earned'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ReferralDtoImplToJson(_$ReferralDtoImpl instance) =>
    <String, dynamic>{
      'referral_code': instance.referralCode,
      'total_referrals': instance.totalReferrals,
      'points_earned': instance.pointsEarned,
    };
