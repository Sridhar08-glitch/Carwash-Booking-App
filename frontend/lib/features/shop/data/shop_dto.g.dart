// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductDtoImpl _$$ProductDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProductDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['short_description'] as String,
      price: json['price'] as String,
      compareAtPrice: json['compare_at_price'] as String?,
      currency: json['currency'] as String? ?? 'SAR',
      brand: json['brand'] as String,
      carType: json['car_type'] as String?,
      imageUrl: json['image_url'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      inStock: json['inStock'] as bool? ?? true,
      stockQuantity: (json['stock_quantity'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductDtoImplToJson(_$ProductDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'price': instance.price,
      'compare_at_price': instance.compareAtPrice,
      'currency': instance.currency,
      'brand': instance.brand,
      'car_type': instance.carType,
      'image_url': instance.imageUrl,
      'images': instance.images,
      'inStock': instance.inStock,
      'stock_quantity': instance.stockQuantity,
      'tags': instance.tags,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
    };

_$ProductListResponseDtoImpl _$$ProductListResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductListResponseDtoImpl(
      results: (json['results'] as List<dynamic>)
          .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$$ProductListResponseDtoImplToJson(
        _$ProductListResponseDtoImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
    };

_$ProductFilterParamsImpl _$$ProductFilterParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductFilterParamsImpl(
      search: json['search'] as String?,
      brand: json['brand'] as String?,
      carType: json['car_type'] as String?,
      minPrice: json['min_price'] as String?,
      maxPrice: json['max_price'] as String?,
      page: (json['page'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$ProductFilterParamsImplToJson(
        _$ProductFilterParamsImpl instance) =>
    <String, dynamic>{
      'search': instance.search,
      'brand': instance.brand,
      'car_type': instance.carType,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'page': instance.page,
    };
