import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'loyalty_dto.dart';

part 'loyalty_repository.g.dart';

@riverpod
LoyaltyRepository loyaltyRepository(LoyaltyRepositoryRef ref) =>
    LoyaltyRepository(ref.watch(dioProvider));

@riverpod
Future<LoyaltyStatusDto> loyaltyStatus(LoyaltyStatusRef ref) =>
    ref.watch(loyaltyRepositoryProvider).getStatus();

@riverpod
Future<ReferralDto> referrals(ReferralsRef ref) =>
    ref.watch(loyaltyRepositoryProvider).getReferrals();

class LoyaltyRepository {
  LoyaltyRepository(this._dio);
  final Dio _dio;

  Future<LoyaltyStatusDto> getStatus() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/loyalty/status');
      return LoyaltyStatusDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<List<LoyaltyTierDto>> getTiers() async {
    try {
      final r = await _dio.get<List<dynamic>>('/loyalty/tiers');
      return r.data!
          .map((e) => LoyaltyTierDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<ReferralDto> getReferrals() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/loyalty/referrals');
      return ReferralDto.fromJson(r.data!);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> sendReferral(String phone) async {
    try {
      await _dio
          .post<void>('/loyalty/referrals', data: {'referee_phone': phone});
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
