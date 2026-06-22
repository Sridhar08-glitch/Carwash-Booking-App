import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import 'memberships_dto.dart';

part 'memberships_repository.g.dart';

@riverpod
MembershipsRepository membershipsRepository(MembershipsRepositoryRef ref) =>
    MembershipsRepository(ref.watch(dioProvider));

@riverpod
Future<List<MembershipPlanDto>> membershipPlans(MembershipPlansRef ref) =>
    ref.watch(membershipsRepositoryProvider).getPlans();

@riverpod
Future<MyMembershipDto?> myMembership(MyMembershipRef ref) =>
    ref.watch(membershipsRepositoryProvider).getMyMembership();

class MembershipsRepository {
  MembershipsRepository(this._dio);
  final Dio _dio;

  Future<List<MembershipPlanDto>> getPlans() async {
    try {
      final r = await _dio.get<List<dynamic>>('/memberships/plans');
      return r.data!
          .map((e) => MembershipPlanDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<MyMembershipDto?> getMyMembership() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/memberships/my');
      return MyMembershipDto.fromJson(r.data!);
    } catch (e) {
      // 404 means no active membership
      return null;
    }
  }

  Future<void> subscribe(int planId) async {
    try {
      await _dio.post<void>(
          '/memberships/subscribe', data: {'plan_id': planId});
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  Future<void> cancel() async {
    try {
      await _dio.post<void>('/memberships/cancel');
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }
}
