import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/hive_setup.dart';
import '../../../features/services/data/services_dto.dart';
import '../../../features/services/data/services_repository.dart';
import 'home_dto.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) =>
    HomeRepository(ref.watch(dioProvider), ref.watch(servicesRepositoryProvider));

class HomeRepository {
  HomeRepository(this._dio, this._servicesRepo);

  final Dio _dio;
  final ServicesRepository _servicesRepo;

  static const _layoutCacheKey = 'home_layout';

  // ---------------------------------------------------------------------------
  // GET /home/layout — customer-facing home layout
  // ---------------------------------------------------------------------------
  Future<List<HomeSectionDto>> getHomeLayout() async {
    try {
      final response = await _dio.get<List<dynamic>>('/home/layout');
      final sections = response.data!
          .map((e) => HomeSectionDto.fromJson(e as Map<String, dynamic>))
          .toList();

      await HiveSetup.homeLayoutCache.put(
        _layoutCacheKey,
        jsonEncode(response.data),
      );

      return _filterExpired(sections);
    } catch (e) {
      // Return cached layout on error
      final cached = HiveSetup.homeLayoutCache.get(_layoutCacheKey);
      if (cached != null) {
        final list = jsonDecode(cached) as List<dynamic>;
        return _filterExpired(
          list
              .map((e) => HomeSectionDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Fetch the data for a section's `source` field
  // ---------------------------------------------------------------------------
  Future<List<ServiceDto>> getServiceRailData() =>
      _servicesRepo.getServices();

  // ---------------------------------------------------------------------------
  // Client-side validity guard — hide expired banners even if server returns them
  // ---------------------------------------------------------------------------
  List<HomeSectionDto> _filterExpired(List<HomeSectionDto> sections) {
    final now = DateTime.now();
    return sections.map((s) {
      if (s.validUntil == null) return s;
      final until = DateTime.tryParse(s.validUntil!);
      if (until != null && until.isBefore(now)) {
        // Return null to filter out — map then whereType
        return null;
      }
      // Filter individual banners in carousel
      if (s.banners.isNotEmpty) {
        final validBanners = s.banners.where((b) {
          if (b.validUntil == null) return true;
          final u = DateTime.tryParse(b.validUntil!);
          return u == null || u.isAfter(now);
        }).toList();
        return s.copyWith(banners: validBanners);
      }
      return s;
    }).whereType<HomeSectionDto>().toList();
  }
}
