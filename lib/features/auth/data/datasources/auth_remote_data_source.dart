import 'package:dio/dio.dart';
import 'package:decoro/config/constants/api_endpoints.dart';
import 'package:decoro/features/auth/presentation/blocs/verification/verification_event.dart';
import 'package:decoro/core/services/network/api_client.dart';

/// Remote Data Source responsible for calling the backend Auth APIs.
/// All functions return raw maps suitable for AuthRepositoryImpl.
class AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSource(this.client);

  // -------------------------
  // LOGIN
  // -------------------------
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await client.post(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
    );
    return Map<String, dynamic>.from(res['data'] ?? res);
  }

  // -------------------------
  // REGISTER
  // -------------------------
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final res = await client.post(
      ApiEndpoints.register,
      body: {'name': name, 'email': email, 'password': password},
    );
    return Map<String, dynamic>.from(res['data'] ?? res);
  }

  // -------------------------
  // LOGOUT
  // -------------------------
  Future<void> logout() async {
    try {
      await client.post(ApiEndpoints.logout);
    } catch (_) {}
  }

  // -------------------------
  // REFRESH TOKEN
  // -------------------------
  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final res = await client.post(
      ApiEndpoints.refresh,
      body: {'refreshToken': refreshToken},
    );
    return Map<String, dynamic>.from(res['data'] ?? res);
  }

  // -------------------------
  // SEND VERIFICATION CODE
  // -------------------------
  Future<void> sendVerification(String email, VerificationType type) async {
    await client.post(
      ApiEndpoints.sendVerification,
      body: {
        'email': email,
        'type': type == VerificationType.emailVerification
            ? "email_verification"
            : "password_reset",
      },
    );
  }

  // -------------------------
  // VERIFY EMAIL CODE
  // -------------------------
  Future<bool> verifyCode(
      String email, String code, VerificationType type) async {

    final res = await client.post(
      ApiEndpoints.verifyCode,
      body: {
        'email': email,
        'code': code,
        'type': type == VerificationType.emailVerification
            ? "email_verification"
            : "password_reset",
      },
    );

    // res دائما Map عند استخدام ApiClient
    if (res is Map<String, dynamic>) {
      if (res['success'] == true) return true;
      if (res['message'] != null &&
          res['message'].toString().toLowerCase().contains("success")) {
        return true;
      }
      return false;
    }

    return false;
  }

  // -------------------------
  // VERIFY RESET CODE
  // -------------------------
  Future<void> verifyResetCode(
      String email, String code, VerificationType type) async {
    final res = await client.post(
      ApiEndpoints.verifyResetCode,
      body: {
        'email': email,
        'code': code,
        'type': type == VerificationType.passwordReset
            ? "password_reset"
            : "email_verification",
      },
    );

    if (res is Map && res['statusCode'] != 200) {
      throw Exception(res['message'] ?? "Invalid code");
    }
  }

  // -------------------------
  // FORGOT PASSWORD
  // -------------------------
  Future<void> forgotPassword(String email) async {
    final res = await client.post(
      ApiEndpoints.forgotPassword,
      body: {'email': email},
    );

    if (res is Map &&
        !(res['statusCode'] == 200 || res['statusCode'] == 201)) {
      throw Exception(res['message'] ?? "Failed to send reset code");
    }
  }

  // -------------------------
  // RESET PASSWORD
  // -------------------------
  Future<void> resetPassword(String email, String newPassword) async {
    final res = await client.post(
      ApiEndpoints.resetPassword,
      body: {'email': email, 'newPassword': newPassword},
    );

    if (res is Map && res['statusCode'] != 200) {
      throw Exception(res['message'] ?? "Failed to reset password");
    }
  }
}