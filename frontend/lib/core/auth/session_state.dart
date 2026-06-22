import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_state.freezed.dart';
part 'session_state.g.dart';

// ---------------------------------------------------------------------------
// User role — matches backend role field
// ---------------------------------------------------------------------------
enum UserRole {
  customer,
  staff,
  admin;

  static UserRole fromString(String s) => switch (s) {
        'staff' => UserRole.staff,
        'admin' => UserRole.admin,
        _ => UserRole.customer,
      };
}

// ---------------------------------------------------------------------------
// Minimal user model (from the /auth/otp/verify response)
// ---------------------------------------------------------------------------
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String phone,
    String? email,
    required UserRole role,
    @Default(false) bool isPhoneVerified,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
}

// ---------------------------------------------------------------------------
// Session state — loading / unauthenticated / authenticated
// ---------------------------------------------------------------------------
@freezed
class SessionState with _$SessionState {
  const factory SessionState.loading() = _Loading;
  const factory SessionState.unauthenticated() = _Unauthenticated;
  const factory SessionState.authenticated({
    required AuthUser user,
    required String accessToken,
    required String refreshToken,
  }) = _Authenticated;
}
