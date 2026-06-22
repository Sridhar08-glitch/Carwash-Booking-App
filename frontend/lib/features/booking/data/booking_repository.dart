import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/interceptors/idempotency_interceptor.dart';
import 'booking_dto.dart';

part 'booking_repository.g.dart';

@riverpod
BookingRepository bookingRepository(BookingRepositoryRef ref) =>
    BookingRepository(ref.watch(dioProvider));

class BookingRepository {
  BookingRepository(this._dio);

  final Dio _dio;
  static const _uuid = Uuid();

  // ---------------------------------------------------------------------------
  // GET /slots — NEVER cached; always fetches fresh data
  // ---------------------------------------------------------------------------
  Future<List<SlotDto>> getSlots({
    required String date,
    required int serviceId,
    int? branchId,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/slots',
        queryParameters: {
          'date': date,
          'service': serviceId,
          if (branchId != null) 'branch': branchId,
        },
      );
      return response.data!
          .map((e) => SlotDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // POST /bookings — idempotency key REQUIRED
  // ---------------------------------------------------------------------------
  Future<BookingDto> createBooking({
    required CreateBookingDto dto,
    required String idempotencyKey,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/bookings',
        data: dto.toJson(),
        options: Options(
          extra: {
            'idempotencyKey': idempotencyKey,
            'idempotent': true,
          },
        ),
      );
      return BookingDto.fromJson(response.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // GET /bookings — paginated
  // ---------------------------------------------------------------------------
  Future<PaginatedBookingsDto> getBookings({String? cursor}) async {
    try {
      // Backend returns a plain JSON array (no pagination envelope yet) —
      // tolerate both shapes so a future cursor-paginated backend also works.
      final response = await _dio.get<dynamic>(
        '/bookings',
        queryParameters: cursor != null ? {'cursor': cursor} : null,
      );
      final data = response.data;
      if (data is List) {
        return PaginatedBookingsDto(
          results: data
              .map((e) =>
                  BookingListItemDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      return PaginatedBookingsDto.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // GET /bookings/{id}
  // ---------------------------------------------------------------------------
  Future<BookingDto> getBooking(int id) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/bookings/$id');
      return BookingDto.fromJson(response.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // POST /bookings/{id}/cancel
  //
  // [idempotencyKey] must be generated once per logical cancel action (e.g.
  // in the notifier state) and reused on every retry, so the server
  // de-duplicates double-taps.  The IdempotencyInterceptor auto-injects a key
  // based on the path prefix but only reuses it for the *same* RequestOptions
  // object — a second tap generates a new options object with a different key.
  // Passing an explicit key here guarantees de-duplication across retries AND
  // duplicate user taps.
  // ---------------------------------------------------------------------------
  Future<void> cancelBooking(
    int id, {
    String reason = '',
    required String idempotencyKey,
  }) async {
    try {
      await _dio.post<dynamic>(
        '/bookings/$id/cancel',
        data: {'reason': reason},
        options: Options(
          extra: {
            'idempotencyKey': idempotencyKey,
            'idempotent': true,
          },
        ),
      );
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // POST /bookings/{id}/reschedule
  //
  // Same idempotency-key requirement as cancelBooking above.
  // ---------------------------------------------------------------------------
  Future<BookingDto> rescheduleBooking(
    int id, {
    required int slotId,
    required String idempotencyKey,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/bookings/$id/reschedule',
        data: {'slot_id': slotId},
        options: Options(
          extra: {
            'idempotencyKey': idempotencyKey,
            'idempotent': true,
          },
        ),
      );
      return BookingDto.fromJson(response.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
