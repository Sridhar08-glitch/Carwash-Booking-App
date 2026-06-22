import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'session_state.dart';
import 'token_store.dart';

part 'session_controller.g.dart';

/// Global session state — drives auth guards in the router.
/// Login, logout, and token refresh all go through here.
/// keepAlive: true — must never be auto-disposed between login and API calls.
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  SessionState build() {
    // Kick off async restore from secure storage
    _restoreSession();
    return const SessionState.loading();
  }

  TokenStore get _store => ref.read(tokenStoreProvider);

  // ---------------------------------------------------------------------------
  // Restore from secure storage on cold start
  // ---------------------------------------------------------------------------

  Future<void> _restoreSession() async {
    try {
      final access = await _store.readAccess();
      final refresh = await _store.readRefresh();
      final idStr = await _store.readUserId();
      final roleStr = await _store.readRole();
      final phone = await _store.readPhone();

      if (access == null || refresh == null || idStr == null) {
        if (!isAuthenticated) state = const SessionState.unauthenticated();
        return;
      }

      // login() may have already set authenticated state — don't overwrite it
      if (isAuthenticated) return;

      final user = AuthUser(
        id: int.parse(idStr),
        phone: phone ?? '',
        role: UserRole.fromString(roleStr ?? 'customer'),
        isPhoneVerified: true,
      );

      state = SessionState.authenticated(
        user: user,
        accessToken: access,
        refreshToken: refresh,
      );
    } catch (_) {
      if (!isAuthenticated) state = const SessionState.unauthenticated();
    }
  }

  // ---------------------------------------------------------------------------
  // Login — called by AuthRepository after successful OTP verify
  // ---------------------------------------------------------------------------

  Future<void> login({
    required AuthUser user,
    required String access,
    required String refresh,
  }) async {
    await _store.saveTokens(access: access, refresh: refresh);
    await _store.saveUser(
      id: user.id,
      role: user.role.name,
      phone: user.phone,
    );
    state = SessionState.authenticated(
      user: user,
      accessToken: access,
      refreshToken: refresh,
    );
  }

  // ---------------------------------------------------------------------------
  // Update access token after refresh (called by auth interceptor)
  // ---------------------------------------------------------------------------

  Future<void> updateAccessToken(String newAccess, String newRefresh) async {
    await _store.saveTokens(access: newAccess, refresh: newRefresh);

    // If we're already authenticated, just swap the tokens.
    if (state.maybeWhen(authenticated: (_, __, ___) => true, orElse: () => false)) {
      state = state.maybeWhen(
        authenticated: (user, _, __) => SessionState.authenticated(
          user: user,
          accessToken: newAccess,
          refreshToken: newRefresh,
        ),
        orElse: () => state,
      );
      return;
    }

    // State is not authenticated yet (race during cold-start refresh).
    // Reconstruct from storage so the in-memory token is not lost.
    try {
      final idStr = await _store.readUserId();
      final roleStr = await _store.readRole();
      final phone = await _store.readPhone();
      if (idStr != null) {
        final user = AuthUser(
          id: int.parse(idStr),
          phone: phone ?? '',
          role: UserRole.fromString(roleStr ?? 'customer'),
          isPhoneVerified: true,
        );
        state = SessionState.authenticated(
          user: user,
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
      }
    } catch (_) {
      // Nothing we can do — the interceptor still has the token string
      // directly from _refresh() and will use it for the retry header.
    }
  }

  // ---------------------------------------------------------------------------
  // Logout — wipes tokens + cache and routes to onboarding
  // ---------------------------------------------------------------------------

  Future<void> logout() async {
    await _store.clear();
    state = const SessionState.unauthenticated();
  }

  // ---------------------------------------------------------------------------
  // Convenience getters
  // ---------------------------------------------------------------------------

  String? get accessToken => state.maybeWhen(
        authenticated: (_, access, __) => access,
        orElse: () => null,
      );

  String? get refreshToken => state.maybeWhen(
        authenticated: (_, __, refresh) => refresh,
        orElse: () => null,
      );

  AuthUser? get currentUser => state.maybeWhen(
        authenticated: (user, _, __) => user,
        orElse: () => null,
      );

  bool get isAuthenticated => state.maybeWhen(
        authenticated: (_, __, ___) => true,
        orElse: () => false,
      );
}
