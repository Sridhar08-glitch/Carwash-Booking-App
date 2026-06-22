// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpRequestDto _$OtpRequestDtoFromJson(Map<String, dynamic> json) {
  return _OtpRequestDto.fromJson(json);
}

/// @nodoc
mixin _$OtpRequestDto {
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpRequestDtoCopyWith<OtpRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpRequestDtoCopyWith<$Res> {
  factory $OtpRequestDtoCopyWith(
          OtpRequestDto value, $Res Function(OtpRequestDto) then) =
      _$OtpRequestDtoCopyWithImpl<$Res, OtpRequestDto>;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class _$OtpRequestDtoCopyWithImpl<$Res, $Val extends OtpRequestDto>
    implements $OtpRequestDtoCopyWith<$Res> {
  _$OtpRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpRequestDtoImplCopyWith<$Res>
    implements $OtpRequestDtoCopyWith<$Res> {
  factory _$$OtpRequestDtoImplCopyWith(
          _$OtpRequestDtoImpl value, $Res Function(_$OtpRequestDtoImpl) then) =
      __$$OtpRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$$OtpRequestDtoImplCopyWithImpl<$Res>
    extends _$OtpRequestDtoCopyWithImpl<$Res, _$OtpRequestDtoImpl>
    implements _$$OtpRequestDtoImplCopyWith<$Res> {
  __$$OtpRequestDtoImplCopyWithImpl(
      _$OtpRequestDtoImpl _value, $Res Function(_$OtpRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$OtpRequestDtoImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpRequestDtoImpl implements _OtpRequestDto {
  const _$OtpRequestDtoImpl({required this.phone});

  factory _$OtpRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpRequestDtoImplFromJson(json);

  @override
  final String phone;

  @override
  String toString() {
    return 'OtpRequestDto(phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpRequestDtoImpl &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpRequestDtoImplCopyWith<_$OtpRequestDtoImpl> get copyWith =>
      __$$OtpRequestDtoImplCopyWithImpl<_$OtpRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _OtpRequestDto implements OtpRequestDto {
  const factory _OtpRequestDto({required final String phone}) =
      _$OtpRequestDtoImpl;

  factory _OtpRequestDto.fromJson(Map<String, dynamic> json) =
      _$OtpRequestDtoImpl.fromJson;

  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$$OtpRequestDtoImplCopyWith<_$OtpRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpVerifyDto _$OtpVerifyDtoFromJson(Map<String, dynamic> json) {
  return _OtpVerifyDto.fromJson(json);
}

/// @nodoc
mixin _$OtpVerifyDto {
  String get phone => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpVerifyDtoCopyWith<OtpVerifyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerifyDtoCopyWith<$Res> {
  factory $OtpVerifyDtoCopyWith(
          OtpVerifyDto value, $Res Function(OtpVerifyDto) then) =
      _$OtpVerifyDtoCopyWithImpl<$Res, OtpVerifyDto>;
  @useResult
  $Res call({String phone, String code});
}

/// @nodoc
class _$OtpVerifyDtoCopyWithImpl<$Res, $Val extends OtpVerifyDto>
    implements $OtpVerifyDtoCopyWith<$Res> {
  _$OtpVerifyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpVerifyDtoImplCopyWith<$Res>
    implements $OtpVerifyDtoCopyWith<$Res> {
  factory _$$OtpVerifyDtoImplCopyWith(
          _$OtpVerifyDtoImpl value, $Res Function(_$OtpVerifyDtoImpl) then) =
      __$$OtpVerifyDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phone, String code});
}

/// @nodoc
class __$$OtpVerifyDtoImplCopyWithImpl<$Res>
    extends _$OtpVerifyDtoCopyWithImpl<$Res, _$OtpVerifyDtoImpl>
    implements _$$OtpVerifyDtoImplCopyWith<$Res> {
  __$$OtpVerifyDtoImplCopyWithImpl(
      _$OtpVerifyDtoImpl _value, $Res Function(_$OtpVerifyDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? code = null,
  }) {
    return _then(_$OtpVerifyDtoImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerifyDtoImpl implements _OtpVerifyDto {
  const _$OtpVerifyDtoImpl({required this.phone, required this.code});

  factory _$OtpVerifyDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerifyDtoImplFromJson(json);

  @override
  final String phone;
  @override
  final String code;

  @override
  String toString() {
    return 'OtpVerifyDto(phone: $phone, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerifyDtoImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerifyDtoImplCopyWith<_$OtpVerifyDtoImpl> get copyWith =>
      __$$OtpVerifyDtoImplCopyWithImpl<_$OtpVerifyDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerifyDtoImplToJson(
      this,
    );
  }
}

abstract class _OtpVerifyDto implements OtpVerifyDto {
  const factory _OtpVerifyDto(
      {required final String phone,
      required final String code}) = _$OtpVerifyDtoImpl;

  factory _OtpVerifyDto.fromJson(Map<String, dynamic> json) =
      _$OtpVerifyDtoImpl.fromJson;

  @override
  String get phone;
  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$OtpVerifyDtoImplCopyWith<_$OtpVerifyDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RefreshDto _$RefreshDtoFromJson(Map<String, dynamic> json) {
  return _RefreshDto.fromJson(json);
}

/// @nodoc
mixin _$RefreshDto {
  String get refresh => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefreshDtoCopyWith<RefreshDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshDtoCopyWith<$Res> {
  factory $RefreshDtoCopyWith(
          RefreshDto value, $Res Function(RefreshDto) then) =
      _$RefreshDtoCopyWithImpl<$Res, RefreshDto>;
  @useResult
  $Res call({String refresh});
}

/// @nodoc
class _$RefreshDtoCopyWithImpl<$Res, $Val extends RefreshDto>
    implements $RefreshDtoCopyWith<$Res> {
  _$RefreshDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh = null,
  }) {
    return _then(_value.copyWith(
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefreshDtoImplCopyWith<$Res>
    implements $RefreshDtoCopyWith<$Res> {
  factory _$$RefreshDtoImplCopyWith(
          _$RefreshDtoImpl value, $Res Function(_$RefreshDtoImpl) then) =
      __$$RefreshDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refresh});
}

/// @nodoc
class __$$RefreshDtoImplCopyWithImpl<$Res>
    extends _$RefreshDtoCopyWithImpl<$Res, _$RefreshDtoImpl>
    implements _$$RefreshDtoImplCopyWith<$Res> {
  __$$RefreshDtoImplCopyWithImpl(
      _$RefreshDtoImpl _value, $Res Function(_$RefreshDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh = null,
  }) {
    return _then(_$RefreshDtoImpl(
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshDtoImpl implements _RefreshDto {
  const _$RefreshDtoImpl({required this.refresh});

  factory _$RefreshDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshDtoImplFromJson(json);

  @override
  final String refresh;

  @override
  String toString() {
    return 'RefreshDto(refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshDtoImpl &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, refresh);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshDtoImplCopyWith<_$RefreshDtoImpl> get copyWith =>
      __$$RefreshDtoImplCopyWithImpl<_$RefreshDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshDtoImplToJson(
      this,
    );
  }
}

abstract class _RefreshDto implements RefreshDto {
  const factory _RefreshDto({required final String refresh}) = _$RefreshDtoImpl;

  factory _RefreshDto.fromJson(Map<String, dynamic> json) =
      _$RefreshDtoImpl.fromJson;

  @override
  String get refresh;
  @override
  @JsonKey(ignore: true)
  _$$RefreshDtoImplCopyWith<_$RefreshDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokensDto _$TokensDtoFromJson(Map<String, dynamic> json) {
  return _TokensDto.fromJson(json);
}

/// @nodoc
mixin _$TokensDto {
  String get access => throw _privateConstructorUsedError;
  String get refresh => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokensDtoCopyWith<TokensDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensDtoCopyWith<$Res> {
  factory $TokensDtoCopyWith(TokensDto value, $Res Function(TokensDto) then) =
      _$TokensDtoCopyWithImpl<$Res, TokensDto>;
  @useResult
  $Res call({String access, String refresh});
}

/// @nodoc
class _$TokensDtoCopyWithImpl<$Res, $Val extends TokensDto>
    implements $TokensDtoCopyWith<$Res> {
  _$TokensDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access = null,
    Object? refresh = null,
  }) {
    return _then(_value.copyWith(
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokensDtoImplCopyWith<$Res>
    implements $TokensDtoCopyWith<$Res> {
  factory _$$TokensDtoImplCopyWith(
          _$TokensDtoImpl value, $Res Function(_$TokensDtoImpl) then) =
      __$$TokensDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String access, String refresh});
}

/// @nodoc
class __$$TokensDtoImplCopyWithImpl<$Res>
    extends _$TokensDtoCopyWithImpl<$Res, _$TokensDtoImpl>
    implements _$$TokensDtoImplCopyWith<$Res> {
  __$$TokensDtoImplCopyWithImpl(
      _$TokensDtoImpl _value, $Res Function(_$TokensDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access = null,
    Object? refresh = null,
  }) {
    return _then(_$TokensDtoImpl(
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokensDtoImpl implements _TokensDto {
  const _$TokensDtoImpl({required this.access, required this.refresh});

  factory _$TokensDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokensDtoImplFromJson(json);

  @override
  final String access;
  @override
  final String refresh;

  @override
  String toString() {
    return 'TokensDto(access: $access, refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensDtoImpl &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, access, refresh);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensDtoImplCopyWith<_$TokensDtoImpl> get copyWith =>
      __$$TokensDtoImplCopyWithImpl<_$TokensDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokensDtoImplToJson(
      this,
    );
  }
}

abstract class _TokensDto implements TokensDto {
  const factory _TokensDto(
      {required final String access,
      required final String refresh}) = _$TokensDtoImpl;

  factory _TokensDto.fromJson(Map<String, dynamic> json) =
      _$TokensDtoImpl.fromJson;

  @override
  String get access;
  @override
  String get refresh;
  @override
  @JsonKey(ignore: true)
  _$$TokensDtoImplCopyWith<_$TokensDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthUserDto _$AuthUserDtoFromJson(Map<String, dynamic> json) {
  return _AuthUserDto.fromJson(json);
}

/// @nodoc
mixin _$AuthUserDto {
  int get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_phone_verified')
  bool get isPhoneVerified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthUserDtoCopyWith<AuthUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserDtoCopyWith<$Res> {
  factory $AuthUserDtoCopyWith(
          AuthUserDto value, $Res Function(AuthUserDto) then) =
      _$AuthUserDtoCopyWithImpl<$Res, AuthUserDto>;
  @useResult
  $Res call(
      {int id,
      String phone,
      String? email,
      String role,
      @JsonKey(name: 'is_phone_verified') bool isPhoneVerified});
}

/// @nodoc
class _$AuthUserDtoCopyWithImpl<$Res, $Val extends AuthUserDto>
    implements $AuthUserDtoCopyWith<$Res> {
  _$AuthUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? email = freezed,
    Object? role = null,
    Object? isPhoneVerified = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserDtoImplCopyWith<$Res>
    implements $AuthUserDtoCopyWith<$Res> {
  factory _$$AuthUserDtoImplCopyWith(
          _$AuthUserDtoImpl value, $Res Function(_$AuthUserDtoImpl) then) =
      __$$AuthUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String phone,
      String? email,
      String role,
      @JsonKey(name: 'is_phone_verified') bool isPhoneVerified});
}

/// @nodoc
class __$$AuthUserDtoImplCopyWithImpl<$Res>
    extends _$AuthUserDtoCopyWithImpl<$Res, _$AuthUserDtoImpl>
    implements _$$AuthUserDtoImplCopyWith<$Res> {
  __$$AuthUserDtoImplCopyWithImpl(
      _$AuthUserDtoImpl _value, $Res Function(_$AuthUserDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? email = freezed,
    Object? role = null,
    Object? isPhoneVerified = null,
  }) {
    return _then(_$AuthUserDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserDtoImpl implements _AuthUserDto {
  const _$AuthUserDtoImpl(
      {required this.id,
      required this.phone,
      this.email,
      required this.role,
      @JsonKey(name: 'is_phone_verified') this.isPhoneVerified = false});

  factory _$AuthUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String phone;
  @override
  final String? email;
  @override
  final String role;
  @override
  @JsonKey(name: 'is_phone_verified')
  final bool isPhoneVerified;

  @override
  String toString() {
    return 'AuthUserDto(id: $id, phone: $phone, email: $email, role: $role, isPhoneVerified: $isPhoneVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, phone, email, role, isPhoneVerified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserDtoImplCopyWith<_$AuthUserDtoImpl> get copyWith =>
      __$$AuthUserDtoImplCopyWithImpl<_$AuthUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserDtoImplToJson(
      this,
    );
  }
}

abstract class _AuthUserDto implements AuthUserDto {
  const factory _AuthUserDto(
          {required final int id,
          required final String phone,
          final String? email,
          required final String role,
          @JsonKey(name: 'is_phone_verified') final bool isPhoneVerified}) =
      _$AuthUserDtoImpl;

  factory _AuthUserDto.fromJson(Map<String, dynamic> json) =
      _$AuthUserDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get phone;
  @override
  String? get email;
  @override
  String get role;
  @override
  @JsonKey(name: 'is_phone_verified')
  bool get isPhoneVerified;
  @override
  @JsonKey(ignore: true)
  _$$AuthUserDtoImplCopyWith<_$AuthUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpVerifyResponseDto _$OtpVerifyResponseDtoFromJson(Map<String, dynamic> json) {
  return _OtpVerifyResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OtpVerifyResponseDto {
  TokensDto get tokens => throw _privateConstructorUsedError;
  AuthUserDto get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new')
  bool get isNew => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpVerifyResponseDtoCopyWith<OtpVerifyResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerifyResponseDtoCopyWith<$Res> {
  factory $OtpVerifyResponseDtoCopyWith(OtpVerifyResponseDto value,
          $Res Function(OtpVerifyResponseDto) then) =
      _$OtpVerifyResponseDtoCopyWithImpl<$Res, OtpVerifyResponseDto>;
  @useResult
  $Res call(
      {TokensDto tokens,
      AuthUserDto user,
      @JsonKey(name: 'is_new') bool isNew});

  $TokensDtoCopyWith<$Res> get tokens;
  $AuthUserDtoCopyWith<$Res> get user;
}

/// @nodoc
class _$OtpVerifyResponseDtoCopyWithImpl<$Res,
        $Val extends OtpVerifyResponseDto>
    implements $OtpVerifyResponseDtoCopyWith<$Res> {
  _$OtpVerifyResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? user = null,
    Object? isNew = null,
  }) {
    return _then(_value.copyWith(
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as TokensDto,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthUserDto,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokensDtoCopyWith<$Res> get tokens {
    return $TokensDtoCopyWith<$Res>(_value.tokens, (value) {
      return _then(_value.copyWith(tokens: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthUserDtoCopyWith<$Res> get user {
    return $AuthUserDtoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtpVerifyResponseDtoImplCopyWith<$Res>
    implements $OtpVerifyResponseDtoCopyWith<$Res> {
  factory _$$OtpVerifyResponseDtoImplCopyWith(_$OtpVerifyResponseDtoImpl value,
          $Res Function(_$OtpVerifyResponseDtoImpl) then) =
      __$$OtpVerifyResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TokensDto tokens,
      AuthUserDto user,
      @JsonKey(name: 'is_new') bool isNew});

  @override
  $TokensDtoCopyWith<$Res> get tokens;
  @override
  $AuthUserDtoCopyWith<$Res> get user;
}

/// @nodoc
class __$$OtpVerifyResponseDtoImplCopyWithImpl<$Res>
    extends _$OtpVerifyResponseDtoCopyWithImpl<$Res, _$OtpVerifyResponseDtoImpl>
    implements _$$OtpVerifyResponseDtoImplCopyWith<$Res> {
  __$$OtpVerifyResponseDtoImplCopyWithImpl(_$OtpVerifyResponseDtoImpl _value,
      $Res Function(_$OtpVerifyResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? user = null,
    Object? isNew = null,
  }) {
    return _then(_$OtpVerifyResponseDtoImpl(
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as TokensDto,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthUserDto,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerifyResponseDtoImpl implements _OtpVerifyResponseDto {
  const _$OtpVerifyResponseDtoImpl(
      {required this.tokens,
      required this.user,
      @JsonKey(name: 'is_new') this.isNew = false});

  factory _$OtpVerifyResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerifyResponseDtoImplFromJson(json);

  @override
  final TokensDto tokens;
  @override
  final AuthUserDto user;
  @override
  @JsonKey(name: 'is_new')
  final bool isNew;

  @override
  String toString() {
    return 'OtpVerifyResponseDto(tokens: $tokens, user: $user, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerifyResponseDtoImpl &&
            (identical(other.tokens, tokens) || other.tokens == tokens) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tokens, user, isNew);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerifyResponseDtoImplCopyWith<_$OtpVerifyResponseDtoImpl>
      get copyWith =>
          __$$OtpVerifyResponseDtoImplCopyWithImpl<_$OtpVerifyResponseDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerifyResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OtpVerifyResponseDto implements OtpVerifyResponseDto {
  const factory _OtpVerifyResponseDto(
      {required final TokensDto tokens,
      required final AuthUserDto user,
      @JsonKey(name: 'is_new') final bool isNew}) = _$OtpVerifyResponseDtoImpl;

  factory _OtpVerifyResponseDto.fromJson(Map<String, dynamic> json) =
      _$OtpVerifyResponseDtoImpl.fromJson;

  @override
  TokensDto get tokens;
  @override
  AuthUserDto get user;
  @override
  @JsonKey(name: 'is_new')
  bool get isNew;
  @override
  @JsonKey(ignore: true)
  _$$OtpVerifyResponseDtoImplCopyWith<_$OtpVerifyResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
