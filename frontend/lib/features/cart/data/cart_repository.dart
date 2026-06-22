import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'cart_dto.dart';

part 'cart_repository.g.dart';

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) =>
    CartRepository(ref.watch(dioProvider));

class CartRepository {
  CartRepository(this._dio);
  final Dio _dio;

  Future<CartDto> getCart() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/cart');
      return CartDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<CartDto> addItem(int productId, int quantity) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/cart/items',
        data: {'product_id': productId, 'quantity': quantity},
      );
      return CartDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<CartDto> updateItem(int itemId, int quantity) async {
    try {
      final r = await _dio.patch<Map<String, dynamic>>(
        '/cart/items/$itemId',
        data: {'quantity': quantity},
      );
      return CartDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<CartDto> removeItem(int itemId) async {
    try {
      final r = await _dio.delete<Map<String, dynamic>>('/cart/items/$itemId');
      return CartDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<CartDto> applyPromo(String code) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/cart/apply-promo',
        data: {'code': code},
      );
      return CartDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
