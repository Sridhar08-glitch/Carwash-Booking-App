// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecurringRuleDtoImpl _$$RecurringRuleDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$RecurringRuleDtoImpl(
      id: (json['id'] as num).toInt(),
      serviceId: (json['service_id'] as num).toInt(),
      serviceName: json['service_name'] as String,
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      frequency: json['frequency'] as String,
      dayValue: (json['day_value'] as num).toInt(),
      preferredTime: json['preferred_time'] as String,
      locationType: json['location_type'] as String,
      isActive: json['is_active'] as bool? ?? true,
      nextBookingDate: json['next_booking_date'] as String?,
    );

Map<String, dynamic> _$$RecurringRuleDtoImplToJson(
        _$RecurringRuleDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'frequency': instance.frequency,
      'day_value': instance.dayValue,
      'preferred_time': instance.preferredTime,
      'location_type': instance.locationType,
      'is_active': instance.isActive,
      'next_booking_date': instance.nextBookingDate,
    };

_$CreateRecurringDtoImpl _$$CreateRecurringDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateRecurringDtoImpl(
      serviceId: (json['service_id'] as num).toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      frequency: json['frequency'] as String,
      dayValue: (json['day_value'] as num).toInt(),
      preferredTime: json['preferred_time'] as String,
      locationType: json['location_type'] as String,
    );

Map<String, dynamic> _$$CreateRecurringDtoImplToJson(
        _$CreateRecurringDtoImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'branch_id': instance.branchId,
      'frequency': instance.frequency,
      'day_value': instance.dayValue,
      'preferred_time': instance.preferredTime,
      'location_type': instance.locationType,
    };
