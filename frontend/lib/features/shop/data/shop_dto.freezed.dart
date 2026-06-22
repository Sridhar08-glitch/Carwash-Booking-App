// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) {
  return _ProductDto.fromJson(json);
}

/// @nodoc
mixin _$ProductDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_description')
  String get shortDescription => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'compare_at_price')
  String? get compareAtPrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  @JsonKey(name: 'car_type')
  String? get carType => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  bool get inStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_count')
  int get reviewCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDtoCopyWith<ProductDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDtoCopyWith<$Res> {
  factory $ProductDtoCopyWith(
          ProductDto value, $Res Function(ProductDto) then) =
      _$ProductDtoCopyWithImpl<$Res, ProductDto>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'short_description') String shortDescription,
      String price,
      @JsonKey(name: 'compare_at_price') String? compareAtPrice,
      String currency,
      String brand,
      @JsonKey(name: 'car_type') String? carType,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<String> images,
      bool inStock,
      @JsonKey(name: 'stock_quantity') int stockQuantity,
      List<String> tags,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount});
}

/// @nodoc
class _$ProductDtoCopyWithImpl<$Res, $Val extends ProductDto>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._value, this._then);

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
    Object? shortDescription = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? currency = null,
    Object? brand = null,
    Object? carType = freezed,
    Object? imageUrl = freezed,
    Object? images = null,
    Object? inStock = null,
    Object? stockQuantity = null,
    Object? tags = null,
    Object? rating = null,
    Object? reviewCount = null,
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
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductDtoImplCopyWith<$Res>
    implements $ProductDtoCopyWith<$Res> {
  factory _$$ProductDtoImplCopyWith(
          _$ProductDtoImpl value, $Res Function(_$ProductDtoImpl) then) =
      __$$ProductDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      @JsonKey(name: 'short_description') String shortDescription,
      String price,
      @JsonKey(name: 'compare_at_price') String? compareAtPrice,
      String currency,
      String brand,
      @JsonKey(name: 'car_type') String? carType,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<String> images,
      bool inStock,
      @JsonKey(name: 'stock_quantity') int stockQuantity,
      List<String> tags,
      double rating,
      @JsonKey(name: 'review_count') int reviewCount});
}

/// @nodoc
class __$$ProductDtoImplCopyWithImpl<$Res>
    extends _$ProductDtoCopyWithImpl<$Res, _$ProductDtoImpl>
    implements _$$ProductDtoImplCopyWith<$Res> {
  __$$ProductDtoImplCopyWithImpl(
      _$ProductDtoImpl _value, $Res Function(_$ProductDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? shortDescription = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? currency = null,
    Object? brand = null,
    Object? carType = freezed,
    Object? imageUrl = freezed,
    Object? images = null,
    Object? inStock = null,
    Object? stockQuantity = null,
    Object? tags = null,
    Object? rating = null,
    Object? reviewCount = null,
  }) {
    return _then(_$ProductDtoImpl(
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
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      stockQuantity: null == stockQuantity
          ? _value.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDtoImpl implements _ProductDto {
  const _$ProductDtoImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'short_description') required this.shortDescription,
      required this.price,
      @JsonKey(name: 'compare_at_price') this.compareAtPrice,
      this.currency = 'SAR',
      required this.brand,
      @JsonKey(name: 'car_type') this.carType,
      @JsonKey(name: 'image_url') this.imageUrl,
      final List<String> images = const [],
      this.inStock = true,
      @JsonKey(name: 'stock_quantity') this.stockQuantity = 0,
      final List<String> tags = const [],
      this.rating = 0.0,
      @JsonKey(name: 'review_count') this.reviewCount = 0})
      : _images = images,
        _tags = tags;

  factory _$ProductDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(name: 'short_description')
  final String shortDescription;
  @override
  final String price;
  @override
  @JsonKey(name: 'compare_at_price')
  final String? compareAtPrice;
  @override
  @JsonKey()
  final String currency;
  @override
  final String brand;
  @override
  @JsonKey(name: 'car_type')
  final String? carType;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final bool inStock;
  @override
  @JsonKey(name: 'stock_quantity')
  final int stockQuantity;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;

  @override
  String toString() {
    return 'ProductDto(id: $id, name: $name, description: $description, shortDescription: $shortDescription, price: $price, compareAtPrice: $compareAtPrice, currency: $currency, brand: $brand, carType: $carType, imageUrl: $imageUrl, images: $images, inStock: $inStock, stockQuantity: $stockQuantity, tags: $tags, rating: $rating, reviewCount: $reviewCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.carType, carType) || other.carType == carType) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      shortDescription,
      price,
      compareAtPrice,
      currency,
      brand,
      carType,
      imageUrl,
      const DeepCollectionEquality().hash(_images),
      inStock,
      stockQuantity,
      const DeepCollectionEquality().hash(_tags),
      rating,
      reviewCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      __$$ProductDtoImplCopyWithImpl<_$ProductDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDtoImplToJson(
      this,
    );
  }
}

abstract class _ProductDto implements ProductDto {
  const factory _ProductDto(
      {required final int id,
      required final String name,
      required final String description,
      @JsonKey(name: 'short_description')
      required final String shortDescription,
      required final String price,
      @JsonKey(name: 'compare_at_price') final String? compareAtPrice,
      final String currency,
      required final String brand,
      @JsonKey(name: 'car_type') final String? carType,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final List<String> images,
      final bool inStock,
      @JsonKey(name: 'stock_quantity') final int stockQuantity,
      final List<String> tags,
      final double rating,
      @JsonKey(name: 'review_count') final int reviewCount}) = _$ProductDtoImpl;

  factory _ProductDto.fromJson(Map<String, dynamic> json) =
      _$ProductDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'short_description')
  String get shortDescription;
  @override
  String get price;
  @override
  @JsonKey(name: 'compare_at_price')
  String? get compareAtPrice;
  @override
  String get currency;
  @override
  String get brand;
  @override
  @JsonKey(name: 'car_type')
  String? get carType;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  List<String> get images;
  @override
  bool get inStock;
  @override
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity;
  @override
  List<String> get tags;
  @override
  double get rating;
  @override
  @JsonKey(name: 'review_count')
  int get reviewCount;
  @override
  @JsonKey(ignore: true)
  _$$ProductDtoImplCopyWith<_$ProductDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductListResponseDto _$ProductListResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _ProductListResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ProductListResponseDto {
  List<ProductDto> get results => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductListResponseDtoCopyWith<ProductListResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListResponseDtoCopyWith<$Res> {
  factory $ProductListResponseDtoCopyWith(ProductListResponseDto value,
          $Res Function(ProductListResponseDto) then) =
      _$ProductListResponseDtoCopyWithImpl<$Res, ProductListResponseDto>;
  @useResult
  $Res call(
      {List<ProductDto> results, int count, String? next, String? previous});
}

/// @nodoc
class _$ProductListResponseDtoCopyWithImpl<$Res,
        $Val extends ProductListResponseDto>
    implements $ProductListResponseDtoCopyWith<$Res> {
  _$ProductListResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ProductDto>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductListResponseDtoImplCopyWith<$Res>
    implements $ProductListResponseDtoCopyWith<$Res> {
  factory _$$ProductListResponseDtoImplCopyWith(
          _$ProductListResponseDtoImpl value,
          $Res Function(_$ProductListResponseDtoImpl) then) =
      __$$ProductListResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductDto> results, int count, String? next, String? previous});
}

/// @nodoc
class __$$ProductListResponseDtoImplCopyWithImpl<$Res>
    extends _$ProductListResponseDtoCopyWithImpl<$Res,
        _$ProductListResponseDtoImpl>
    implements _$$ProductListResponseDtoImplCopyWith<$Res> {
  __$$ProductListResponseDtoImplCopyWithImpl(
      _$ProductListResponseDtoImpl _value,
      $Res Function(_$ProductListResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
  }) {
    return _then(_$ProductListResponseDtoImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ProductDto>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductListResponseDtoImpl implements _ProductListResponseDto {
  const _$ProductListResponseDtoImpl(
      {required final List<ProductDto> results,
      this.count = 0,
      this.next,
      this.previous})
      : _results = results;

  factory _$ProductListResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductListResponseDtoImplFromJson(json);

  final List<ProductDto> _results;
  @override
  List<ProductDto> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey()
  final int count;
  @override
  final String? next;
  @override
  final String? previous;

  @override
  String toString() {
    return 'ProductListResponseDto(results: $results, count: $count, next: $next, previous: $previous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_results), count, next, previous);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListResponseDtoImplCopyWith<_$ProductListResponseDtoImpl>
      get copyWith => __$$ProductListResponseDtoImplCopyWithImpl<
          _$ProductListResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductListResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _ProductListResponseDto implements ProductListResponseDto {
  const factory _ProductListResponseDto(
      {required final List<ProductDto> results,
      final int count,
      final String? next,
      final String? previous}) = _$ProductListResponseDtoImpl;

  factory _ProductListResponseDto.fromJson(Map<String, dynamic> json) =
      _$ProductListResponseDtoImpl.fromJson;

  @override
  List<ProductDto> get results;
  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  @JsonKey(ignore: true)
  _$$ProductListResponseDtoImplCopyWith<_$ProductListResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProductFilterParams _$ProductFilterParamsFromJson(Map<String, dynamic> json) {
  return _ProductFilterParams.fromJson(json);
}

/// @nodoc
mixin _$ProductFilterParams {
  String? get search => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  @JsonKey(name: 'car_type')
  String? get carType => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_price')
  String? get minPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_price')
  String? get maxPrice => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductFilterParamsCopyWith<ProductFilterParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductFilterParamsCopyWith<$Res> {
  factory $ProductFilterParamsCopyWith(
          ProductFilterParams value, $Res Function(ProductFilterParams) then) =
      _$ProductFilterParamsCopyWithImpl<$Res, ProductFilterParams>;
  @useResult
  $Res call(
      {String? search,
      String? brand,
      @JsonKey(name: 'car_type') String? carType,
      @JsonKey(name: 'min_price') String? minPrice,
      @JsonKey(name: 'max_price') String? maxPrice,
      int page});
}

/// @nodoc
class _$ProductFilterParamsCopyWithImpl<$Res, $Val extends ProductFilterParams>
    implements $ProductFilterParamsCopyWith<$Res> {
  _$ProductFilterParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? brand = freezed,
    Object? carType = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductFilterParamsImplCopyWith<$Res>
    implements $ProductFilterParamsCopyWith<$Res> {
  factory _$$ProductFilterParamsImplCopyWith(_$ProductFilterParamsImpl value,
          $Res Function(_$ProductFilterParamsImpl) then) =
      __$$ProductFilterParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? search,
      String? brand,
      @JsonKey(name: 'car_type') String? carType,
      @JsonKey(name: 'min_price') String? minPrice,
      @JsonKey(name: 'max_price') String? maxPrice,
      int page});
}

/// @nodoc
class __$$ProductFilterParamsImplCopyWithImpl<$Res>
    extends _$ProductFilterParamsCopyWithImpl<$Res, _$ProductFilterParamsImpl>
    implements _$$ProductFilterParamsImplCopyWith<$Res> {
  __$$ProductFilterParamsImplCopyWithImpl(_$ProductFilterParamsImpl _value,
      $Res Function(_$ProductFilterParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? brand = freezed,
    Object? carType = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? page = null,
  }) {
    return _then(_$ProductFilterParamsImpl(
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      carType: freezed == carType
          ? _value.carType
          : carType // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPrice: freezed == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductFilterParamsImpl implements _ProductFilterParams {
  const _$ProductFilterParamsImpl(
      {this.search,
      this.brand,
      @JsonKey(name: 'car_type') this.carType,
      @JsonKey(name: 'min_price') this.minPrice,
      @JsonKey(name: 'max_price') this.maxPrice,
      this.page = 1});

  factory _$ProductFilterParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductFilterParamsImplFromJson(json);

  @override
  final String? search;
  @override
  final String? brand;
  @override
  @JsonKey(name: 'car_type')
  final String? carType;
  @override
  @JsonKey(name: 'min_price')
  final String? minPrice;
  @override
  @JsonKey(name: 'max_price')
  final String? maxPrice;
  @override
  @JsonKey()
  final int page;

  @override
  String toString() {
    return 'ProductFilterParams(search: $search, brand: $brand, carType: $carType, minPrice: $minPrice, maxPrice: $maxPrice, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductFilterParamsImpl &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.carType, carType) || other.carType == carType) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, search, brand, carType, minPrice, maxPrice, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductFilterParamsImplCopyWith<_$ProductFilterParamsImpl> get copyWith =>
      __$$ProductFilterParamsImplCopyWithImpl<_$ProductFilterParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductFilterParamsImplToJson(
      this,
    );
  }
}

abstract class _ProductFilterParams implements ProductFilterParams {
  const factory _ProductFilterParams(
      {final String? search,
      final String? brand,
      @JsonKey(name: 'car_type') final String? carType,
      @JsonKey(name: 'min_price') final String? minPrice,
      @JsonKey(name: 'max_price') final String? maxPrice,
      final int page}) = _$ProductFilterParamsImpl;

  factory _ProductFilterParams.fromJson(Map<String, dynamic> json) =
      _$ProductFilterParamsImpl.fromJson;

  @override
  String? get search;
  @override
  String? get brand;
  @override
  @JsonKey(name: 'car_type')
  String? get carType;
  @override
  @JsonKey(name: 'min_price')
  String? get minPrice;
  @override
  @JsonKey(name: 'max_price')
  String? get maxPrice;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$ProductFilterParamsImplCopyWith<_$ProductFilterParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
