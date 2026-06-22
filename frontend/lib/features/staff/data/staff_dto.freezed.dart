// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StaffTaskDto _$StaffTaskDtoFromJson(Map<String, dynamic> json) {
  return _StaffTaskDto.fromJson(json);
}

/// @nodoc
mixin _$StaffTaskDto {
  int get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaffTaskDtoCopyWith<StaffTaskDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffTaskDtoCopyWith<$Res> {
  factory $StaffTaskDtoCopyWith(
          StaffTaskDto value, $Res Function(StaffTaskDto) then) =
      _$StaffTaskDtoCopyWithImpl<$Res, StaffTaskDto>;
  @useResult
  $Res call({int id, String label, bool completed});
}

/// @nodoc
class _$StaffTaskDtoCopyWithImpl<$Res, $Val extends StaffTaskDto>
    implements $StaffTaskDtoCopyWith<$Res> {
  _$StaffTaskDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffTaskDtoImplCopyWith<$Res>
    implements $StaffTaskDtoCopyWith<$Res> {
  factory _$$StaffTaskDtoImplCopyWith(
          _$StaffTaskDtoImpl value, $Res Function(_$StaffTaskDtoImpl) then) =
      __$$StaffTaskDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String label, bool completed});
}

/// @nodoc
class __$$StaffTaskDtoImplCopyWithImpl<$Res>
    extends _$StaffTaskDtoCopyWithImpl<$Res, _$StaffTaskDtoImpl>
    implements _$$StaffTaskDtoImplCopyWith<$Res> {
  __$$StaffTaskDtoImplCopyWithImpl(
      _$StaffTaskDtoImpl _value, $Res Function(_$StaffTaskDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? completed = null,
  }) {
    return _then(_$StaffTaskDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffTaskDtoImpl implements _StaffTaskDto {
  const _$StaffTaskDtoImpl(
      {required this.id, required this.label, this.completed = false});

  factory _$StaffTaskDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffTaskDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String label;
  @override
  @JsonKey()
  final bool completed;

  @override
  String toString() {
    return 'StaffTaskDto(id: $id, label: $label, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffTaskDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffTaskDtoImplCopyWith<_$StaffTaskDtoImpl> get copyWith =>
      __$$StaffTaskDtoImplCopyWithImpl<_$StaffTaskDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffTaskDtoImplToJson(
      this,
    );
  }
}

abstract class _StaffTaskDto implements StaffTaskDto {
  const factory _StaffTaskDto(
      {required final int id,
      required final String label,
      final bool completed}) = _$StaffTaskDtoImpl;

  factory _StaffTaskDto.fromJson(Map<String, dynamic> json) =
      _$StaffTaskDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get label;
  @override
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$StaffTaskDtoImplCopyWith<_$StaffTaskDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffJobDto _$StaffJobDtoFromJson(Map<String, dynamic> json) {
  return _StaffJobDto.fromJson(json);
}

/// @nodoc
mixin _$StaffJobDto {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_phone')
  String? get customerPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_name')
  String? get branchName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  String get scheduledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_info')
  String? get vehicleInfo => throw _privateConstructorUsedError;
  List<StaffTaskDto> get tasks => throw _privateConstructorUsedError;
  @JsonKey(name: 'before_photos')
  List<String> get beforePhotos => throw _privateConstructorUsedError;
  @JsonKey(name: 'after_photos')
  List<String> get afterPhotos => throw _privateConstructorUsedError;
  @JsonKey(name: 'eta_minutes')
  int? get etaMinutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaffJobDtoCopyWith<StaffJobDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffJobDtoCopyWith<$Res> {
  factory $StaffJobDtoCopyWith(
          StaffJobDto value, $Res Function(StaffJobDto) then) =
      _$StaffJobDtoCopyWithImpl<$Res, StaffJobDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'customer_name') String customerName,
      @JsonKey(name: 'customer_phone') String? customerPhone,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'branch_name') String? branchName,
      String? address,
      String status,
      @JsonKey(name: 'scheduled_at') String scheduledAt,
      @JsonKey(name: 'vehicle_info') String? vehicleInfo,
      List<StaffTaskDto> tasks,
      @JsonKey(name: 'before_photos') List<String> beforePhotos,
      @JsonKey(name: 'after_photos') List<String> afterPhotos,
      @JsonKey(name: 'eta_minutes') int? etaMinutes});
}

/// @nodoc
class _$StaffJobDtoCopyWithImpl<$Res, $Val extends StaffJobDto>
    implements $StaffJobDtoCopyWith<$Res> {
  _$StaffJobDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? serviceName = null,
    Object? locationType = null,
    Object? branchName = freezed,
    Object? address = freezed,
    Object? status = null,
    Object? scheduledAt = null,
    Object? vehicleInfo = freezed,
    Object? tasks = null,
    Object? beforePhotos = null,
    Object? afterPhotos = null,
    Object? etaMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: freezed == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInfo: freezed == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<StaffTaskDto>,
      beforePhotos: null == beforePhotos
          ? _value.beforePhotos
          : beforePhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      afterPhotos: null == afterPhotos
          ? _value.afterPhotos
          : afterPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      etaMinutes: freezed == etaMinutes
          ? _value.etaMinutes
          : etaMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffJobDtoImplCopyWith<$Res>
    implements $StaffJobDtoCopyWith<$Res> {
  factory _$$StaffJobDtoImplCopyWith(
          _$StaffJobDtoImpl value, $Res Function(_$StaffJobDtoImpl) then) =
      __$$StaffJobDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'customer_name') String customerName,
      @JsonKey(name: 'customer_phone') String? customerPhone,
      @JsonKey(name: 'service_name') String serviceName,
      @JsonKey(name: 'location_type') String locationType,
      @JsonKey(name: 'branch_name') String? branchName,
      String? address,
      String status,
      @JsonKey(name: 'scheduled_at') String scheduledAt,
      @JsonKey(name: 'vehicle_info') String? vehicleInfo,
      List<StaffTaskDto> tasks,
      @JsonKey(name: 'before_photos') List<String> beforePhotos,
      @JsonKey(name: 'after_photos') List<String> afterPhotos,
      @JsonKey(name: 'eta_minutes') int? etaMinutes});
}

/// @nodoc
class __$$StaffJobDtoImplCopyWithImpl<$Res>
    extends _$StaffJobDtoCopyWithImpl<$Res, _$StaffJobDtoImpl>
    implements _$$StaffJobDtoImplCopyWith<$Res> {
  __$$StaffJobDtoImplCopyWithImpl(
      _$StaffJobDtoImpl _value, $Res Function(_$StaffJobDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? customerName = null,
    Object? customerPhone = freezed,
    Object? serviceName = null,
    Object? locationType = null,
    Object? branchName = freezed,
    Object? address = freezed,
    Object? status = null,
    Object? scheduledAt = null,
    Object? vehicleInfo = freezed,
    Object? tasks = null,
    Object? beforePhotos = null,
    Object? afterPhotos = null,
    Object? etaMinutes = freezed,
  }) {
    return _then(_$StaffJobDtoImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: freezed == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleInfo: freezed == vehicleInfo
          ? _value.vehicleInfo
          : vehicleInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<StaffTaskDto>,
      beforePhotos: null == beforePhotos
          ? _value._beforePhotos
          : beforePhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      afterPhotos: null == afterPhotos
          ? _value._afterPhotos
          : afterPhotos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      etaMinutes: freezed == etaMinutes
          ? _value.etaMinutes
          : etaMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffJobDtoImpl implements _StaffJobDto {
  const _$StaffJobDtoImpl(
      {@JsonKey(name: 'booking_id') required this.bookingId,
      @JsonKey(name: 'customer_name') required this.customerName,
      @JsonKey(name: 'customer_phone') this.customerPhone,
      @JsonKey(name: 'service_name') required this.serviceName,
      @JsonKey(name: 'location_type') required this.locationType,
      @JsonKey(name: 'branch_name') this.branchName,
      this.address,
      required this.status,
      @JsonKey(name: 'scheduled_at') required this.scheduledAt,
      @JsonKey(name: 'vehicle_info') this.vehicleInfo,
      final List<StaffTaskDto> tasks = const [],
      @JsonKey(name: 'before_photos')
      final List<String> beforePhotos = const [],
      @JsonKey(name: 'after_photos') final List<String> afterPhotos = const [],
      @JsonKey(name: 'eta_minutes') this.etaMinutes})
      : _tasks = tasks,
        _beforePhotos = beforePhotos,
        _afterPhotos = afterPhotos;

  factory _$StaffJobDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffJobDtoImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  @JsonKey(name: 'customer_phone')
  final String? customerPhone;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;
  @override
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @override
  final String? address;
  @override
  final String status;
  @override
  @JsonKey(name: 'scheduled_at')
  final String scheduledAt;
  @override
  @JsonKey(name: 'vehicle_info')
  final String? vehicleInfo;
  final List<StaffTaskDto> _tasks;
  @override
  @JsonKey()
  List<StaffTaskDto> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<String> _beforePhotos;
  @override
  @JsonKey(name: 'before_photos')
  List<String> get beforePhotos {
    if (_beforePhotos is EqualUnmodifiableListView) return _beforePhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_beforePhotos);
  }

  final List<String> _afterPhotos;
  @override
  @JsonKey(name: 'after_photos')
  List<String> get afterPhotos {
    if (_afterPhotos is EqualUnmodifiableListView) return _afterPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_afterPhotos);
  }

  @override
  @JsonKey(name: 'eta_minutes')
  final int? etaMinutes;

  @override
  String toString() {
    return 'StaffJobDto(bookingId: $bookingId, customerName: $customerName, customerPhone: $customerPhone, serviceName: $serviceName, locationType: $locationType, branchName: $branchName, address: $address, status: $status, scheduledAt: $scheduledAt, vehicleInfo: $vehicleInfo, tasks: $tasks, beforePhotos: $beforePhotos, afterPhotos: $afterPhotos, etaMinutes: $etaMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffJobDtoImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.vehicleInfo, vehicleInfo) ||
                other.vehicleInfo == vehicleInfo) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._beforePhotos, _beforePhotos) &&
            const DeepCollectionEquality()
                .equals(other._afterPhotos, _afterPhotos) &&
            (identical(other.etaMinutes, etaMinutes) ||
                other.etaMinutes == etaMinutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bookingId,
      customerName,
      customerPhone,
      serviceName,
      locationType,
      branchName,
      address,
      status,
      scheduledAt,
      vehicleInfo,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_beforePhotos),
      const DeepCollectionEquality().hash(_afterPhotos),
      etaMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffJobDtoImplCopyWith<_$StaffJobDtoImpl> get copyWith =>
      __$$StaffJobDtoImplCopyWithImpl<_$StaffJobDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffJobDtoImplToJson(
      this,
    );
  }
}

abstract class _StaffJobDto implements StaffJobDto {
  const factory _StaffJobDto(
      {@JsonKey(name: 'booking_id') required final int bookingId,
      @JsonKey(name: 'customer_name') required final String customerName,
      @JsonKey(name: 'customer_phone') final String? customerPhone,
      @JsonKey(name: 'service_name') required final String serviceName,
      @JsonKey(name: 'location_type') required final String locationType,
      @JsonKey(name: 'branch_name') final String? branchName,
      final String? address,
      required final String status,
      @JsonKey(name: 'scheduled_at') required final String scheduledAt,
      @JsonKey(name: 'vehicle_info') final String? vehicleInfo,
      final List<StaffTaskDto> tasks,
      @JsonKey(name: 'before_photos') final List<String> beforePhotos,
      @JsonKey(name: 'after_photos') final List<String> afterPhotos,
      @JsonKey(name: 'eta_minutes') final int? etaMinutes}) = _$StaffJobDtoImpl;

  factory _StaffJobDto.fromJson(Map<String, dynamic> json) =
      _$StaffJobDtoImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'customer_phone')
  String? get customerPhone;
  @override
  @JsonKey(name: 'service_name')
  String get serviceName;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(name: 'branch_name')
  String? get branchName;
  @override
  String? get address;
  @override
  String get status;
  @override
  @JsonKey(name: 'scheduled_at')
  String get scheduledAt;
  @override
  @JsonKey(name: 'vehicle_info')
  String? get vehicleInfo;
  @override
  List<StaffTaskDto> get tasks;
  @override
  @JsonKey(name: 'before_photos')
  List<String> get beforePhotos;
  @override
  @JsonKey(name: 'after_photos')
  List<String> get afterPhotos;
  @override
  @JsonKey(name: 'eta_minutes')
  int? get etaMinutes;
  @override
  @JsonKey(ignore: true)
  _$$StaffJobDtoImplCopyWith<_$StaffJobDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StaffJobListItemDto _$StaffJobListItemDtoFromJson(Map<String, dynamic> json) {
  return _StaffJobListItemDto.fromJson(json);
}

/// @nodoc
mixin _$StaffJobListItemDto {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String get serviceName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  String get scheduledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_type')
  String get locationType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StaffJobListItemDtoCopyWith<StaffJobListItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffJobListItemDtoCopyWith<$Res> {
  factory $StaffJobListItemDtoCopyWith(
          StaffJobListItemDto value, $Res Function(StaffJobListItemDto) then) =
      _$StaffJobListItemDtoCopyWithImpl<$Res, StaffJobListItemDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'customer_name') String customerName,
      @JsonKey(name: 'service_name') String serviceName,
      String status,
      @JsonKey(name: 'scheduled_at') String scheduledAt,
      @JsonKey(name: 'location_type') String locationType});
}

/// @nodoc
class _$StaffJobListItemDtoCopyWithImpl<$Res, $Val extends StaffJobListItemDto>
    implements $StaffJobListItemDtoCopyWith<$Res> {
  _$StaffJobListItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? customerName = null,
    Object? serviceName = null,
    Object? status = null,
    Object? scheduledAt = null,
    Object? locationType = null,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffJobListItemDtoImplCopyWith<$Res>
    implements $StaffJobListItemDtoCopyWith<$Res> {
  factory _$$StaffJobListItemDtoImplCopyWith(_$StaffJobListItemDtoImpl value,
          $Res Function(_$StaffJobListItemDtoImpl) then) =
      __$$StaffJobListItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'customer_name') String customerName,
      @JsonKey(name: 'service_name') String serviceName,
      String status,
      @JsonKey(name: 'scheduled_at') String scheduledAt,
      @JsonKey(name: 'location_type') String locationType});
}

/// @nodoc
class __$$StaffJobListItemDtoImplCopyWithImpl<$Res>
    extends _$StaffJobListItemDtoCopyWithImpl<$Res, _$StaffJobListItemDtoImpl>
    implements _$$StaffJobListItemDtoImplCopyWith<$Res> {
  __$$StaffJobListItemDtoImplCopyWithImpl(_$StaffJobListItemDtoImpl _value,
      $Res Function(_$StaffJobListItemDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? customerName = null,
    Object? serviceName = null,
    Object? status = null,
    Object? scheduledAt = null,
    Object? locationType = null,
  }) {
    return _then(_$StaffJobListItemDtoImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as String,
      locationType: null == locationType
          ? _value.locationType
          : locationType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffJobListItemDtoImpl implements _StaffJobListItemDto {
  const _$StaffJobListItemDtoImpl(
      {@JsonKey(name: 'booking_id') required this.bookingId,
      @JsonKey(name: 'customer_name') required this.customerName,
      @JsonKey(name: 'service_name') required this.serviceName,
      required this.status,
      @JsonKey(name: 'scheduled_at') required this.scheduledAt,
      @JsonKey(name: 'location_type') required this.locationType});

  factory _$StaffJobListItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffJobListItemDtoImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  @JsonKey(name: 'customer_name')
  final String customerName;
  @override
  @JsonKey(name: 'service_name')
  final String serviceName;
  @override
  final String status;
  @override
  @JsonKey(name: 'scheduled_at')
  final String scheduledAt;
  @override
  @JsonKey(name: 'location_type')
  final String locationType;

  @override
  String toString() {
    return 'StaffJobListItemDto(bookingId: $bookingId, customerName: $customerName, serviceName: $serviceName, status: $status, scheduledAt: $scheduledAt, locationType: $locationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffJobListItemDtoImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.locationType, locationType) ||
                other.locationType == locationType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bookingId, customerName,
      serviceName, status, scheduledAt, locationType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffJobListItemDtoImplCopyWith<_$StaffJobListItemDtoImpl> get copyWith =>
      __$$StaffJobListItemDtoImplCopyWithImpl<_$StaffJobListItemDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffJobListItemDtoImplToJson(
      this,
    );
  }
}

abstract class _StaffJobListItemDto implements StaffJobListItemDto {
  const factory _StaffJobListItemDto(
          {@JsonKey(name: 'booking_id') required final int bookingId,
          @JsonKey(name: 'customer_name') required final String customerName,
          @JsonKey(name: 'service_name') required final String serviceName,
          required final String status,
          @JsonKey(name: 'scheduled_at') required final String scheduledAt,
          @JsonKey(name: 'location_type') required final String locationType}) =
      _$StaffJobListItemDtoImpl;

  factory _StaffJobListItemDto.fromJson(Map<String, dynamic> json) =
      _$StaffJobListItemDtoImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  @JsonKey(name: 'customer_name')
  String get customerName;
  @override
  @JsonKey(name: 'service_name')
  String get serviceName;
  @override
  String get status;
  @override
  @JsonKey(name: 'scheduled_at')
  String get scheduledAt;
  @override
  @JsonKey(name: 'location_type')
  String get locationType;
  @override
  @JsonKey(ignore: true)
  _$$StaffJobListItemDtoImplCopyWith<_$StaffJobListItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresignResponseDto _$PresignResponseDtoFromJson(Map<String, dynamic> json) {
  return _PresignResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PresignResponseDto {
  @JsonKey(name: 'upload_url')
  String get uploadUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 's3_key')
  String get s3Key => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PresignResponseDtoCopyWith<PresignResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresignResponseDtoCopyWith<$Res> {
  factory $PresignResponseDtoCopyWith(
          PresignResponseDto value, $Res Function(PresignResponseDto) then) =
      _$PresignResponseDtoCopyWithImpl<$Res, PresignResponseDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'upload_url') String uploadUrl,
      @JsonKey(name: 's3_key') String s3Key});
}

/// @nodoc
class _$PresignResponseDtoCopyWithImpl<$Res, $Val extends PresignResponseDto>
    implements $PresignResponseDtoCopyWith<$Res> {
  _$PresignResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadUrl = null,
    Object? s3Key = null,
  }) {
    return _then(_value.copyWith(
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      s3Key: null == s3Key
          ? _value.s3Key
          : s3Key // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresignResponseDtoImplCopyWith<$Res>
    implements $PresignResponseDtoCopyWith<$Res> {
  factory _$$PresignResponseDtoImplCopyWith(_$PresignResponseDtoImpl value,
          $Res Function(_$PresignResponseDtoImpl) then) =
      __$$PresignResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'upload_url') String uploadUrl,
      @JsonKey(name: 's3_key') String s3Key});
}

/// @nodoc
class __$$PresignResponseDtoImplCopyWithImpl<$Res>
    extends _$PresignResponseDtoCopyWithImpl<$Res, _$PresignResponseDtoImpl>
    implements _$$PresignResponseDtoImplCopyWith<$Res> {
  __$$PresignResponseDtoImplCopyWithImpl(_$PresignResponseDtoImpl _value,
      $Res Function(_$PresignResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadUrl = null,
    Object? s3Key = null,
  }) {
    return _then(_$PresignResponseDtoImpl(
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      s3Key: null == s3Key
          ? _value.s3Key
          : s3Key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresignResponseDtoImpl implements _PresignResponseDto {
  const _$PresignResponseDtoImpl(
      {@JsonKey(name: 'upload_url') required this.uploadUrl,
      @JsonKey(name: 's3_key') required this.s3Key});

  factory _$PresignResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresignResponseDtoImplFromJson(json);

  @override
  @JsonKey(name: 'upload_url')
  final String uploadUrl;
  @override
  @JsonKey(name: 's3_key')
  final String s3Key;

  @override
  String toString() {
    return 'PresignResponseDto(uploadUrl: $uploadUrl, s3Key: $s3Key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresignResponseDtoImpl &&
            (identical(other.uploadUrl, uploadUrl) ||
                other.uploadUrl == uploadUrl) &&
            (identical(other.s3Key, s3Key) || other.s3Key == s3Key));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uploadUrl, s3Key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresignResponseDtoImplCopyWith<_$PresignResponseDtoImpl> get copyWith =>
      __$$PresignResponseDtoImplCopyWithImpl<_$PresignResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresignResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _PresignResponseDto implements PresignResponseDto {
  const factory _PresignResponseDto(
          {@JsonKey(name: 'upload_url') required final String uploadUrl,
          @JsonKey(name: 's3_key') required final String s3Key}) =
      _$PresignResponseDtoImpl;

  factory _PresignResponseDto.fromJson(Map<String, dynamic> json) =
      _$PresignResponseDtoImpl.fromJson;

  @override
  @JsonKey(name: 'upload_url')
  String get uploadUrl;
  @override
  @JsonKey(name: 's3_key')
  String get s3Key;
  @override
  @JsonKey(ignore: true)
  _$$PresignResponseDtoImplCopyWith<_$PresignResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
