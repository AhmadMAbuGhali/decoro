// lib/features/auth/data/datasources/auth_local_data_source.dart

import '../../../../core/services/storage/local_storage_service.dart';
import '../../../../core/services/storage/secure_storage_service.dart';

class AuthLocalDataSource {
  final LocalStorageService local;
  final SecureStorageService secure;

  AuthLocalDataSource({
    required this.local,
    required this.secure,
  });

  // --------------------------
  // Storage Keys
  // --------------------------
  static const String _kAccess = 'access_token';
  static const String _kRefresh = 'refresh_token';
  static const String _kUser = 'user_raw';

  // --------------------------
  // SAVE SESSION (Access + Refresh + User)
  // --------------------------
  Future<void> saveUserSession({
    required String accessToken,
    required String refreshToken,
    required String userJson,
  }) async {
    await secure.write(_kAccess, accessToken);
    await secure.write(_kRefresh, refreshToken);
    await local.setString(_kUser, userJson);
  }

  // --------------------------
  // READ SESSION DATA
  // --------------------------
  Future<String?> getAccessToken() async => secure.read(_kAccess);
  Future<String?> getRefreshToken() async => secure.read(_kRefresh);

  Future<String?> getUserRaw() async {
    final json = await local.getString(_kUser);
    if (json == null || json.trim().isEmpty) return null;
    return json;
  }

  Future<bool> hasRefreshToken() async {
    final t = await secure.read(_kRefresh);
    return t != null && t.isNotEmpty;
  }

  Future<bool> isLoggedIn() async {
    final access = await getAccessToken();
    return access != null && access.isNotEmpty;
  }

  // --------------------------
  // CLEAR SESSION
  // --------------------------
  Future<void> clearSession() async {
    await secure.delete(_kAccess);
    await secure.delete(_kRefresh);
    await local.remove(_kUser);
  }
}