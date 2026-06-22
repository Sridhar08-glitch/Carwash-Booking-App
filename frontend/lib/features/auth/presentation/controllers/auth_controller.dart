import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../data/auth_repository.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

@freezed
class AuthFormState with _$AuthFormState {
  const factory AuthFormState({
    @Default(false) bool isLoading,
    @Default('') String phone,
    @Default('') String code,
    @Default(0) int otpAttemptsLeft,
    @Default(0) int resendSecondsLeft,
    Failure? failure,
    String? fieldError,
  }) = _AuthFormState;
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

@riverpod
class AuthController extends _$AuthController {
  static const _maxAttempts = 5;
  static const _resendCooldown = 60; // seconds

  bool _disposed = false;

  @override
  AuthFormState build() {
    ref.onDispose(() => _disposed = true);
    return const AuthFormState(otpAttemptsLeft: _maxAttempts);
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  // ---------------------------------------------------------------------------
  // Step 1 — request OTP
  // ---------------------------------------------------------------------------

  Future<bool> requestOtp(String phone) async {
    state = state.copyWith(isLoading: true, failure: null, fieldError: null);
    try {
      await _repo.requestOtp(phone);
      state = state.copyWith(
        isLoading: false,
        phone: phone,
        resendSecondsLeft: _resendCooldown,
        otpAttemptsLeft: _maxAttempts,
      );
      _startResendTimer();
      return true;
    } on Failure catch (f) {
      state = state.copyWith(
        isLoading: false,
        failure: f,
        fieldError: f.maybeWhen(
          validation: (_, fe) => fe['phone']?.firstOrNull,
          orElse: () => null,
        ),
      );
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Step 2 — verify OTP
  // Returns true + isNew flag when successful
  // ---------------------------------------------------------------------------

  Future<({bool success, bool isNew})> verifyOtp(String code) async {
    state = state.copyWith(isLoading: true, failure: null, fieldError: null);
    try {
      final result = await _repo.verifyOtp(phone: state.phone, code: code);
      state = state.copyWith(isLoading: false, code: code);
      return (success: true, isNew: result.isNew);
    } on Failure catch (f) {
      final attemptsLeft = state.otpAttemptsLeft - 1;
      state = state.copyWith(
        isLoading: false,
        failure: f,
        otpAttemptsLeft: attemptsLeft < 0 ? 0 : attemptsLeft,
        fieldError: f.maybeWhen(
          validation: (_, fe) => fe['code']?.firstOrNull ?? fe['non_field_errors']?.firstOrNull,
          orElse: () => null,
        ),
      );
      return (success: false, isNew: false);
    }
  }

  // ---------------------------------------------------------------------------
  // Resend — only available when resendSecondsLeft == 0
  // ---------------------------------------------------------------------------

  Future<bool> resendOtp() async {
    if (state.resendSecondsLeft > 0) return false;
    return requestOtp(state.phone);
  }

  void clearFailure() => state = state.copyWith(failure: null, fieldError: null);

  // ---------------------------------------------------------------------------
  // Countdown timer for resend cooldown
  // ---------------------------------------------------------------------------

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_disposed) return false;
      final secs = state.resendSecondsLeft - 1;
      state = state.copyWith(resendSecondsLeft: secs < 0 ? 0 : secs);
      return secs > 0;
    });
  }
}
