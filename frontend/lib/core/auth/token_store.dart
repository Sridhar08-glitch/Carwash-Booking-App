import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Wraps [FlutterSecureStorage] for JWT token persistence.
/// Tokens are stored in iOS Keychain / Android EncryptedSharedPreferences.
/// Nothing else goes in here — no plain prefs.
class TokenStore {
  TokenStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _kAccess = 'jwt_access';
  static const _kRefresh = 'jwt_refresh';
  static const _kUserId = 'user_id';
  static const _kRole = 'user_role';
  static const _kPhone = 'user_phone';

  // ---------------------------------------------------------------------------
  // Read
  // ---------------------------------------------------------------------------

  Future<String?> readAccess() => _storage.read(key: _kAccess);
  Future<String?> readRefresh() => _storage.read(key: _kRefresh);
  Future<String?> readUserId() => _storage.read(key: _kUserId);
  Future<String?> readRole() => _storage.read(key: _kRole);
  Future<String?> readPhone() => _storage.read(key: _kPhone);

  Future<bool> hasSession() async {
    final token = await readAccess();
    return token != null && token.isNotEmpty;
  }

  // ---------------------------------------------------------------------------
  // Write
  // ---------------------------------------------------------------------------

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  Future<void> saveUser({
    required int id,
    required String role,
    required String phone,
  }) async {
    await _storage.write(key: _kUserId, value: id.toString());
    await _storage.write(key: _kRole, value: role);
    await _storage.write(key: _kPhone, value: phone);
  }

  Future<void> updateAccess(String access) =>
      _storage.write(key: _kAccess, value: access);

  // ---------------------------------------------------------------------------
  // Clear (logout)
  // ---------------------------------------------------------------------------

  Future<void> clear() => _storage.deleteAll();
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final tokenStoreProvider = Provider<TokenStore>(
  (ref) => TokenStore(const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  )),
);
