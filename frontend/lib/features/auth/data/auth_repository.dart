import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/session_controller.dart';
import '../../../core/auth/session_state.dart';
import '../../../core/error/error_mapper.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/dio_client.dart';
import 'auth_dto.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(ref.watch(dioProvider), ref);

class AuthRepository {
  AuthRepository(this._dio, this._ref);

  final Dio _dio;
  final Ref _ref;

  // ---------------------------------------------------------------------------
  // POST /auth/otp/request
  // ---------------------------------------------------------------------------
  Future<void> requestOtp(String phone) async {
    try {
      await _dio.post<dynamic>(
        '/auth/otp/request',
        data: OtpRequestDto(phone: phone).toJson(),
        options: Options(extra: {'skipAuth': true}),
      );
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // POST /auth/otp/verify
  // Returns OtpVerifyResponseDto; also calls SessionController.login()
  // ---------------------------------------------------------------------------
  Future<({bool isNew})> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/otp/verify',
        data: OtpVerifyDto(phone: phone, code: code).toJson(),
        options: Options(extra: {'skipAuth': true}),
      );

      final dto = OtpVerifyResponseDto.fromJson(response.data!);

      final user = AuthUser(
        id: dto.user.id,
        phone: dto.user.phone,
        email: dto.user.email,
        role: UserRole.fromString(dto.user.role),
        isPhoneVerified: dto.user.isPhoneVerified,
      );

      await _ref.read(sessionControllerProvider.notifier).login(
            user: user,
            access: dto.tokens.access,
            refresh: dto.tokens.refresh,
          );

      return (isNew: dto.isNew);
    } catch (e) {
      throw ErrorMapper.map(e);
    }
  }

  // ---------------------------------------------------------------------------
  // POST /auth/logout
  // ---------------------------------------------------------------------------
  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<dynamic>(
        '/auth/logout',
        data: RefreshDto(refresh: refreshToken).toJson(),
      );
    } catch (_) {
      // Best-effort — local session is cleared regardless
    } finally {
      await _ref.read(sessionControllerProvider.notifier).logout();
    }
  }
}
