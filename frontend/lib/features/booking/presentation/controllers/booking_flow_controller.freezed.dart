// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_flow_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingFlowState {
// Step 1 — slot
  List<SlotDto> get availableSlots => throw _privateConstructorUsedError;
  bool get isLoadingSlots => throw _privateConstructorUsedError;
  String? get selectedDate => throw _privateConstructorUsedError;
  SlotDto? get selectedSlot =>
      throw _privateConstructorUsedError; // Step 2 — location
  String get locationType =>
      throw _privateConstructorUsedError; // 'branch' | 'mobile'
  BranchDto? get selectedBranch => throw _privateConstructorUsedError;
  List<BranchDto> get branches =>
      throw _privateConstructorUsedError; // Step 3 — confirm + submit
  int? get vehicleId => throw _privateConstructorUsedError;
  int? get serviceId => throw _privateConstructorUsedError;
  ServiceDto? get service => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  BookingDto? get result => throw _privateConstructorUsedError;
  Failure? get failure =>
      throw _privateConstructorUsedError; // Idempotency key — generated once per logical booking attempt
  String? get idempotencyKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingFlowStateCopyWith<BookingFlowState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingFlowStateCopyWith<$Res> {
  factory $BookingFlowStateCopyWith(
          BookingFlowState value, $Res Function(BookingFlowState) then) =
      _$BookingFlowStateCopyWithImpl<$Res, BookingFlowState>;
  @useResult
  $Res call(
      {List<SlotDto> availableSlots,
      bool isLoadingSlots,
      String? selectedDate,
      SlotDto? selectedSlot,
      String locationType,
      BranchDto? selectedBranch,
      List<BranchDto> branches,
      int? vehicleId,
      int? serviceId,
      ServiceDto? service,
      bool isSubmitting,
      BookingDto? result,
      Failure? failure,
      String? idempotencyKey});

  $SlotDtoCopyWith<$Res>? get selectedSlot;
  $BranchDtoCopyWith<$Res>? get selectedBranch;
  $ServiceDtoCopyWith<$Res>? get service;
  $BookingDtoCopyWith<$Res>? get result;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$BookingFlowStateCopyWithImpl<$Res, $Val extends BookingFlowState>
    implements $BookingFlowStateCopyWith<$Res> {
  _$BookingFlowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableSlots = null,
    Object? isLoadingSlots = null,
    Object? selectedDate = freezed,
    Object? selectedSlot = freezed,
    Object? locationType = null,
    Object? selectedBranch = freezed,
    Object? branches = null,
    Object? vehicleId = freezed,
    Object? serviceId = freezed,
    Object? service = freezed,
    Object? isSubmitting = null,
    Object? result = freezed,
    Object? failure = freezed,
    Object? idempotencyKey = freezed,
  }) {
    return _then(_value.copyWith(
      availableSlots: null == availableSlots
          ? _value.availableSlots
          : availableSlots // ignore: cast_nullable_to_non_nullable
              as List<SlotDto>,
      isLoadingSlots: null == isLoadingSlots
          ? _value.isLoadingSlots
          : isLoadingSlots // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSlot: freezed == selectedSlot
          ? _value.selectedSlot
          : selectedSlot // ignore: cast_nullable_to_non_nullable
              as SlotDto?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBranch: freezed == selectedBranch
          ? _value.selectedBranch
          : selectedBranch // ignore: cast_nullable_to_non_nullable
              as BranchDto?,
      branches: null == branches
          ? _value.branches
          : branches // ignore: cast_nullable_to_non_nullable
              as List<BranchDto>,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceDto?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as BookingDto?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      idempotencyKey: freezed == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SlotDtoCopyWith<$Res>? get selectedSlot {
    if (_value.selectedSlot == null) {
      return null;
    }

    return $SlotDtoCopyWith<$Res>(_value.selectedSlot!, (value) {
      return _then(_value.copyWith(selectedSlot: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BranchDtoCopyWith<$Res>? get selectedBranch {
    if (_value.selectedBranch == null) {
      return null;
    }

    return $BranchDtoCopyWith<$Res>(_value.selectedBranch!, (value) {
      return _then(_value.copyWith(selectedBranch: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceDtoCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceDtoCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BookingDtoCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $BookingDtoCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingFlowStateImplCopyWith<$Res>
    implements $BookingFlowStateCopyWith<$Res> {
  factory _$$BookingFlowStateImplCopyWith(_$BookingFlowStateImpl value,
          $Res Function(_$BookingFlowStateImpl) then) =
      __$$BookingFlowStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SlotDto> availableSlots,
      bool isLoadingSlots,
      String? selectedDate,
      SlotDto? selectedSlot,
      String locationType,
      BranchDto? selectedBranch,
      List<BranchDto> branches,
      int? vehicleId,
      int? serviceId,
      ServiceDto? service,
      bool isSubmitting,
      BookingDto? result,
      Failure? failure,
      String? idempotencyKey});

  @override
  $SlotDtoCopyWith<$Res>? get selectedSlot;
  @override
  $BranchDtoCopyWith<$Res>? get selectedBranch;
  @override
  $ServiceDtoCopyWith<$Res>? get service;
  @override
  $BookingDtoCopyWith<$Res>? get result;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$BookingFlowStateImplCopyWithImpl<$Res>
    extends _$BookingFlowStateCopyWithImpl<$Res, _$BookingFlowStateImpl>
    implements _$$BookingFlowStateImplCopyWith<$Res> {
  __$$BookingFlowStateImplCopyWithImpl(_$BookingFlowStateImpl _value,
      $Res Function(_$BookingFlowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableSlots = null,
    Object? isLoadingSlots = null,
    Object? selectedDate = freezed,
    Object? selectedSlot = freezed,
    Object? locationType = null,
    Object? selectedBranch = freezed,
    Object? branches = null,
    Object? vehicleId = freezed,
    Object? serviceId = freezed,
    Object? service = freezed,
    Object? isSubmitting = null,
    Object? result = freezed,
    Object? failure = freezed,
    Object? idempotencyKey = freezed,
  }) {
    return _then(_$BookingFlowStateImpl(
      availableSlots: null == availableSlots
          ? _value._availableSlots
          : availableSlots // ignore: cast_nullable_to_non_nullable
              as List<SlotDto>,
      isLoadingSlots: null == isLoadingSlots
          ? _value.isLoadingSlots
          : isLoadingSlots // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedSlot: freezed == selectedSlot
          ? _value.selectedSlot
          : selectedSlot // ignore: cast_nullable_to_non_nullable
              as SlotDto?,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBranch: freezed == selectedBranch
          ? _value.selectedBranch
          : selectedBranch // ignore: cast_nullable_to_non_nullable
              as BranchDto?,
      branches: null == branches
          ? _value._branches
          : branches // ignore: cast_nullable_to_non_nullable
              as List<BranchDto>,
      vehicleId: freezed == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceDto?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as BookingDto?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      idempotencyKey: freezed == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BookingFlowStateImpl implements _BookingFlowState {
  const _$BookingFlowStateImpl(
      {final List<SlotDto> availableSlots = const [],
      this.isLoadingSlots = false,
      this.selectedDate,
      this.selectedSlot,
      this.locationType = 'branch',
      this.selectedBranch,
      final List<BranchDto> branches = const [],
      this.vehicleId,
      this.serviceId,
      this.service,
      this.isSubmitting = false,
      this.result,
      this.failure,
      this.idempotencyKey})
      : _availableSlots = availableSlots,
        _branches = branches;

// Step 1 — slot
  final List<SlotDto> _availableSlots;
// Step 1 — slot
  @override
  @JsonKey()
  List<SlotDto> get availableSlots {
    if (_availableSlots is EqualUnmodifiableListView) return _availableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSlots);
  }

  @override
  @JsonKey()
  final bool isLoadingSlots;
  @override
  final String? selectedDate;
  @override
  final SlotDto? selectedSlot;
// Step 2 — location
  @override
  @JsonKey()
  final String locationType;
// 'branch' | 'mobile'
  @override
  final BranchDto? selectedBranch;
  final List<BranchDto> _branches;
  @override
  @JsonKey()
  List<BranchDto> get branches {
    if (_branches is EqualUnmodifiableListView) return _branches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branches);
  }

// Step 3 — confirm + submit
  @override
  final int? vehicleId;
  @override
  final int? serviceId;
  @override
  final ServiceDto? service;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final BookingDto? result;
  @override
  final Failure? failure;
// Idempotency key — generated once per logical booking attempt
  @override
  final String? idempotencyKey;

  @override
  String toString() {
    return 'BookingFlowState(availableSlots: $availableSlots, isLoadingSlots: $isLoadingSlots, selectedDate: $selectedDate, selectedSlot: $selectedSlot, locationType: $locationType, selectedBranch: $selectedBranch, branches: $branches, vehicleId: $vehicleId, serviceId: $serviceId, service: $service, isSubmitting: $isSubmitting, result: $result, failure: $failure, idempotencyKey: $idempotencyKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingFlowStateImpl &&
            const DeepCollectionEquality()
                .equals(other._availableSlots, _availableSlots) &&
            (identical(other.isLoadingSlots, isLoadingSlots) ||
                other.isLoadingSlots == isLoadingSlots) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedSlot, selectedSlot) ||
                other.selectedSlot == selectedSlot) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.selectedBranch, selectedBranch) ||
                other.selectedBranch == selectedBranch) &&
            const DeepCollectionEquality().equals(other._branches, _branches) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableSlots),
      isLoadingSlots,
      selectedDate,
      selectedSlot,
      locationType,
      selectedBranch,
      const DeepCollectionEquality().hash(_branches),
      vehicleId,
      serviceId,
      service,
      isSubmitting,
      result,
      failure,
      idempotencyKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingFlowStateImplCopyWith<_$BookingFlowStateImpl> get copyWith =>
      __$$BookingFlowStateImplCopyWithImpl<_$BookingFlowStateImpl>(
          this, _$identity);
}

abstract class _BookingFlowState implements BookingFlowState {
  const factory _BookingFlowState(
      {final List<SlotDto> availableSlots,
      final bool isLoadingSlots,
      final String? selectedDate,
      final SlotDto? selectedSlot,
      final String locationType,
      final BranchDto? selectedBranch,
      final List<BranchDto> branches,
      final int? vehicleId,
      final int? serviceId,
      final ServiceDto? service,
      final bool isSubmitting,
      final BookingDto? result,
      final Failure? failure,
      final String? idempotencyKey}) = _$BookingFlowStateImpl;

  @override // Step 1 — slot
  List<SlotDto> get availableSlots;
  @override
  bool get isLoadingSlots;
  @override
  String? get selectedDate;
  @override
  SlotDto? get selectedSlot;
  @override // Step 2 — location
  String get locationType;
  @override // 'branch' | 'mobile'
  BranchDto? get selectedBranch;
  @override
  List<BranchDto> get branches;
  @override // Step 3 — confirm + submit
  int? get vehicleId;
  @override
  int? get serviceId;
  @override
  ServiceDto? get service;
  @override
  bool get isSubmitting;
  @override
  BookingDto? get result;
  @override
  Failure? get failure;
  @override // Idempotency key — generated once per logical booking attempt
  String? get idempotencyKey;
  @override
  @JsonKey(ignore: true)
  _$$BookingFlowStateImplCopyWith<_$BookingFlowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
