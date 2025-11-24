// lib/core/services/session/session_manager.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../storage/secure_storage_service.dart';
import '../storage/local_storage_service.dart';

/// Production-friendly Session manager:
/// - saves access & refresh tokens
/// - exposes a stream for auth state changes
/// - helper methods isLoggedIn/getTokens/clear
class SessionManager {
  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';
  static const _kUserRaw = 'user_raw';

  final SecureStorageService secure;
  final LocalStorageService local;

  final StreamController<bool> _authController = StreamController<bool>.broadcast();

  SessionManager({
    required this.secure,
    required this.local,
  });

  // Stream to listen to auth state changes (true = logged in)
  Stream<bool> get authStateChanges => _authController.stream;

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await secure.write(_kAccessToken, accessToken);
    await secure.write(_kRefreshToken, refreshToken);
    _authController.add(true);
    if (kDebugMode) debugPrint('[SessionManager] tokens saved');
  }

  Future<Map<String, String?>> getTokens() async {
    final access = await secure.read(_kAccessToken);
    final refresh = await secure.read(_kRefreshToken);
    return {'access': access, 'refresh': refresh};
  }

  Future<String?> getAccessToken() async => await secure.read(_kAccessToken);
  Future<String?> getRefreshToken() async => await secure.read(_kRefreshToken);

  Future<void> saveUserRaw(String userJson) async {
    await local.setString(_kUserRaw, userJson);
  }

  Future<String?> getUserRaw() async => await local.getString(_kUserRaw);

  Future<void> clear() async {
    await secure.delete(_kAccessToken);
    await secure.delete(_kRefreshToken);
    await local.setString(_kUserRaw, '');
    _authController.add(false);
    if (kDebugMode) debugPrint('[SessionManager] cleared');
  }

  Future<bool> isLoggedIn() async {
    final access = await getAccessToken();
    return access != null && access.isNotEmpty;
  }

  /// Close the controller (call on app dispose if needed)
  void dispose() {
    _authController.close();
  }
}