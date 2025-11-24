// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:decoro/config/constants/api_endpoints.dart';
import 'package:decoro/core/services/session/session_manager.dart';
import 'package:decoro/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:decoro/features/auth/domain/entities/user_entity.dart';
import 'package:decoro/features/auth/domain/repositories/auth_repository.dart';
import '../../presentation/blocs/verification/verification_event.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SessionManager session;

  AuthRepositoryImpl({
    required this.remote,
    required this.session,
  });

  // -----------------------
  // Helpers
  // -----------------------
  Future<void> _saveSessionFromMap(Map<String, dynamic> data) async {
    final access = data['accessToken'] ?? data['token'];
    final refresh = data['refreshToken'] ?? data['refresh'];

    if (access == null || refresh == null) {
      throw Exception("Invalid token response from server");
    }

    await session.saveTokens(
      accessToken: access.toString(),
      refreshToken: refresh.toString(),
    );

    final userJson = data['user'] ?? data['data'] ?? data;
    await session.saveUserRaw(jsonEncode(userJson));
  }

  String _extractMsg(DioException e) {
    final resp = e.response;
    if (resp != null && resp.data != null) {
      if (resp.data is Map && resp.data['message'] != null) {
        return resp.data['message'];
      }
      if (resp.data is String) return resp.data;
      return jsonEncode(resp.data);
    }
    return e.message ?? 'Network error';
  }

  // -----------------------
  // LOGIN
  // -----------------------
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      print("🔵 Calling remote.login…");
      final res = await remote.login(email, password);
      print("🟢 Response from server: $res");

      await _saveSessionFromMap(res);

      final userMap = res['user'] is String
          ? jsonDecode(res['user'])
          : Map<String, dynamic>.from(res['user']);

      return UserEntity.fromJson(userMap);

    } on DioException catch (e) {
      print("❌ DioException: ${_extractMsg(e)}");
      throw Exception(_extractMsg(e));

    } catch (e, s) {
      print("❌ GENERAL ERROR: $e");
      print("📌 STACK: $s");
      throw Exception("Login failed: $e");
    }
  }

  // -----------------------
  // REGISTER
  // -----------------------
  @override
  Future<UserEntity> register(String name, String email, String password) async {
    try {
      final res = await remote.register(name, email, password);
      await _saveSessionFromMap(res);

      return UserEntity.fromJson(
        res['user'] is String
            ? jsonDecode(res['user'])
            : Map<String, dynamic>.from(res['user']),
      );
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  // -----------------------
  // ME
  // -----------------------
  @override
  Future<UserEntity?> me() async {
    final raw = await session.getUserRaw();
    if (raw == null || raw.isEmpty) return null;

    return UserEntity.fromJson(jsonDecode(raw));
  }

  // -----------------------
  // LOGOUT
  // -----------------------
  @override
  Future<void> logout() async {
    try {
      await remote.logout();
    } catch (_) {}
    await session.clear();
  }


  @override
  Future<bool> isLoggedIn() async {
    final token = await session.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getAccessToken() async {
    return await session.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await session.getRefreshToken();
  }
  // -----------------------
  // REFRESH TOKENS
  // -----------------------
  @override
  Future<void> refreshIfNeeded() async {
    try {
      final refresh = await session.getRefreshToken();
      if (refresh == null) throw Exception("No refresh token");

      final res = await remote.refresh(refresh);

      await session.saveTokens(
        accessToken: res['accessToken'],
        refreshToken: res['refreshToken'],
      );

      if (res['user'] != null) {
        await session.saveUserRaw(jsonEncode(res['user']));
      }
    } catch (_) {
      await session.clear();
      rethrow;
    }
  }

  // -----------------------
  // VERIFICATION
  // -----------------------
  @override
  Future<void> sendEmailVerification(
      String email, VerificationType type) async {
    try {
      await remote.sendVerification(email, type);
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  @override
  Future<bool> verifyEmailCode(
      String email, String code, VerificationType type) async {
    try {
      final ok = await remote.verifyCode(email, code, type);
      return ok;
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  @override
  Future<void> verifyResetCode(
      String email, String code, VerificationType type) async {
    try {
      await remote.verifyResetCode(email, code, type);
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  // -----------------------
  // FORGOT / RESET PASSWORD
  // -----------------------
  Future<void> forgotPassword(String email) async {
    try {
      await remote.forgotPassword(email);
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await remote.resetPassword(email, newPassword);
    } on DioException catch (e) {
      throw Exception(_extractMsg(e));
    }
  }

  // -----------------------
  // SOCIAL AUTH (placeholder)
  // -----------------------
  Future<void> signInWithGoogle() async => throw Exception("Not implemented");
  Future<void> signInWithApple() async => throw Exception("Not implemented");
  Future<void> signInWithFacebook() async => throw Exception("Not implemented");
}