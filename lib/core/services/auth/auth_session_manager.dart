// lib/core/services/auth/auth_session_manager.dart

import 'dart:async';

import '../storage/secure_storage_service.dart';
import '../storage/local_storage_service.dart';

/// Simple session manager responsible for storing/retrieving tokens and user raw json.
/// Uses SecureStorageService for tokens and LocalStorageService for user json.
class AuthSessionManager {
  static const _kAccessTokenKey = 'access_token';
  static const _kRefreshTokenKey = 'refresh_token';
  static const _kUserKey = 'user_raw';

  final SecureStorageService secure;
  final LocalStorageService local;

  // optional stream to notify listeners about auth changes
  final StreamController<bool> _authChangeController = StreamController.broadcast();

  AuthSessionManager({required this.secure, required this.local});

  Stream<bool> get authChanges => _authChangeController.stream;

  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userRaw,
  }) async {
    await secure.write(_kAccessTokenKey, accessToken);
    await secure.write(_kRefreshTokenKey, refreshToken);
    await local.setString(_kUserKey, userRaw);
    _authChangeController.add(true);
  }

  Future<void> clearSession() async {
    await secure.delete(_kAccessTokenKey);
    await secure.delete(_kRefreshTokenKey);
    await local.setString(_kUserKey, '');
    _authChangeController.add(false);
  }

  Future<String?> getAccessToken() async => await secure.read(_kAccessTokenKey);
  Future<String?> getRefreshToken() async => await secure.read(_kRefreshTokenKey);

  Future<String?> getUserRaw() async => await local.getString(_kUserKey);

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  void dispose() {
    _authChangeController.close();
  }
}