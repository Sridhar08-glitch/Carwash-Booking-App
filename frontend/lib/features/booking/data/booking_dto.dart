import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_dto.freezed.dart';
part 'booking_dto.g.dart';

// ---------------------------------------------------------------------------
// Slot DTO — never cached; always fetched fresh before display
// ---------------------------------------------------------------------------
@freezed
class SlotDto with _$SlotDto {
  const factory SlotDto({
    required int id,
    required String date,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'capacity_left') @Default(0) int capacityLeft,
    @JsonKey(name: 'is_available') @Default(false) bool isAvailable,
  }) = _SlotDto;
  factory SlotDto.fromJson(Map<String, dynamic> json) =>
      _$SlotDtoFromJson(json);
}

// ---------------------------------------------------------------------------
// Booking creation request
// ---------------------------------------------------------------------------
@freezed
class CreateBookingDto with _$CreateBookingDto {
  const factory CreateBookingDto({
    @JsonKey(name: 'service_id') required int serviceId,
    @JsonKey(name: 'slot_id') required int slotId,
    @JsonKey(name: 'location_type') required String locationType,
    @JsonKey(name: 'vehicle_id') int? vehicleId,
    @JsonKey(name: 'address_id') int? addressId,
    @JsonKey(name: 'mobile_lat') String? mobileLat,
    @JsonKey(name: 'mobile_lng') String? mobileLng,
    @JsonKey(name: 'promo_code') String? promoCode,
    // payment_method: 'card' | 'wallet' | 'cash' — mirrors backend
    // BookingCreateSerializer choices. Defaults to 'cash' on both sides.
    @JsonKey(name: 'payment_method') @Default('cash') String paymentMethod,
  }) = _CreateBookingDto;
  factory CreateBookingDto.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingDtoFromJson(json);
}

// ---------------------------------------------------------------------------
// Booking response DTOs
// ---------------------------------------------------------------------------
@freezed
class BookingPaymentDto with _$BookingPaymentDto {
  const factory BookingPaymentDto({
    required int id,
    required String method,
    required String status,
    @JsonKey(name: 'client_secret') String? clientSecret,
  }) = _BookingPaymentDto;
  factory BookingPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$BookingPaymentDtoFromJson(json);
}

@freezed
class BookingSlotSummaryDto with _$BookingSlotSummaryDto {
  const factory BookingSlotSummaryDto({
    required String date,
    @JsonKey(name: 'start_time') required String startTime,
  }) = _BookingSlotSummaryDto;
  factory BookingSlotSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$BookingSlotSummaryDtoFromJson(json);
}

@freezed
class BookingDto with _$BookingDto {
  const factory BookingDto({
    required int id,
    required String status,
    @JsonKey(name: 'price_charged') required String priceCharged,
    @Default('SAR') String currency,
    required BookingPaymentDto payment,
    required BookingSlotSummaryDto slot,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'location_type') @Default('branch') String locationType,
    @JsonKey(name: 'branch_name') String? branchName,
    @JsonKey(name: 'vehicle_plate') String? vehiclePlate,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'can_cancel') @Default(false) bool canCancel,
    @JsonKey(name: 'can_reschedule') @Default(false) bool canReschedule,
  }) = _BookingDto;
  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);
}

// ---------------------------------------------------------------------------
// Paginated booking list item (lighter than full BookingDto)
// ---------------------------------------------------------------------------
@freezed
class BookingListItemDto with _$BookingListItemDto {
  const factory BookingListItemDto({
    required int id,
    required String status,
    @JsonKey(name: 'price_charged') @Default('0.00') String priceCharged,
    @Default('SAR') String currency,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'slot_date') String? slotDate,
    @JsonKey(name: 'slot_start_time') String? slotStartTime,
    @JsonKey(name: 'branch_name') String? branchName,
    @JsonKey(name: 'location_type') @Default('branch') String locationType,
    @JsonKey(name: 'can_cancel') @Default(false) bool canCancel,
  }) = _BookingListItemDto;
  factory BookingListItemDto.fromJson(Map<String, dynamic> json) =>
      _$BookingListItemDtoFromJson(json);
}

@freezed
class PaginatedBookingsDto with _$PaginatedBookingsDto {
  const factory PaginatedBookingsDto({
    String? next,
    String? previous,
    @Default([]) List<BookingListItemDto> results,
  }) = _PaginatedBookingsDto;
  factory PaginatedBookingsDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedBookingsDtoFromJson(json);
}
