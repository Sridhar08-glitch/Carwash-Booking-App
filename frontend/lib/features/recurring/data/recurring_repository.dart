import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'recurring_dto.dart';

part 'recurring_repository.g.dart';

@riverpod
RecurringRepository recurringRepository(RecurringRepositoryRef ref) =>
    RecurringRepository(ref.watch(dioProvider));

class RecurringRepository {
  RecurringRepository(this._dio);
  final Dio _dio;

  Future<List<RecurringRuleDto>> getRules() async {
    try {
      final r = await _dio.get<List<dynamic>>('/recurring/');
      return r.data!
          .map((e) => RecurringRuleDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<RecurringRuleDto> createRule(CreateRecurringDto dto) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/recurring/',
        data: dto.toJson(),
      );
      return RecurringRuleDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<RecurringRuleDto> updateRule(int id, CreateRecurringDto dto) async {
    try {
      final r = await _dio.patch<Map<String, dynamic>>(
        '/recurring/$id',
        data: dto.toJson(),
      );
      return RecurringRuleDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> deleteRule(int id) async {
    try {
      await _dio.delete<void>('/recurring/$id');
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
