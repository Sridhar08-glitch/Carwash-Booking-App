import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'shop_dto.dart';

part 'shop_repository.g.dart';

@riverpod
ShopRepository shopRepository(ShopRepositoryRef ref) =>
    ShopRepository(ref.watch(dioProvider));

class ShopRepository {
  ShopRepository(this._dio);
  final Dio _dio;

  Future<ProductListResponseDto> getProducts({
    String? search,
    String? brand,
    String? carType,
    String? minPrice,
    String? maxPrice,
    int page = 1,
  }) async {
    try {
      // Backend returns a plain JSON array; tolerate a paginated map too.
      final r = await _dio.get<dynamic>(
        '/products',
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (brand != null && brand.isNotEmpty) 'brand': brand,
          if (carType != null && carType.isNotEmpty) 'car_type': carType,
          if (minPrice != null) 'min_price': minPrice,
          if (maxPrice != null) 'max_price': maxPrice,
        },
      );
      final data = r.data;
      if (data is List) {
        return ProductListResponseDto(
          results: data
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      return ProductListResponseDto.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<ProductDto> getProduct(int id) async {
    try {
      final r =
          await _dio.get<Map<String, dynamic>>('/products/$id');
      return ProductDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
