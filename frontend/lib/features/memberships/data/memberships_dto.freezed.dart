// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memberships_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MembershipPlanDto _$MembershipPlanDtoFromJson(Map<String, dynamic> json) {
  return _MembershipPlanDto.fromJson(json);
}

/// @nodoc
mixin _$MembershipPlanDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'billing_period')
  String get billingPeriod => throw _privateConstructorUsedError;
  @JsonKey(name: 'washes_per_period')
  int get washesPerPeriod => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int get discountPercent => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MembershipPlanDtoCopyWith<MembershipPlanDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembershipPlanDtoCopyWith<$Res> {
  factory $MembershipPlanDtoCopyWith(
          MembershipPlanDto value, $Res Function(MembershipPlanDto) then) =
      _$MembershipPlanDtoCopyWithImpl<$Res, MembershipPlanDto>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String price,
      String currency,
      @JsonKey(name: 'billing_period') String billingPeriod,
      @JsonKey(name: 'washes_per_period') int washesPerPeriod,
      @JsonKey(name: 'discount_percent') int discountPercent,
      List<String> features});
}

/// @nodoc
class _$MembershipPlanDtoCopyWithImpl<$Res, $Val extends MembershipPlanDto>
    implements $MembershipPlanDtoCopyWith<$Res> {
  _$MembershipPlanDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? billingPeriod = null,
    Object? washesPerPeriod = null,
    Object? discountPercent = null,
    Object? features = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      billingPeriod: null == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      washesPerPeriod: null == washesPerPeriod
          ? _value.washesPerPeriod
          : washesPerPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MembershipPlanDtoImplCopyWith<$Res>
    implements $MembershipPlanDtoCopyWith<$Res> {
  factory _$$MembershipPlanDtoImplCopyWith(_$MembershipPlanDtoImpl value,
          $Res Function(_$MembershipPlanDtoImpl) then) =
      __$$MembershipPlanDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String price,
      String currency,
      @JsonKey(name: 'billing_period') String billingPeriod,
      @JsonKey(name: 'washes_per_period') int washesPerPeriod,
      @JsonKey(name: 'discount_percent') int discountPercent,
      List<String> features});
}

/// @nodoc
class __$$MembershipPlanDtoImplCopyWithImpl<$Res>
    extends _$MembershipPlanDtoCopyWithImpl<$Res, _$MembershipPlanDtoImpl>
    implements _$$MembershipPlanDtoImplCopyWith<$Res> {
  __$$MembershipPlanDtoImplCopyWithImpl(_$MembershipPlanDtoImpl _value,
      $Res Function(_$MembershipPlanDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? billingPeriod = null,
    Object? washesPerPeriod = null,
    Object? discountPercent = null,
    Object? features = null,
  }) {
    return _then(_$MembershipPlanDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      billingPeriod: null == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      washesPerPeriod: null == washesPerPeriod
          ? _value.washesPerPeriod
          : washesPerPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MembershipPlanDtoImpl implements _MembershipPlanDto {
  const _$MembershipPlanDtoImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      this.currency = 'SAR',
      @JsonKey(name: 'billing_period') required this.billingPeriod,
      @JsonKey(name: 'washes_per_period') required this.washesPerPeriod,
      @JsonKey(name: 'discount_percent') this.discountPercent = 0,
      final List<String> features = const []})
      : _features = features;

  factory _$MembershipPlanDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MembershipPlanDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String price;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'billing_period')
  final String billingPeriod;
  @override
  @JsonKey(name: 'washes_per_period')
  final int washesPerPeriod;
  @override
  @JsonKey(name: 'discount_percent')
  final int discountPercent;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  String toString() {
    return 'MembershipPlanDto(id: $id, name: $name, description: $description, price: $price, currency: $currency, billingPeriod: $billingPeriod, washesPerPeriod: $washesPerPeriod, discountPercent: $discountPercent, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembershipPlanDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.washesPerPeriod, washesPerPeriod) ||
                other.washesPerPeriod == washesPerPeriod) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      price,
      currency,
      billingPeriod,
      washesPerPeriod,
      discountPercent,
      const DeepCollectionEquality().hash(_features));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MembershipPlanDtoImplCopyWith<_$MembershipPlanDtoImpl> get copyWith =>
      __$$MembershipPlanDtoImplCopyWithImpl<_$MembershipPlanDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MembershipPlanDtoImplToJson(
      this,
    );
  }
}

abstract class _MembershipPlanDto implements MembershipPlanDto {
  const factory _MembershipPlanDto(
      {required final int id,
      required final String name,
      required final String description,
      required final String price,
      final String currency,
      @JsonKey(name: 'billing_period') required final String billingPeriod,
      @JsonKey(name: 'washes_per_period') required final int washesPerPeriod,
      @JsonKey(name: 'discount_percent') final int discountPercent,
      final List<String> features}) = _$MembershipPlanDtoImpl;

  factory _MembershipPlanDto.fromJson(Map<String, dynamic> json) =
      _$MembershipPlanDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get price;
  @override
  String get currency;
  @override
  @JsonKey(name: 'billing_period')
  String get billingPeriod;
  @override
  @JsonKey(name: 'washes_per_period')
  int get washesPerPeriod;
  @override
  @JsonKey(name: 'discount_percent')
  int get discountPercent;
  @override
  List<String> get features;
  @override
  @JsonKey(ignore: true)
  _$$MembershipPlanDtoImplCopyWith<_$MembershipPlanDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MyMembershipDto _$MyMembershipDtoFromJson(Map<String, dynamic> json) {
  return _MyMembershipDto.fromJson(json);
}

/// @nodoc
mixin _$MyMembershipDto {
  int get id => throw _privateConstructorUsedError;
  MembershipPlanDto get plan => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_period_start')
  String get currentPeriodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_period_end')
  String get currentPeriodEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'washes_used')
  int get washesUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancel_at_period_end')
  bool get cancelAtPeriodEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyMembershipDtoCopyWith<MyMembershipDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyMembershipDtoCopyWith<$Res> {
  factory $MyMembershipDtoCopyWith(
          MyMembershipDto value, $Res Function(MyMembershipDto) then) =
      _$MyMembershipDtoCopyWithImpl<$Res, MyMembershipDto>;
  @useResult
  $Res call(
      {int id,
      MembershipPlanDto plan,
      String status,
      @JsonKey(name: 'current_period_start') String currentPeriodStart,
      @JsonKey(name: 'current_period_end') String currentPeriodEnd,
      @JsonKey(name: 'washes_used') int washesUsed,
      @JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd});

  $MembershipPlanDtoCopyWith<$Res> get plan;
}

/// @nodoc
class _$MyMembershipDtoCopyWithImpl<$Res, $Val extends MyMembershipDto>
    implements $MyMembershipDtoCopyWith<$Res> {
  _$MyMembershipDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plan = null,
    Object? status = null,
    Object? currentPeriodStart = null,
    Object? currentPeriodEnd = null,
    Object? washesUsed = null,
    Object? cancelAtPeriodEnd = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as MembershipPlanDto,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodStart: null == currentPeriodStart
          ? _value.currentPeriodStart
          : currentPeriodStart // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodEnd: null == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      washesUsed: null == washesUsed
          ? _value.washesUsed
          : washesUsed // ignore: cast_nullable_to_non_nullable
              as int,
      cancelAtPeriodEnd: null == cancelAtPeriodEnd
          ? _value.cancelAtPeriodEnd
          : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MembershipPlanDtoCopyWith<$Res> get plan {
    return $MembershipPlanDtoCopyWith<$Res>(_value.plan, (value) {
      return _then(_value.copyWith(plan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MyMembershipDtoImplCopyWith<$Res>
    implements $MyMembershipDtoCopyWith<$Res> {
  factory _$$MyMembershipDtoImplCopyWith(_$MyMembershipDtoImpl value,
          $Res Function(_$MyMembershipDtoImpl) then) =
      __$$MyMembershipDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      MembershipPlanDto plan,
      String status,
      @JsonKey(name: 'current_period_start') String currentPeriodStart,
      @JsonKey(name: 'current_period_end') String currentPeriodEnd,
      @JsonKey(name: 'washes_used') int washesUsed,
      @JsonKey(name: 'cancel_at_period_end') bool cancelAtPeriodEnd});

  @override
  $MembershipPlanDtoCopyWith<$Res> get plan;
}

/// @nodoc
class __$$MyMembershipDtoImplCopyWithImpl<$Res>
    extends _$MyMembershipDtoCopyWithImpl<$Res, _$MyMembershipDtoImpl>
    implements _$$MyMembershipDtoImplCopyWith<$Res> {
  __$$MyMembershipDtoImplCopyWithImpl(
      _$MyMembershipDtoImpl _value, $Res Function(_$MyMembershipDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plan = null,
    Object? status = null,
    Object? currentPeriodStart = null,
    Object? currentPeriodEnd = null,
    Object? washesUsed = null,
    Object? cancelAtPeriodEnd = null,
  }) {
    return _then(_$MyMembershipDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as MembershipPlanDto,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodStart: null == currentPeriodStart
          ? _value.currentPeriodStart
          : currentPeriodStart // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodEnd: null == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      washesUsed: null == washesUsed
          ? _value.washesUsed
          : washesUsed // ignore: cast_nullable_to_non_nullable
              as int,
      cancelAtPeriodEnd: null == cancelAtPeriodEnd
          ? _value.cancelAtPeriodEnd
          : cancelAtPeriodEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyMembershipDtoImpl implements _MyMembershipDto {
  const _$MyMembershipDtoImpl(
      {required this.id,
      required this.plan,
      required this.status,
      @JsonKey(name: 'current_period_start') required this.currentPeriodStart,
      @JsonKey(name: 'current_period_end') required this.currentPeriodEnd,
      @JsonKey(name: 'washes_used') required this.washesUsed,
      @JsonKey(name: 'cancel_at_period_end') this.cancelAtPeriodEnd = false});

  factory _$MyMembershipDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyMembershipDtoImplFromJson(json);

  @override
  final int id;
  @override
  final MembershipPlanDto plan;
  @override
  final String status;
  @override
  @JsonKey(name: 'current_period_start')
  final String currentPeriodStart;
  @override
  @JsonKey(name: 'current_period_end')
  final String currentPeriodEnd;
  @override
  @JsonKey(name: 'washes_used')
  final int washesUsed;
  @override
  @JsonKey(name: 'cancel_at_period_end')
  final bool cancelAtPeriodEnd;

  @override
  String toString() {
    return 'MyMembershipDto(id: $id, plan: $plan, status: $status, currentPeriodStart: $currentPeriodStart, currentPeriodEnd: $currentPeriodEnd, washesUsed: $washesUsed, cancelAtPeriodEnd: $cancelAtPeriodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyMembershipDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentPeriodStart, currentPeriodStart) ||
                other.currentPeriodStart == currentPeriodStart) &&
            (identical(other.currentPeriodEnd, currentPeriodEnd) ||
                other.currentPeriodEnd == currentPeriodEnd) &&
            (identical(other.washesUsed, washesUsed) ||
                other.washesUsed == washesUsed) &&
            (identical(other.cancelAtPeriodEnd, cancelAtPeriodEnd) ||
                other.cancelAtPeriodEnd == cancelAtPeriodEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, plan, status,
      currentPeriodStart, currentPeriodEnd, washesUsed, cancelAtPeriodEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyMembershipDtoImplCopyWith<_$MyMembershipDtoImpl> get copyWith =>
      __$$MyMembershipDtoImplCopyWithImpl<_$MyMembershipDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyMembershipDtoImplToJson(
      this,
    );
  }
}

abstract class _MyMembershipDto implements MyMembershipDto {
  const factory _MyMembershipDto(
      {required final int id,
      required final MembershipPlanDto plan,
      required final String status,
      @JsonKey(name: 'current_period_start')
      required final String currentPeriodStart,
      @JsonKey(name: 'current_period_end')
      required final String currentPeriodEnd,
      @JsonKey(name: 'washes_used') required final int washesUsed,
      @JsonKey(name: 'cancel_at_period_end')
      final bool cancelAtPeriodEnd}) = _$MyMembershipDtoImpl;

  factory _MyMembershipDto.fromJson(Map<String, dynamic> json) =
      _$MyMembershipDtoImpl.fromJson;

  @override
  int get id;
  @override
  MembershipPlanDto get plan;
  @override
  String get status;
  @override
  @JsonKey(name: 'current_period_start')
  String get currentPeriodStart;
  @override
  @JsonKey(name: 'current_period_end')
  String get currentPeriodEnd;
  @override
  @JsonKey(name: 'washes_used')
  int get washesUsed;
  @override
  @JsonKey(name: 'cancel_at_period_end')
  bool get cancelAtPeriodEnd;
  @override
  @JsonKey(ignore: true)
  _$$MyMembershipDtoImplCopyWith<_$MyMembershipDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
