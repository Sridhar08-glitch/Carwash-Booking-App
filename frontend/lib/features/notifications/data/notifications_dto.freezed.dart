// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) {
  return _NotificationDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationDto {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDtoCopyWith<NotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDtoCopyWith<$Res> {
  factory $NotificationDtoCopyWith(
          NotificationDto value, $Res Function(NotificationDto) then) =
      _$NotificationDtoCopyWithImpl<$Res, NotificationDto>;
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      bool read,
      @JsonKey(name: 'created_at') String createdAt,
      String? type,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res, $Val extends NotificationDto>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? read = null,
    Object? createdAt = null,
    Object? type = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationDtoImplCopyWith<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  factory _$$NotificationDtoImplCopyWith(_$NotificationDtoImpl value,
          $Res Function(_$NotificationDtoImpl) then) =
      __$$NotificationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      bool read,
      @JsonKey(name: 'created_at') String createdAt,
      String? type,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$NotificationDtoImplCopyWithImpl<$Res>
    extends _$NotificationDtoCopyWithImpl<$Res, _$NotificationDtoImpl>
    implements _$$NotificationDtoImplCopyWith<$Res> {
  __$$NotificationDtoImplCopyWithImpl(
      _$NotificationDtoImpl _value, $Res Function(_$NotificationDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? read = null,
    Object? createdAt = null,
    Object? type = freezed,
    Object? data = freezed,
  }) {
    return _then(_$NotificationDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDtoImpl implements _NotificationDto {
  const _$NotificationDtoImpl(
      {required this.id,
      required this.title,
      required this.body,
      this.read = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      this.type,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$NotificationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey()
  final bool read;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  final String? type;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NotificationDto(id: $id, title: $title, body: $body, read: $read, createdAt: $createdAt, type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, read, createdAt,
      type, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDtoImplCopyWith<_$NotificationDtoImpl> get copyWith =>
      __$$NotificationDtoImplCopyWithImpl<_$NotificationDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDtoImplToJson(
      this,
    );
  }
}

abstract class _NotificationDto implements NotificationDto {
  const factory _NotificationDto(
      {required final int id,
      required final String title,
      required final String body,
      final bool read,
      @JsonKey(name: 'created_at') required final String createdAt,
      final String? type,
      final Map<String, dynamic>? data}) = _$NotificationDtoImpl;

  factory _NotificationDto.fromJson(Map<String, dynamic> json) =
      _$NotificationDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  bool get read;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  String? get type;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$NotificationDtoImplCopyWith<_$NotificationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettingsDto _$NotificationSettingsDtoFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsDto {
  @JsonKey(name: 'booking_updates')
  bool get bookingUpdates => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_updates')
  bool get orderUpdates => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotions')
  bool get promotions => throw _privateConstructorUsedError;
  @JsonKey(name: 'loyalty')
  bool get loyalty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsDtoCopyWith<NotificationSettingsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsDtoCopyWith<$Res> {
  factory $NotificationSettingsDtoCopyWith(NotificationSettingsDto value,
          $Res Function(NotificationSettingsDto) then) =
      _$NotificationSettingsDtoCopyWithImpl<$Res, NotificationSettingsDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_updates') bool bookingUpdates,
      @JsonKey(name: 'order_updates') bool orderUpdates,
      @JsonKey(name: 'promotions') bool promotions,
      @JsonKey(name: 'loyalty') bool loyalty});
}

/// @nodoc
class _$NotificationSettingsDtoCopyWithImpl<$Res,
        $Val extends NotificationSettingsDto>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  _$NotificationSettingsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingUpdates = null,
    Object? orderUpdates = null,
    Object? promotions = null,
    Object? loyalty = null,
  }) {
    return _then(_value.copyWith(
      bookingUpdates: null == bookingUpdates
          ? _value.bookingUpdates
          : bookingUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      orderUpdates: null == orderUpdates
          ? _value.orderUpdates
          : orderUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      promotions: null == promotions
          ? _value.promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as bool,
      loyalty: null == loyalty
          ? _value.loyalty
          : loyalty // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsDtoImplCopyWith<$Res>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  factory _$$NotificationSettingsDtoImplCopyWith(
          _$NotificationSettingsDtoImpl value,
          $Res Function(_$NotificationSettingsDtoImpl) then) =
      __$$NotificationSettingsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_updates') bool bookingUpdates,
      @JsonKey(name: 'order_updates') bool orderUpdates,
      @JsonKey(name: 'promotions') bool promotions,
      @JsonKey(name: 'loyalty') bool loyalty});
}

/// @nodoc
class __$$NotificationSettingsDtoImplCopyWithImpl<$Res>
    extends _$NotificationSettingsDtoCopyWithImpl<$Res,
        _$NotificationSettingsDtoImpl>
    implements _$$NotificationSettingsDtoImplCopyWith<$Res> {
  __$$NotificationSettingsDtoImplCopyWithImpl(
      _$NotificationSettingsDtoImpl _value,
      $Res Function(_$NotificationSettingsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingUpdates = null,
    Object? orderUpdates = null,
    Object? promotions = null,
    Object? loyalty = null,
  }) {
    return _then(_$NotificationSettingsDtoImpl(
      bookingUpdates: null == bookingUpdates
          ? _value.bookingUpdates
          : bookingUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      orderUpdates: null == orderUpdates
          ? _value.orderUpdates
          : orderUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      promotions: null == promotions
          ? _value.promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as bool,
      loyalty: null == loyalty
          ? _value.loyalty
          : loyalty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsDtoImpl implements _NotificationSettingsDto {
  const _$NotificationSettingsDtoImpl(
      {@JsonKey(name: 'booking_updates') this.bookingUpdates = true,
      @JsonKey(name: 'order_updates') this.orderUpdates = true,
      @JsonKey(name: 'promotions') this.promotions = true,
      @JsonKey(name: 'loyalty') this.loyalty = true});

  factory _$NotificationSettingsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsDtoImplFromJson(json);

  @override
  @JsonKey(name: 'booking_updates')
  final bool bookingUpdates;
  @override
  @JsonKey(name: 'order_updates')
  final bool orderUpdates;
  @override
  @JsonKey(name: 'promotions')
  final bool promotions;
  @override
  @JsonKey(name: 'loyalty')
  final bool loyalty;

  @override
  String toString() {
    return 'NotificationSettingsDto(bookingUpdates: $bookingUpdates, orderUpdates: $orderUpdates, promotions: $promotions, loyalty: $loyalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsDtoImpl &&
            (identical(other.bookingUpdates, bookingUpdates) ||
                other.bookingUpdates == bookingUpdates) &&
            (identical(other.orderUpdates, orderUpdates) ||
                other.orderUpdates == orderUpdates) &&
            (identical(other.promotions, promotions) ||
                other.promotions == promotions) &&
            (identical(other.loyalty, loyalty) || other.loyalty == loyalty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, bookingUpdates, orderUpdates, promotions, loyalty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsDtoImplCopyWith<_$NotificationSettingsDtoImpl>
      get copyWith => __$$NotificationSettingsDtoImplCopyWithImpl<
          _$NotificationSettingsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsDtoImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsDto implements NotificationSettingsDto {
  const factory _NotificationSettingsDto(
          {@JsonKey(name: 'booking_updates') final bool bookingUpdates,
          @JsonKey(name: 'order_updates') final bool orderUpdates,
          @JsonKey(name: 'promotions') final bool promotions,
          @JsonKey(name: 'loyalty') final bool loyalty}) =
      _$NotificationSettingsDtoImpl;

  factory _NotificationSettingsDto.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsDtoImpl.fromJson;

  @override
  @JsonKey(name: 'booking_updates')
  bool get bookingUpdates;
  @override
  @JsonKey(name: 'order_updates')
  bool get orderUpdates;
  @override
  @JsonKey(name: 'promotions')
  bool get promotions;
  @override
  @JsonKey(name: 'loyalty')
  bool get loyalty;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsDtoImplCopyWith<_$NotificationSettingsDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
