// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberships_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MembershipPlanDtoImpl _$$MembershipPlanDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MembershipPlanDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      billingPeriod: json['billing_period'] as String,
      washesPerPeriod: (json['washes_per_period'] as num).toInt(),
      discountPercent: (json['discount_percent'] as num?)?.toInt() ?? 0,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MembershipPlanDtoImplToJson(
        _$MembershipPlanDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'billing_period': instance.billingPeriod,
      'washes_per_period': instance.washesPerPeriod,
      'discount_percent': instance.discountPercent,
      'features': instance.features,
    };

_$MyMembershipDtoImpl _$$MyMembershipDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$MyMembershipDtoImpl(
      id: (json['id'] as num).toInt(),
      plan: MembershipPlanDto.fromJson(json['plan'] as Map<String, dynamic>),
      status: json['status'] as String,
      currentPeriodStart: json['current_period_start'] as String,
      currentPeriodEnd: json['current_period_end'] as String,
      washesUsed: (json['washes_used'] as num).toInt(),
      cancelAtPeriodEnd: json['cancel_at_period_end'] as bool? ?? false,
    );

Map<String, dynamic> _$$MyMembershipDtoImplToJson(
        _$MyMembershipDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan': instance.plan,
      'status': instance.status,
      'current_period_start': instance.currentPeriodStart,
      'current_period_end': instance.currentPeriodEnd,
      'washes_used': instance.washesUsed,
      'cancel_at_period_end': instance.cancelAtPeriodEnd,
    };
