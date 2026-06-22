// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoyaltyTierDto _$LoyaltyTierDtoFromJson(Map<String, dynamic> json) {
  return _LoyaltyTierDto.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyTierDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_washes')
  int get minWashes => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int get discountPercent => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoyaltyTierDtoCopyWith<LoyaltyTierDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyTierDtoCopyWith<$Res> {
  factory $LoyaltyTierDtoCopyWith(
          LoyaltyTierDto value, $Res Function(LoyaltyTierDto) then) =
      _$LoyaltyTierDtoCopyWithImpl<$Res, LoyaltyTierDto>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'min_washes') int minWashes,
      @JsonKey(name: 'discount_percent') int discountPercent,
      String? color});
}

/// @nodoc
class _$LoyaltyTierDtoCopyWithImpl<$Res, $Val extends LoyaltyTierDto>
    implements $LoyaltyTierDtoCopyWith<$Res> {
  _$LoyaltyTierDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? minWashes = null,
    Object? discountPercent = null,
    Object? color = freezed,
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
      minWashes: null == minWashes
          ? _value.minWashes
          : minWashes // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoyaltyTierDtoImplCopyWith<$Res>
    implements $LoyaltyTierDtoCopyWith<$Res> {
  factory _$$LoyaltyTierDtoImplCopyWith(_$LoyaltyTierDtoImpl value,
          $Res Function(_$LoyaltyTierDtoImpl) then) =
      __$$LoyaltyTierDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'min_washes') int minWashes,
      @JsonKey(name: 'discount_percent') int discountPercent,
      String? color});
}

/// @nodoc
class __$$LoyaltyTierDtoImplCopyWithImpl<$Res>
    extends _$LoyaltyTierDtoCopyWithImpl<$Res, _$LoyaltyTierDtoImpl>
    implements _$$LoyaltyTierDtoImplCopyWith<$Res> {
  __$$LoyaltyTierDtoImplCopyWithImpl(
      _$LoyaltyTierDtoImpl _value, $Res Function(_$LoyaltyTierDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? minWashes = null,
    Object? discountPercent = null,
    Object? color = freezed,
  }) {
    return _then(_$LoyaltyTierDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      minWashes: null == minWashes
          ? _value.minWashes
          : minWashes // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyTierDtoImpl implements _LoyaltyTierDto {
  const _$LoyaltyTierDtoImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'min_washes') required this.minWashes,
      @JsonKey(name: 'discount_percent') required this.discountPercent,
      this.color});

  factory _$LoyaltyTierDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyTierDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'min_washes')
  final int minWashes;
  @override
  @JsonKey(name: 'discount_percent')
  final int discountPercent;
  @override
  final String? color;

  @override
  String toString() {
    return 'LoyaltyTierDto(id: $id, name: $name, minWashes: $minWashes, discountPercent: $discountPercent, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyTierDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.minWashes, minWashes) ||
                other.minWashes == minWashes) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, minWashes, discountPercent, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyTierDtoImplCopyWith<_$LoyaltyTierDtoImpl> get copyWith =>
      __$$LoyaltyTierDtoImplCopyWithImpl<_$LoyaltyTierDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyTierDtoImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyTierDto implements LoyaltyTierDto {
  const factory _LoyaltyTierDto(
      {required final int id,
      required final String name,
      @JsonKey(name: 'min_washes') required final int minWashes,
      @JsonKey(name: 'discount_percent') required final int discountPercent,
      final String? color}) = _$LoyaltyTierDtoImpl;

  factory _LoyaltyTierDto.fromJson(Map<String, dynamic> json) =
      _$LoyaltyTierDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'min_washes')
  int get minWashes;
  @override
  @JsonKey(name: 'discount_percent')
  int get discountPercent;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$LoyaltyTierDtoImplCopyWith<_$LoyaltyTierDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoyaltyStatusDto _$LoyaltyStatusDtoFromJson(Map<String, dynamic> json) {
  return _LoyaltyStatusDto.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyStatusDto {
  @JsonKey(name: 'washes_count')
  int get washesCount => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_tier')
  LoyaltyTierDto? get currentTier => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_tier')
  LoyaltyTierDto? get nextTier => throw _privateConstructorUsedError;
  @JsonKey(name: 'washes_to_next')
  int? get washesToNext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoyaltyStatusDtoCopyWith<LoyaltyStatusDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyStatusDtoCopyWith<$Res> {
  factory $LoyaltyStatusDtoCopyWith(
          LoyaltyStatusDto value, $Res Function(LoyaltyStatusDto) then) =
      _$LoyaltyStatusDtoCopyWithImpl<$Res, LoyaltyStatusDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'washes_count') int washesCount,
      int points,
      @JsonKey(name: 'current_tier') LoyaltyTierDto? currentTier,
      @JsonKey(name: 'next_tier') LoyaltyTierDto? nextTier,
      @JsonKey(name: 'washes_to_next') int? washesToNext});

  $LoyaltyTierDtoCopyWith<$Res>? get currentTier;
  $LoyaltyTierDtoCopyWith<$Res>? get nextTier;
}

/// @nodoc
class _$LoyaltyStatusDtoCopyWithImpl<$Res, $Val extends LoyaltyStatusDto>
    implements $LoyaltyStatusDtoCopyWith<$Res> {
  _$LoyaltyStatusDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? washesCount = null,
    Object? points = null,
    Object? currentTier = freezed,
    Object? nextTier = freezed,
    Object? washesToNext = freezed,
  }) {
    return _then(_value.copyWith(
      washesCount: null == washesCount
          ? _value.washesCount
          : washesCount // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      currentTier: freezed == currentTier
          ? _value.currentTier
          : currentTier // ignore: cast_nullable_to_non_nullable
              as LoyaltyTierDto?,
      nextTier: freezed == nextTier
          ? _value.nextTier
          : nextTier // ignore: cast_nullable_to_non_nullable
              as LoyaltyTierDto?,
      washesToNext: freezed == washesToNext
          ? _value.washesToNext
          : washesToNext // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoyaltyTierDtoCopyWith<$Res>? get currentTier {
    if (_value.currentTier == null) {
      return null;
    }

    return $LoyaltyTierDtoCopyWith<$Res>(_value.currentTier!, (value) {
      return _then(_value.copyWith(currentTier: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LoyaltyTierDtoCopyWith<$Res>? get nextTier {
    if (_value.nextTier == null) {
      return null;
    }

    return $LoyaltyTierDtoCopyWith<$Res>(_value.nextTier!, (value) {
      return _then(_value.copyWith(nextTier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoyaltyStatusDtoImplCopyWith<$Res>
    implements $LoyaltyStatusDtoCopyWith<$Res> {
  factory _$$LoyaltyStatusDtoImplCopyWith(_$LoyaltyStatusDtoImpl value,
          $Res Function(_$LoyaltyStatusDtoImpl) then) =
      __$$LoyaltyStatusDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'washes_count') int washesCount,
      int points,
      @JsonKey(name: 'current_tier') LoyaltyTierDto? currentTier,
      @JsonKey(name: 'next_tier') LoyaltyTierDto? nextTier,
      @JsonKey(name: 'washes_to_next') int? washesToNext});

  @override
  $LoyaltyTierDtoCopyWith<$Res>? get currentTier;
  @override
  $LoyaltyTierDtoCopyWith<$Res>? get nextTier;
}

/// @nodoc
class __$$LoyaltyStatusDtoImplCopyWithImpl<$Res>
    extends _$LoyaltyStatusDtoCopyWithImpl<$Res, _$LoyaltyStatusDtoImpl>
    implements _$$LoyaltyStatusDtoImplCopyWith<$Res> {
  __$$LoyaltyStatusDtoImplCopyWithImpl(_$LoyaltyStatusDtoImpl _value,
      $Res Function(_$LoyaltyStatusDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? washesCount = null,
    Object? points = null,
    Object? currentTier = freezed,
    Object? nextTier = freezed,
    Object? washesToNext = freezed,
  }) {
    return _then(_$LoyaltyStatusDtoImpl(
      washesCount: null == washesCount
          ? _value.washesCount
          : washesCount // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      currentTier: freezed == currentTier
          ? _value.currentTier
          : currentTier // ignore: cast_nullable_to_non_nullable
              as LoyaltyTierDto?,
      nextTier: freezed == nextTier
          ? _value.nextTier
          : nextTier // ignore: cast_nullable_to_non_nullable
              as LoyaltyTierDto?,
      washesToNext: freezed == washesToNext
          ? _value.washesToNext
          : washesToNext // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyStatusDtoImpl implements _LoyaltyStatusDto {
  const _$LoyaltyStatusDtoImpl(
      {@JsonKey(name: 'washes_count') required this.washesCount,
      required this.points,
      @JsonKey(name: 'current_tier') this.currentTier,
      @JsonKey(name: 'next_tier') this.nextTier,
      @JsonKey(name: 'washes_to_next') this.washesToNext});

  factory _$LoyaltyStatusDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyStatusDtoImplFromJson(json);

  @override
  @JsonKey(name: 'washes_count')
  final int washesCount;
  @override
  final int points;
  @override
  @JsonKey(name: 'current_tier')
  final LoyaltyTierDto? currentTier;
  @override
  @JsonKey(name: 'next_tier')
  final LoyaltyTierDto? nextTier;
  @override
  @JsonKey(name: 'washes_to_next')
  final int? washesToNext;

  @override
  String toString() {
    return 'LoyaltyStatusDto(washesCount: $washesCount, points: $points, currentTier: $currentTier, nextTier: $nextTier, washesToNext: $washesToNext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyStatusDtoImpl &&
            (identical(other.washesCount, washesCount) ||
                other.washesCount == washesCount) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.currentTier, currentTier) ||
                other.currentTier == currentTier) &&
            (identical(other.nextTier, nextTier) ||
                other.nextTier == nextTier) &&
            (identical(other.washesToNext, washesToNext) ||
                other.washesToNext == washesToNext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, washesCount, points, currentTier, nextTier, washesToNext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyStatusDtoImplCopyWith<_$LoyaltyStatusDtoImpl> get copyWith =>
      __$$LoyaltyStatusDtoImplCopyWithImpl<_$LoyaltyStatusDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyStatusDtoImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyStatusDto implements LoyaltyStatusDto {
  const factory _LoyaltyStatusDto(
          {@JsonKey(name: 'washes_count') required final int washesCount,
          required final int points,
          @JsonKey(name: 'current_tier') final LoyaltyTierDto? currentTier,
          @JsonKey(name: 'next_tier') final LoyaltyTierDto? nextTier,
          @JsonKey(name: 'washes_to_next') final int? washesToNext}) =
      _$LoyaltyStatusDtoImpl;

  factory _LoyaltyStatusDto.fromJson(Map<String, dynamic> json) =
      _$LoyaltyStatusDtoImpl.fromJson;

  @override
  @JsonKey(name: 'washes_count')
  int get washesCount;
  @override
  int get points;
  @override
  @JsonKey(name: 'current_tier')
  LoyaltyTierDto? get currentTier;
  @override
  @JsonKey(name: 'next_tier')
  LoyaltyTierDto? get nextTier;
  @override
  @JsonKey(name: 'washes_to_next')
  int? get washesToNext;
  @override
  @JsonKey(ignore: true)
  _$$LoyaltyStatusDtoImplCopyWith<_$LoyaltyStatusDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReferralDto _$ReferralDtoFromJson(Map<String, dynamic> json) {
  return _ReferralDto.fromJson(json);
}

/// @nodoc
mixin _$ReferralDto {
  @JsonKey(name: 'referral_code')
  String get referralCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_referrals')
  int get totalReferrals => throw _privateConstructorUsedError;
  @JsonKey(name: 'points_earned')
  int get pointsEarned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferralDtoCopyWith<ReferralDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralDtoCopyWith<$Res> {
  factory $ReferralDtoCopyWith(
          ReferralDto value, $Res Function(ReferralDto) then) =
      _$ReferralDtoCopyWithImpl<$Res, ReferralDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'referral_code') String referralCode,
      @JsonKey(name: 'total_referrals') int totalReferrals,
      @JsonKey(name: 'points_earned') int pointsEarned});
}

/// @nodoc
class _$ReferralDtoCopyWithImpl<$Res, $Val extends ReferralDto>
    implements $ReferralDtoCopyWith<$Res> {
  _$ReferralDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCode = null,
    Object? totalReferrals = null,
    Object? pointsEarned = null,
  }) {
    return _then(_value.copyWith(
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      totalReferrals: null == totalReferrals
          ? _value.totalReferrals
          : totalReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferralDtoImplCopyWith<$Res>
    implements $ReferralDtoCopyWith<$Res> {
  factory _$$ReferralDtoImplCopyWith(
          _$ReferralDtoImpl value, $Res Function(_$ReferralDtoImpl) then) =
      __$$ReferralDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'referral_code') String referralCode,
      @JsonKey(name: 'total_referrals') int totalReferrals,
      @JsonKey(name: 'points_earned') int pointsEarned});
}

/// @nodoc
class __$$ReferralDtoImplCopyWithImpl<$Res>
    extends _$ReferralDtoCopyWithImpl<$Res, _$ReferralDtoImpl>
    implements _$$ReferralDtoImplCopyWith<$Res> {
  __$$ReferralDtoImplCopyWithImpl(
      _$ReferralDtoImpl _value, $Res Function(_$ReferralDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCode = null,
    Object? totalReferrals = null,
    Object? pointsEarned = null,
  }) {
    return _then(_$ReferralDtoImpl(
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      totalReferrals: null == totalReferrals
          ? _value.totalReferrals
          : totalReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferralDtoImpl implements _ReferralDto {
  const _$ReferralDtoImpl(
      {@JsonKey(name: 'referral_code') required this.referralCode,
      @JsonKey(name: 'total_referrals') this.totalReferrals = 0,
      @JsonKey(name: 'points_earned') this.pointsEarned = 0});

  factory _$ReferralDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferralDtoImplFromJson(json);

  @override
  @JsonKey(name: 'referral_code')
  final String referralCode;
  @override
  @JsonKey(name: 'total_referrals')
  final int totalReferrals;
  @override
  @JsonKey(name: 'points_earned')
  final int pointsEarned;

  @override
  String toString() {
    return 'ReferralDto(referralCode: $referralCode, totalReferrals: $totalReferrals, pointsEarned: $pointsEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralDtoImpl &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.totalReferrals, totalReferrals) ||
                other.totalReferrals == totalReferrals) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, referralCode, totalReferrals, pointsEarned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralDtoImplCopyWith<_$ReferralDtoImpl> get copyWith =>
      __$$ReferralDtoImplCopyWithImpl<_$ReferralDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferralDtoImplToJson(
      this,
    );
  }
}

abstract class _ReferralDto implements ReferralDto {
  const factory _ReferralDto(
          {@JsonKey(name: 'referral_code') required final String referralCode,
          @JsonKey(name: 'total_referrals') final int totalReferrals,
          @JsonKey(name: 'points_earned') final int pointsEarned}) =
      _$ReferralDtoImpl;

  factory _ReferralDto.fromJson(Map<String, dynamic> json) =
      _$ReferralDtoImpl.fromJson;

  @override
  @JsonKey(name: 'referral_code')
  String get referralCode;
  @override
  @JsonKey(name: 'total_referrals')
  int get totalReferrals;
  @override
  @JsonKey(name: 'points_earned')
  int get pointsEarned;
  @override
  @JsonKey(ignore: true)
  _$$ReferralDtoImplCopyWith<_$ReferralDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
