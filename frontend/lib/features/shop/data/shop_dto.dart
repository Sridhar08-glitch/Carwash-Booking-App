import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_dto.freezed.dart';
part 'shop_dto.g.dart';

@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    required String name,
    required String description,
    @JsonKey(name: 'short_description') required String shortDescription,
    required String price,
    @JsonKey(name: 'compare_at_price') String? compareAtPrice,
    @Default('SAR') String currency,
    required String brand,
    @JsonKey(name: 'car_type') String? carType,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default([]) List<String> images,
    @Default(true) bool inStock,
    @JsonKey(name: 'stock_quantity') @Default(0) int stockQuantity,
    @Default([]) List<String> tags,
    @Default(0.0) double rating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

@freezed
class ProductListResponseDto with _$ProductListResponseDto {
  const factory ProductListResponseDto({
    required List<ProductDto> results,
    @Default(0) int count,
    String? next,
    String? previous,
  }) = _ProductListResponseDto;

  factory ProductListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseDtoFromJson(json);
}

@freezed
class ProductFilterParams with _$ProductFilterParams {
  const factory ProductFilterParams({
    String? search,
    String? brand,
    @JsonKey(name: 'car_type') String? carType,
    @JsonKey(name: 'min_price') String? minPrice,
    @JsonKey(name: 'max_price') String? maxPrice,
    @Default(1) int page,
  }) = _ProductFilterParams;

  factory ProductFilterParams.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterParamsFromJson(json);
}
