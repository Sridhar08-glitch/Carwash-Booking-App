// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffTaskDtoImpl _$$StaffTaskDtoImplFromJson(Map<String, dynamic> json) =>
    _$StaffTaskDtoImpl(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String,
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$StaffTaskDtoImplToJson(_$StaffTaskDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'completed': instance.completed,
    };

_$StaffJobDtoImpl _$$StaffJobDtoImplFromJson(Map<String, dynamic> json) =>
    _$StaffJobDtoImpl(
      bookingId: (json['booking_id'] as num).toInt(),
      customerName: json['customer_name'] as String,
      customerPhone: json['customer_phone'] as String?,
      serviceName: json['service_name'] as String,
      locationType: json['location_type'] as String,
      branchName: json['branch_name'] as String?,
      address: json['address'] as String?,
      status: json['status'] as String,
      scheduledAt: json['scheduled_at'] as String,
      vehicleInfo: json['vehicle_info'] as String?,
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((e) => StaffTaskDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      beforePhotos: (json['before_photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      afterPhotos: (json['after_photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      etaMinutes: (json['eta_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$StaffJobDtoImplToJson(_$StaffJobDtoImpl instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'service_name': instance.serviceName,
      'location_type': instance.locationType,
      'branch_name': instance.branchName,
      'address': instance.address,
      'status': instance.status,
      'scheduled_at': instance.scheduledAt,
      'vehicle_info': instance.vehicleInfo,
      'tasks': instance.tasks,
      'before_photos': instance.beforePhotos,
      'after_photos': instance.afterPhotos,
      'eta_minutes': instance.etaMinutes,
    };

_$StaffJobListItemDtoImpl _$$StaffJobListItemDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$StaffJobListItemDtoImpl(
      bookingId: (json['booking_id'] as num).toInt(),
      customerName: json['customer_name'] as String,
      serviceName: json['service_name'] as String,
      status: json['status'] as String,
      scheduledAt: json['scheduled_at'] as String,
      locationType: json['location_type'] as String,
    );

Map<String, dynamic> _$$StaffJobListItemDtoImplToJson(
        _$StaffJobListItemDtoImpl instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'customer_name': instance.customerName,
      'service_name': instance.serviceName,
      'status': instance.status,
      'scheduled_at': instance.scheduledAt,
      'location_type': instance.locationType,
    };

_$PresignResponseDtoImpl _$$PresignResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PresignResponseDtoImpl(
      uploadUrl: json['upload_url'] as String,
      s3Key: json['s3_key'] as String,
    );

Map<String, dynamic> _$$PresignResponseDtoImplToJson(
        _$PresignResponseDtoImpl instance) =>
    <String, dynamic>{
      'upload_url': instance.uploadUrl,
      's3_key': instance.s3Key,
    };
