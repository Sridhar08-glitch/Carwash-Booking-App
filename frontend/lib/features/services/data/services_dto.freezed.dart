// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceCategoryDto _$ServiceCategoryDtoFromJson(Map<String, dynamic> json) {
  return _ServiceCategoryDto.fromJson(json);
}

/// @nodoc
mixin _$ServiceCategoryDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCategoryDtoCopyWith<ServiceCategoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCategoryDtoCopyWith<$Res> {
  factory $ServiceCategoryDtoCopyWith(
          ServiceCategoryDto value, $Res Function(ServiceCategoryDto) then) =
      _$ServiceCategoryDtoCopyWithImpl<$Res, ServiceCategoryDto>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$ServiceCategoryDtoCopyWithImpl<$Res, $Val extends ServiceCategoryDto>
    implements $ServiceCategoryDtoCopyWith<$Res> {
  _$ServiceCategoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceCategoryDtoImplCopyWith<$Res>
    implements $ServiceCategoryDtoCopyWith<$Res> {
  factory _$$ServiceCategoryDtoImplCopyWith(_$ServiceCategoryDtoImpl value,
          $Res Function(_$ServiceCategoryDtoImpl) then) =
      __$$ServiceCategoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$ServiceCategoryDtoImplCopyWithImpl<$Res>
    extends _$ServiceCategoryDtoCopyWithImpl<$Res, _$ServiceCategoryDtoImpl>
    implements _$$ServiceCategoryDtoImplCopyWith<$Res> {
  __$$ServiceCategoryDtoImplCopyWithImpl(_$ServiceCategoryDtoImpl _value,
      $Res Function(_$ServiceCategoryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ServiceCategoryDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceCategoryDtoImpl implements _ServiceCategoryDto {
  const _$ServiceCategoryDtoImpl({required this.id, required this.name});

  factory _$ServiceCategoryDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceCategoryDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'ServiceCategoryDto(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceCategoryDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceCategoryDtoImplCopyWith<_$ServiceCategoryDtoImpl> get copyWith =>
      __$$ServiceCategoryDtoImplCopyWithImpl<_$ServiceCategoryDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceCategoryDtoImplToJson(
      this,
    );
  }
}

abstract class _ServiceCategoryDto implements ServiceCategoryDto {
  const factory _ServiceCategoryDto(
      {required final int id,
      required final String name}) = _$ServiceCategoryDtoImpl;

  factory _ServiceCategoryDto.fromJson(Map<String, dynamic> json) =
      _$ServiceCategoryDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ServiceCategoryDtoImplCopyWith<_$ServiceCategoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceDto _$ServiceDtoFromJson(Map<String, dynamic> json) {
  return _ServiceDto.fromJson(json);
}

/// @nodoc
mixin _$ServiceDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_price')
  String get basePrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  ServiceCategoryDto? get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mobile_available')
  bool get isMobileAvailable => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceDtoCopyWith<ServiceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceDtoCopyWith<$Res> {
  factory $ServiceDtoCopyWith(
          ServiceDto value, $Res Function(ServiceDto) then) =
      _$ServiceDtoCopyWithImpl<$Res, ServiceDto>;
  @useResult
  $Res call(
      {int id,
      String name,
      String slug,
      String description,
      @JsonKey(name: 'base_price') String basePrice,
      String currency,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      ServiceCategoryDto? category,
      List<String> tags,
      @JsonKey(name: 'is_mobile_available') bool isMobileAvailable,
      String? image});

  $ServiceCategoryDtoCopyWith<$Res>? get category;
}

/// @nodoc
class _$ServiceDtoCopyWithImpl<$Res, $Val extends ServiceDto>
    implements $ServiceDtoCopyWith<$Res> {
  _$ServiceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? basePrice = null,
    Object? currency = null,
    Object? durationMinutes = null,
    Object? category = freezed,
    Object? tags = null,
    Object? isMobileAvailable = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ServiceCategoryDto?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMobileAvailable: null == isMobileAvailable
          ? _value.isMobileAvailable
          : isMobileAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ServiceCategoryDtoCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ServiceCategoryDtoCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServiceDtoImplCopyWith<$Res>
    implements $ServiceDtoCopyWith<$Res> {
  factory _$$ServiceDtoImplCopyWith(
          _$ServiceDtoImpl value, $Res Function(_$ServiceDtoImpl) then) =
      __$$ServiceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String slug,
      String description,
      @JsonKey(name: 'base_price') String basePrice,
      String currency,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      ServiceCategoryDto? category,
      List<String> tags,
      @JsonKey(name: 'is_mobile_available') bool isMobileAvailable,
      String? image});

  @override
  $ServiceCategoryDtoCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ServiceDtoImplCopyWithImpl<$Res>
    extends _$ServiceDtoCopyWithImpl<$Res, _$ServiceDtoImpl>
    implements _$$ServiceDtoImplCopyWith<$Res> {
  __$$ServiceDtoImplCopyWithImpl(
      _$ServiceDtoImpl _value, $Res Function(_$ServiceDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? basePrice = null,
    Object? currency = null,
    Object? durationMinutes = null,
    Object? category = freezed,
    Object? tags = null,
    Object? isMobileAvailable = null,
    Object? image = freezed,
  }) {
    return _then(_$ServiceDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ServiceCategoryDto?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isMobileAvailable: null == isMobileAvailable
          ? _value.isMobileAvailable
          : isMobileAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceDtoImpl implements _ServiceDto {
  const _$ServiceDtoImpl(
      {required this.id,
      required this.name,
      required this.slug,
      this.description = '',
      @JsonKey(name: 'base_price') required this.basePrice,
      this.currency = 'SAR',
      @JsonKey(name: 'duration_minutes') this.durationMinutes = 60,
      this.category,
      final List<String> tags = const [],
      @JsonKey(name: 'is_mobile_available') this.isMobileAvailable = false,
      this.image})
      : _tags = tags;

  factory _$ServiceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'base_price')
  final String basePrice;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  final ServiceCategoryDto? category;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'is_mobile_available')
  final bool isMobileAvailable;
  @override
  final String? image;

  @override
  String toString() {
    return 'ServiceDto(id: $id, name: $name, slug: $slug, description: $description, basePrice: $basePrice, currency: $currency, durationMinutes: $durationMinutes, category: $category, tags: $tags, isMobileAvailable: $isMobileAvailable, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isMobileAvailable, isMobileAvailable) ||
                other.isMobileAvailable == isMobileAvailable) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      slug,
      description,
      basePrice,
      currency,
      durationMinutes,
      category,
      const DeepCollectionEquality().hash(_tags),
      isMobileAvailable,
      image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceDtoImplCopyWith<_$ServiceDtoImpl> get copyWith =>
      __$$ServiceDtoImplCopyWithImpl<_$ServiceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceDtoImplToJson(
      this,
    );
  }
}

abstract class _ServiceDto implements ServiceDto {
  const factory _ServiceDto(
      {required final int id,
      required final String name,
      required final String slug,
      final String description,
      @JsonKey(name: 'base_price') required final String basePrice,
      final String currency,
      @JsonKey(name: 'duration_minutes') final int durationMinutes,
      final ServiceCategoryDto? category,
      final List<String> tags,
      @JsonKey(name: 'is_mobile_available') final bool isMobileAvailable,
      final String? image}) = _$ServiceDtoImpl;

  factory _ServiceDto.fromJson(Map<String, dynamic> json) =
      _$ServiceDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;
  @override
  String get description;
  @override
  @JsonKey(name: 'base_price')
  String get basePrice;
  @override
  String get currency;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  ServiceCategoryDto? get category;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'is_mobile_available')
  bool get isMobileAvailable;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$ServiceDtoImplCopyWith<_$ServiceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchHoursDto _$BranchHoursDtoFromJson(Map<String, dynamic> json) {
  return _BranchHoursDto.fromJson(json);
}

/// @nodoc
mixin _$BranchHoursDto {
  int get weekday => throw _privateConstructorUsedError;
  @JsonKey(name: 'open_time')
  String get openTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'close_time')
  String get closeTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_closed')
  bool get isClosed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BranchHoursDtoCopyWith<BranchHoursDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchHoursDtoCopyWith<$Res> {
  factory $BranchHoursDtoCopyWith(
          BranchHoursDto value, $Res Function(BranchHoursDto) then) =
      _$BranchHoursDtoCopyWithImpl<$Res, BranchHoursDto>;
  @useResult
  $Res call(
      {int weekday,
      @JsonKey(name: 'open_time') String openTime,
      @JsonKey(name: 'close_time') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class _$BranchHoursDtoCopyWithImpl<$Res, $Val extends BranchHoursDto>
    implements $BranchHoursDtoCopyWith<$Res> {
  _$BranchHoursDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekday = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_value.copyWith(
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchHoursDtoImplCopyWith<$Res>
    implements $BranchHoursDtoCopyWith<$Res> {
  factory _$$BranchHoursDtoImplCopyWith(_$BranchHoursDtoImpl value,
          $Res Function(_$BranchHoursDtoImpl) then) =
      __$$BranchHoursDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int weekday,
      @JsonKey(name: 'open_time') String openTime,
      @JsonKey(name: 'close_time') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class __$$BranchHoursDtoImplCopyWithImpl<$Res>
    extends _$BranchHoursDtoCopyWithImpl<$Res, _$BranchHoursDtoImpl>
    implements _$$BranchHoursDtoImplCopyWith<$Res> {
  __$$BranchHoursDtoImplCopyWithImpl(
      _$BranchHoursDtoImpl _value, $Res Function(_$BranchHoursDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekday = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_$BranchHoursDtoImpl(
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as int,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchHoursDtoImpl implements _BranchHoursDto {
  const _$BranchHoursDtoImpl(
      {required this.weekday,
      @JsonKey(name: 'open_time') required this.openTime,
      @JsonKey(name: 'close_time') required this.closeTime,
      @JsonKey(name: 'is_closed') this.isClosed = false});

  factory _$BranchHoursDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchHoursDtoImplFromJson(json);

  @override
  final int weekday;
  @override
  @JsonKey(name: 'open_time')
  final String openTime;
  @override
  @JsonKey(name: 'close_time')
  final String closeTime;
  @override
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  @override
  String toString() {
    return 'BranchHoursDto(weekday: $weekday, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchHoursDtoImpl &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, weekday, openTime, closeTime, isClosed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchHoursDtoImplCopyWith<_$BranchHoursDtoImpl> get copyWith =>
      __$$BranchHoursDtoImplCopyWithImpl<_$BranchHoursDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchHoursDtoImplToJson(
      this,
    );
  }
}

abstract class _BranchHoursDto implements BranchHoursDto {
  const factory _BranchHoursDto(
      {required final int weekday,
      @JsonKey(name: 'open_time') required final String openTime,
      @JsonKey(name: 'close_time') required final String closeTime,
      @JsonKey(name: 'is_closed') final bool isClosed}) = _$BranchHoursDtoImpl;

  factory _BranchHoursDto.fromJson(Map<String, dynamic> json) =
      _$BranchHoursDtoImpl.fromJson;

  @override
  int get weekday;
  @override
  @JsonKey(name: 'open_time')
  String get openTime;
  @override
  @JsonKey(name: 'close_time')
  String get closeTime;
  @override
  @JsonKey(name: 'is_closed')
  bool get isClosed;
  @override
  @JsonKey(ignore: true)
  _$$BranchHoursDtoImplCopyWith<_$BranchHoursDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchDto _$BranchDtoFromJson(Map<String, dynamic> json) {
  return _BranchDto.fromJson(json);
}

/// @nodoc
mixin _$BranchDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get lat => throw _privateConstructorUsedError;
  String get lng => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  List<BranchHoursDto> get hours => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BranchDtoCopyWith<BranchDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchDtoCopyWith<$Res> {
  factory $BranchDtoCopyWith(BranchDto value, $Res Function(BranchDto) then) =
      _$BranchDtoCopyWithImpl<$Res, BranchDto>;
  @useResult
  $Res call(
      {int id,
      String name,
      String city,
      String lat,
      String lng,
      String timezone,
      List<BranchHoursDto> hours});
}

/// @nodoc
class _$BranchDtoCopyWithImpl<$Res, $Val extends BranchDto>
    implements $BranchDtoCopyWith<$Res> {
  _$BranchDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? lat = null,
    Object? lng = null,
    Object? timezone = null,
    Object? hours = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as List<BranchHoursDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchDtoImplCopyWith<$Res>
    implements $BranchDtoCopyWith<$Res> {
  factory _$$BranchDtoImplCopyWith(
          _$BranchDtoImpl value, $Res Function(_$BranchDtoImpl) then) =
      __$$BranchDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String city,
      String lat,
      String lng,
      String timezone,
      List<BranchHoursDto> hours});
}

/// @nodoc
class __$$BranchDtoImplCopyWithImpl<$Res>
    extends _$BranchDtoCopyWithImpl<$Res, _$BranchDtoImpl>
    implements _$$BranchDtoImplCopyWith<$Res> {
  __$$BranchDtoImplCopyWithImpl(
      _$BranchDtoImpl _value, $Res Function(_$BranchDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? lat = null,
    Object? lng = null,
    Object? timezone = null,
    Object? hours = null,
  }) {
    return _then(_$BranchDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      hours: null == hours
          ? _value._hours
          : hours // ignore: cast_nullable_to_non_nullable
              as List<BranchHoursDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchDtoImpl implements _BranchDto {
  const _$BranchDtoImpl(
      {required this.id,
      required this.name,
      this.city = '',
      this.lat = '0.000000',
      this.lng = '0.000000',
      this.timezone = 'Asia/Riyadh',
      final List<BranchHoursDto> hours = const []})
      : _hours = hours;

  factory _$BranchDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String lat;
  @override
  @JsonKey()
  final String lng;
  @override
  @JsonKey()
  final String timezone;
  final List<BranchHoursDto> _hours;
  @override
  @JsonKey()
  List<BranchHoursDto> get hours {
    if (_hours is EqualUnmodifiableListView) return _hours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hours);
  }

  @override
  String toString() {
    return 'BranchDto(id: $id, name: $name, city: $city, lat: $lat, lng: $lng, timezone: $timezone, hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            const DeepCollectionEquality().equals(other._hours, _hours));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, city, lat, lng,
      timezone, const DeepCollectionEquality().hash(_hours));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchDtoImplCopyWith<_$BranchDtoImpl> get copyWith =>
      __$$BranchDtoImplCopyWithImpl<_$BranchDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchDtoImplToJson(
      this,
    );
  }
}

abstract class _BranchDto implements BranchDto {
  const factory _BranchDto(
      {required final int id,
      required final String name,
      final String city,
      final String lat,
      final String lng,
      final String timezone,
      final List<BranchHoursDto> hours}) = _$BranchDtoImpl;

  factory _BranchDto.fromJson(Map<String, dynamic> json) =
      _$BranchDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get city;
  @override
  String get lat;
  @override
  String get lng;
  @override
  String get timezone;
  @override
  List<BranchHoursDto> get hours;
  @override
  @JsonKey(ignore: true)
  _$$BranchDtoImplCopyWith<_$BranchDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
