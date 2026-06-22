// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlotDtoImpl _$$SlotDtoImplFromJson(Map<String, dynamic> json) =>
    _$SlotDtoImpl(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      capacityLeft: (json['capacity_left'] as num?)?.toInt() ?? 0,
      isAvailable: json['is_available'] as bool? ?? false,
    );

Map<String, dynamic> _$$SlotDtoImplToJson(_$SlotDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'capacity_left': instance.capacityLeft,
      'is_available': instance.isAvailable,
    };

_$CreateBookingDtoImpl _$$CreateBookingDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateBookingDtoImpl(
      serviceId: (json['service_id'] as num).toInt(),
      slotId: (json['slot_id'] as num).toInt(),
      locationType: json['location_type'] as String,
      vehicleId: (json['vehicle_id'] as num?)?.toInt(),
      addressId: (json['address_id'] as num?)?.toInt(),
      mobileLat: json['mobile_lat'] as String?,
      mobileLng: json['mobile_lng'] as String?,
      promoCode: json['promo_code'] as String?,
    );

Map<String, dynamic> _$$CreateBookingDtoImplToJson(
        _$CreateBookingDtoImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'slot_id': instance.slotId,
      'location_type': instance.locationType,
      'vehicle_id': instance.vehicleId,
      'address_id': instance.addressId,
      'mobile_lat': instance.mobileLat,
      'mobile_lng': instance.mobileLng,
      'promo_code': instance.promoCode,
    };

_$BookingPaymentDtoImpl _$$BookingPaymentDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingPaymentDtoImpl(
      id: (json['id'] as num).toInt(),
      method: json['method'] as String,
      status: json['status'] as String,
      clientSecret: json['client_secret'] as String?,
    );

Map<String, dynamic> _$$BookingPaymentDtoImplToJson(
        _$BookingPaymentDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'status': instance.status,
      'client_secret': instance.clientSecret,
    };

_$BookingSlotSummaryDtoImpl _$$BookingSlotSummaryDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingSlotSummaryDtoImpl(
      date: json['date'] as String,
      startTime: json['start_time'] as String,
    );

Map<String, dynamic> _$$BookingSlotSummaryDtoImplToJson(
        _$BookingSlotSummaryDtoImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'start_time': instance.startTime,
    };

_$BookingDtoImpl _$$BookingDtoImplFromJson(Map<String, dynamic> json) =>
    _$BookingDtoImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      priceCharged: json['price_charged'] as String,
      currency: json['currency'] as String? ?? 'SAR',
      payment:
          BookingPaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
      slot:
          BookingSlotSummaryDto.fromJson(json['slot'] as Map<String, dynamic>),
      serviceName: json['service_name'] as String?,
      locationType: json['location_type'] as String? ?? 'branch',
      branchName: json['branch_name'] as String?,
      vehiclePlate: json['vehicle_plate'] as String?,
      createdAt: json['created_at'] as String?,
      canCancel: json['can_cancel'] as bool? ?? false,
      canReschedule: json['can_reschedule'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookingDtoImplToJson(_$BookingDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'price_charged': instance.priceCharged,
      'currency': instance.currency,
      'payment': instance.payment,
      'slot': instance.slot,
      'service_name': instance.serviceName,
      'location_type': instance.locationType,
      'branch_name': instance.branchName,
      'vehicle_plate': instance.vehiclePlate,
      'created_at': instance.createdAt,
      'can_cancel': instance.canCancel,
      'can_reschedule': instance.canReschedule,
    };

_$BookingListItemDtoImpl _$$BookingListItemDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingListItemDtoImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      priceCharged: json['price_charged'] as String? ?? '0.00',
      currency: json['currency'] as String? ?? 'SAR',
      serviceName: json['service_name'] as String?,
      slotDate: json['slot_date'] as String?,
      slotStartTime: json['slot_start_time'] as String?,
      branchName: json['branch_name'] as String?,
      locationType: json['location_type'] as String? ?? 'branch',
      canCancel: json['can_cancel'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookingListItemDtoImplToJson(
        _$BookingListItemDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'price_charged': instance.priceCharged,
      'currency': instance.currency,
      'service_name': instance.serviceName,
      'slot_date': instance.slotDate,
      'slot_start_time': instance.slotStartTime,
      'branch_name': instance.branchName,
      'location_type': instance.locationType,
      'can_cancel': instance.canCancel,
    };

_$PaginatedBookingsDtoImpl _$$PaginatedBookingsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginatedBookingsDtoImpl(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map(
                  (e) => BookingListItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PaginatedBookingsDtoImplToJson(
        _$PaginatedBookingsDtoImpl instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
