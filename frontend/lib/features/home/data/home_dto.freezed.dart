// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeSectionDto _$HomeSectionDtoFromJson(Map<String, dynamic> json) {
  return _HomeSectionDto.fromJson(json);
}

/// @nodoc
mixin _$HomeSectionDto {
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get cta => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'deep_link')
  String? get deepLink => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_from')
  String? get validFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_until')
  String? get validUntil =>
      throw _privateConstructorUsedError; // Hero carousel: list of banner objects
  List<BannerDto> get banners => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeSectionDtoCopyWith<HomeSectionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSectionDtoCopyWith<$Res> {
  factory $HomeSectionDtoCopyWith(
          HomeSectionDto value, $Res Function(HomeSectionDto) then) =
      _$HomeSectionDtoCopyWithImpl<$Res, HomeSectionDto>;
  @useResult
  $Res call(
      {String type,
      String? title,
      String? text,
      String? cta,
      String? image,
      @JsonKey(name: 'deep_link') String? deepLink,
      String? source,
      @JsonKey(name: 'valid_from') String? validFrom,
      @JsonKey(name: 'valid_until') String? validUntil,
      List<BannerDto> banners});
}

/// @nodoc
class _$HomeSectionDtoCopyWithImpl<$Res, $Val extends HomeSectionDto>
    implements $HomeSectionDtoCopyWith<$Res> {
  _$HomeSectionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = freezed,
    Object? text = freezed,
    Object? cta = freezed,
    Object? image = freezed,
    Object? deepLink = freezed,
    Object? source = freezed,
    Object? validFrom = freezed,
    Object? validUntil = freezed,
    Object? banners = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      cta: freezed == cta
          ? _value.cta
          : cta // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      deepLink: freezed == deepLink
          ? _value.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      validFrom: freezed == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      banners: null == banners
          ? _value.banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeSectionDtoImplCopyWith<$Res>
    implements $HomeSectionDtoCopyWith<$Res> {
  factory _$$HomeSectionDtoImplCopyWith(_$HomeSectionDtoImpl value,
          $Res Function(_$HomeSectionDtoImpl) then) =
      __$$HomeSectionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? title,
      String? text,
      String? cta,
      String? image,
      @JsonKey(name: 'deep_link') String? deepLink,
      String? source,
      @JsonKey(name: 'valid_from') String? validFrom,
      @JsonKey(name: 'valid_until') String? validUntil,
      List<BannerDto> banners});
}

/// @nodoc
class __$$HomeSectionDtoImplCopyWithImpl<$Res>
    extends _$HomeSectionDtoCopyWithImpl<$Res, _$HomeSectionDtoImpl>
    implements _$$HomeSectionDtoImplCopyWith<$Res> {
  __$$HomeSectionDtoImplCopyWithImpl(
      _$HomeSectionDtoImpl _value, $Res Function(_$HomeSectionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = freezed,
    Object? text = freezed,
    Object? cta = freezed,
    Object? image = freezed,
    Object? deepLink = freezed,
    Object? source = freezed,
    Object? validFrom = freezed,
    Object? validUntil = freezed,
    Object? banners = null,
  }) {
    return _then(_$HomeSectionDtoImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      cta: freezed == cta
          ? _value.cta
          : cta // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      deepLink: freezed == deepLink
          ? _value.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      validFrom: freezed == validFrom
          ? _value.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      banners: null == banners
          ? _value._banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeSectionDtoImpl implements _HomeSectionDto {
  const _$HomeSectionDtoImpl(
      {required this.type,
      this.title,
      this.text,
      this.cta,
      this.image,
      @JsonKey(name: 'deep_link') this.deepLink,
      this.source,
      @JsonKey(name: 'valid_from') this.validFrom,
      @JsonKey(name: 'valid_until') this.validUntil,
      final List<BannerDto> banners = const []})
      : _banners = banners;

  factory _$HomeSectionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeSectionDtoImplFromJson(json);

  @override
  final String type;
  @override
  final String? title;
  @override
  final String? text;
  @override
  final String? cta;
  @override
  final String? image;
  @override
  @JsonKey(name: 'deep_link')
  final String? deepLink;
  @override
  final String? source;
  @override
  @JsonKey(name: 'valid_from')
  final String? validFrom;
  @override
  @JsonKey(name: 'valid_until')
  final String? validUntil;
// Hero carousel: list of banner objects
  final List<BannerDto> _banners;
// Hero carousel: list of banner objects
  @override
  @JsonKey()
  List<BannerDto> get banners {
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banners);
  }

  @override
  String toString() {
    return 'HomeSectionDto(type: $type, title: $title, text: $text, cta: $cta, image: $image, deepLink: $deepLink, source: $source, validFrom: $validFrom, validUntil: $validUntil, banners: $banners)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSectionDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.cta, cta) || other.cta == cta) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            const DeepCollectionEquality().equals(other._banners, _banners));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      title,
      text,
      cta,
      image,
      deepLink,
      source,
      validFrom,
      validUntil,
      const DeepCollectionEquality().hash(_banners));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSectionDtoImplCopyWith<_$HomeSectionDtoImpl> get copyWith =>
      __$$HomeSectionDtoImplCopyWithImpl<_$HomeSectionDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeSectionDtoImplToJson(
      this,
    );
  }
}

abstract class _HomeSectionDto implements HomeSectionDto {
  const factory _HomeSectionDto(
      {required final String type,
      final String? title,
      final String? text,
      final String? cta,
      final String? image,
      @JsonKey(name: 'deep_link') final String? deepLink,
      final String? source,
      @JsonKey(name: 'valid_from') final String? validFrom,
      @JsonKey(name: 'valid_until') final String? validUntil,
      final List<BannerDto> banners}) = _$HomeSectionDtoImpl;

  factory _HomeSectionDto.fromJson(Map<String, dynamic> json) =
      _$HomeSectionDtoImpl.fromJson;

  @override
  String get type;
  @override
  String? get title;
  @override
  String? get text;
  @override
  String? get cta;
  @override
  String? get image;
  @override
  @JsonKey(name: 'deep_link')
  String? get deepLink;
  @override
  String? get source;
  @override
  @JsonKey(name: 'valid_from')
  String? get validFrom;
  @override
  @JsonKey(name: 'valid_until')
  String? get validUntil;
  @override // Hero carousel: list of banner objects
  List<BannerDto> get banners;
  @override
  @JsonKey(ignore: true)
  _$$HomeSectionDtoImplCopyWith<_$HomeSectionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BannerDto _$BannerDtoFromJson(Map<String, dynamic> json) {
  return _BannerDto.fromJson(json);
}

/// @nodoc
mixin _$BannerDto {
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get cta => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get gradient => throw _privateConstructorUsedError;
  @JsonKey(name: 'deep_link')
  String? get deepLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'valid_until')
  String? get validUntil => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BannerDtoCopyWith<BannerDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerDtoCopyWith<$Res> {
  factory $BannerDtoCopyWith(BannerDto value, $Res Function(BannerDto) then) =
      _$BannerDtoCopyWithImpl<$Res, BannerDto>;
  @useResult
  $Res call(
      {String title,
      String? subtitle,
      String? cta,
      String? image,
      String? gradient,
      @JsonKey(name: 'deep_link') String? deepLink,
      @JsonKey(name: 'valid_until') String? validUntil});
}

/// @nodoc
class _$BannerDtoCopyWithImpl<$Res, $Val extends BannerDto>
    implements $BannerDtoCopyWith<$Res> {
  _$BannerDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = freezed,
    Object? cta = freezed,
    Object? image = freezed,
    Object? gradient = freezed,
    Object? deepLink = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      cta: freezed == cta
          ? _value.cta
          : cta // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      gradient: freezed == gradient
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as String?,
      deepLink: freezed == deepLink
          ? _value.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BannerDtoImplCopyWith<$Res>
    implements $BannerDtoCopyWith<$Res> {
  factory _$$BannerDtoImplCopyWith(
          _$BannerDtoImpl value, $Res Function(_$BannerDtoImpl) then) =
      __$$BannerDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? subtitle,
      String? cta,
      String? image,
      String? gradient,
      @JsonKey(name: 'deep_link') String? deepLink,
      @JsonKey(name: 'valid_until') String? validUntil});
}

/// @nodoc
class __$$BannerDtoImplCopyWithImpl<$Res>
    extends _$BannerDtoCopyWithImpl<$Res, _$BannerDtoImpl>
    implements _$$BannerDtoImplCopyWith<$Res> {
  __$$BannerDtoImplCopyWithImpl(
      _$BannerDtoImpl _value, $Res Function(_$BannerDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = freezed,
    Object? cta = freezed,
    Object? image = freezed,
    Object? gradient = freezed,
    Object? deepLink = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_$BannerDtoImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      cta: freezed == cta
          ? _value.cta
          : cta // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      gradient: freezed == gradient
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as String?,
      deepLink: freezed == deepLink
          ? _value.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BannerDtoImpl implements _BannerDto {
  const _$BannerDtoImpl(
      {required this.title,
      this.subtitle,
      this.cta,
      this.image,
      this.gradient,
      @JsonKey(name: 'deep_link') this.deepLink,
      @JsonKey(name: 'valid_until') this.validUntil});

  factory _$BannerDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? cta;
  @override
  final String? image;
  @override
  final String? gradient;
  @override
  @JsonKey(name: 'deep_link')
  final String? deepLink;
  @override
  @JsonKey(name: 'valid_until')
  final String? validUntil;

  @override
  String toString() {
    return 'BannerDto(title: $title, subtitle: $subtitle, cta: $cta, image: $image, gradient: $gradient, deepLink: $deepLink, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.cta, cta) || other.cta == cta) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.gradient, gradient) ||
                other.gradient == gradient) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, subtitle, cta, image, gradient, deepLink, validUntil);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BannerDtoImplCopyWith<_$BannerDtoImpl> get copyWith =>
      __$$BannerDtoImplCopyWithImpl<_$BannerDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerDtoImplToJson(
      this,
    );
  }
}

abstract class _BannerDto implements BannerDto {
  const factory _BannerDto(
          {required final String title,
          final String? subtitle,
          final String? cta,
          final String? image,
          final String? gradient,
          @JsonKey(name: 'deep_link') final String? deepLink,
          @JsonKey(name: 'valid_until') final String? validUntil}) =
      _$BannerDtoImpl;

  factory _BannerDto.fromJson(Map<String, dynamic> json) =
      _$BannerDtoImpl.fromJson;

  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get cta;
  @override
  String? get image;
  @override
  String? get gradient;
  @override
  @JsonKey(name: 'deep_link')
  String? get deepLink;
  @override
  @JsonKey(name: 'valid_until')
  String? get validUntil;
  @override
  @JsonKey(ignore: true)
  _$$BannerDtoImplCopyWith<_$BannerDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
