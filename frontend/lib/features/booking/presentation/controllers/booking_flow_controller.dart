import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../data/booking_dto.dart';
import '../../data/booking_repository.dart';
import '../../../services/data/services_dto.dart';
import '../../../services/data/services_repository.dart';

part 'booking_flow_controller.freezed.dart';
part 'booking_flow_controller.g.dart';

// ---------------------------------------------------------------------------
// Booking flow state — accumulates choices across screens
// ---------------------------------------------------------------------------
@freezed
class BookingFlowState with _$BookingFlowState {
  const factory BookingFlowState({
    // Step 1 — slot
    @Default([]) List<SlotDto> availableSlots,
    @Default(false) bool isLoadingSlots,
    String? selectedDate,
    SlotDto? selectedSlot,

    // Step 2 — location
    @Default('branch') String locationType, // 'branch' | 'mobile'
    BranchDto? selectedBranch,
    @Default([]) List<BranchDto> branches,

    // Step 3 — confirm + submit
    int? vehicleId,
    int? serviceId,
    ServiceDto? service,
    @Default(false) bool isSubmitting,
    BookingDto? result,
    Failure? failure,

    // Payment + address — wired through to CreateBookingDto
    @Default('cash') String paymentMethod, // 'card' | 'wallet' | 'cash'
    int? addressId, // required when locationType == 'mobile'

    // Idempotency key — generated once per logical booking attempt
    String? idempotencyKey,
  }) = _BookingFlowState;
}

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------
@riverpod
class BookingFlowController extends _$BookingFlowController {
  static const _uuid = Uuid();

  @override
  BookingFlowState build() => BookingFlowState(
        idempotencyKey: _uuid.v4(), // fresh key for each booking attempt
      );

  // ---------------------------------------------------------------------------
  // Load service info
  // ---------------------------------------------------------------------------
  Future<void> loadService(int serviceId) async {
    try {
      final service = await ref
          .read(servicesRepositoryProvider)
          .getService(serviceId);
      final branches = await ref
          .read(servicesRepositoryProvider)
          .getBranches();
      state = state.copyWith(
        serviceId: serviceId,
        service: service,
        branches: branches,
        selectedBranch: branches.isNotEmpty ? branches.first : null,
      );
    } catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // Slot fetching — always fresh, never cached
  // ---------------------------------------------------------------------------
  Future<void> fetchSlots(String date) async {
    if (state.serviceId == null) return;
    state = state.copyWith(
      isLoadingSlots: true,
      selectedDate: date,
      selectedSlot: null,
    );
    try {
      final slots = await ref.read(bookingRepositoryProvider).getSlots(
            date: date,
            serviceId: state.serviceId!,
            branchId: state.selectedBranch?.id,
          );
      state = state.copyWith(isLoadingSlots: false, availableSlots: slots);
    } catch (e) {
      state = state.copyWith(
        isLoadingSlots: false,
        failure: e is Failure ? e : const Failure.network(),
      );
    }
  }

  void selectSlot(SlotDto slot) => state = state.copyWith(selectedSlot: slot);

  void selectBranch(BranchDto branch) {
    state = state.copyWith(selectedBranch: branch, selectedSlot: null);
    if (state.selectedDate != null) fetchSlots(state.selectedDate!);
  }

  void setLocationType(String type) =>
      state = state.copyWith(locationType: type);

  void setVehicleId(int id) => state = state.copyWith(vehicleId: id);

  void setPaymentMethod(String method) =>
      state = state.copyWith(paymentMethod: method);

  void setAddressId(int id) => state = state.copyWith(addressId: id);

  // ---------------------------------------------------------------------------
  // Submit booking — POST /bookings with idempotency key
  // ---------------------------------------------------------------------------
  Future<bool> submitBooking() async {
    if (state.serviceId == null || state.selectedSlot == null) return false;

    state = state.copyWith(isSubmitting: true, failure: null);

    // Ensure we have an idempotency key (generated in build(), reused on retry)
    final key = state.idempotencyKey ?? _uuid.v4();

    try {
      final booking = await ref.read(bookingRepositoryProvider).createBooking(
            dto: CreateBookingDto(
              serviceId: state.serviceId!,
              slotId: state.selectedSlot!.id,
              locationType: state.locationType,
              vehicleId: state.vehicleId,
              addressId: state.addressId,
              paymentMethod: state.paymentMethod,
            ),
            idempotencyKey: key,
          );

      state = state.copyWith(
        isSubmitting: false,
        result: booking,
        // Keep the same key — if the result call succeeds, next booking
        // should get a fresh key (handled by router going to success screen)
      );
      return true;
    } on Failure catch (f) {
      state = state.copyWith(isSubmitting: false, failure: f);
      // On conflict (slot taken), generate a new key for next attempt
      if (f is ConflictFailure) {
        state = state.copyWith(idempotencyKey: _uuid.v4());
      }
      return false;
    }
  }

  void clearFailure() => state = state.copyWith(failure: null);
}

// ---------------------------------------------------------------------------
// Booking history
// ---------------------------------------------------------------------------
@riverpod
class BookingHistoryController extends _$BookingHistoryController {
  @override
  Future<List<BookingListItemDto>> build() async {
    final page = await ref.watch(bookingRepositoryProvider).getBookings();
    return page.results;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final page = await ref.read(bookingRepositoryProvider).getBookings();
      return page.results;
    });
  }
}

// ---------------------------------------------------------------------------
// Single booking detail
// ---------------------------------------------------------------------------
@riverpod
Future<BookingDto> bookingDetail(BookingDetailRef ref, int id) =>
    ref.watch(bookingRepositoryProvider).getBooking(id);
