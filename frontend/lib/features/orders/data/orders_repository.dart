import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'orders_dto.dart';

part 'orders_repository.g.dart';

@riverpod
OrdersRepository ordersRepository(OrdersRepositoryRef ref) =>
    OrdersRepository(ref.watch(dioProvider));

class OrdersRepository {
  OrdersRepository(this._dio);
  final Dio _dio;

  Future<List<OrderListItemDto>> getOrders() async {
    try {
      final r = await _dio.get<List<dynamic>>('/orders');
      return r.data!
          .map((e) => OrderListItemDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<OrderDto> getOrder(int id) async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/orders/$id');
      return OrderDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
