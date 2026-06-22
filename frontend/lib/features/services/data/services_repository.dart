import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/hive_setup.dart';
import 'services_dto.dart';

part 'services_repository.g.dart';

@riverpod
ServicesRepository servicesRepository(ServicesRepositoryRef ref) =>
    ServicesRepository(ref.watch(dioProvider));

class ServicesRepository {
  ServicesRepository(this._dio);

  final Dio _dio;

  static const _cacheKey = 'services_list';
  static const _categoriesCacheKey = 'categories_list';

  // ---------------------------------------------------------------------------
  // GET /services
  // ---------------------------------------------------------------------------
  Future<List<ServiceDto>> getServices({int? categoryId}) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/services',
        queryParameters: categoryId != null
            ? {'category': categoryId}
            : null,
      );
      final dtos = response.data!
          .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
          .toList();

      // Cache for offline use (only cache unfiltered list)
      if (categoryId == null) {
        await HiveSetup.servicesCache.put(
          _cacheKey,
          jsonEncode(response.data),
        );
      }

      return dtos;
    } catch (e) {
      // Try cache on network error
      if (categoryId == null) {
        final cached = HiveSetup.servicesCache.get(_cacheKey);
        if (cached != null) {
          final list = jsonDecode(cached) as List<dynamic>;
          return list
              .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // GET /services/{id}
  // ---------------------------------------------------------------------------
  Future<ServiceDto> getService(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/services/$id');
      return ServiceDto.fromJson(response.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // GET /services/categories
  // ---------------------------------------------------------------------------
  Future<List<ServiceCategoryDto>> getCategories() async {
    try {
      final response = await _dio.get<List<dynamic>>('/services/categories');
      final dtos = response.data!
          .map((e) => ServiceCategoryDto.fromJson(e as Map<String, dynamic>))
          .toList();
      await HiveSetup.servicesCache.put(
        _categoriesCacheKey,
        jsonEncode(response.data),
      );
      return dtos;
    } catch (e) {
      final cached = HiveSetup.servicesCache.get(_categoriesCacheKey);
      if (cached != null) {
        final list = jsonDecode(cached) as List<dynamic>;
        return list
            .map((e) => ServiceCategoryDto.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // GET /branches
  // ---------------------------------------------------------------------------
  Future<List<BranchDto>> getBranches() async {
    try {
      final response = await _dio.get<List<dynamic>>('/branches');
      final dtos = response.data!
          .map((e) => BranchDto.fromJson(e as Map<String, dynamic>))
          .toList();
      await HiveSetup.branchesCache.put(
        'branches_list',
        jsonEncode(response.data),
      );
      return dtos;
    } catch (e) {
      final cached = HiveSetup.branchesCache.get('branches_list');
      if (cached != null) {
        final list = jsonDecode(cached) as List<dynamic>;
        return list
            .map((e) => BranchDto.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ErrorMapper.map(e);
    }
  }

  Future<BranchDto> getBranch(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/branches/$id');
      return BranchDto.fromJson(response.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
