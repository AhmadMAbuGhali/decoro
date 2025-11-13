import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/services/network/api_client.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../presentation/blocs/verification/verification_event.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _api = ApiClient();

  // ---------------------------
  // 🔹 تسجيل الدخول بواسطة Google
  // ---------------------------
  @override
  Future<void> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('🔹 Sign in with Google (mock)');
  }

  // ---------------------------
  // 🔹 تسجيل الدخول بواسطة Apple
  // ---------------------------
  @override
  Future<void> signInWithApple() async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('🔹 Sign in with Apple (mock)');
  }

  // ---------------------------
  // 🔹 تسجيل الدخول بواسطة البريد
  // ---------------------------
  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    try {
      final response = await _api.post(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });

      print('📬 LOGIN RESPONSE TYPE: ${response.data.runtimeType}');
      print('📬 LOGIN RESPONSE: ${response.data}');

      final data = response.data is String
          ? jsonDecode(response.data)
          : response.data;

      return UserModel(
        id: data['_id'] ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
      );
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Network error during login');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // ---------------------------
  // 🔹 تسجيل جديد (مؤقت عبر signUp)
  // ---------------------------
  @override
  Future<UserEntity> registerWithEmail(String email, String password) async {
    return signUp(name: "User", email: email, password: password);
  }

  // ---------------------------
  // 🔹 إنشاء حساب جديد
  // ---------------------------
  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post(ApiEndpoints.register, {
        'name': name,
        'email': email,
        'password': password,
      });

      print('📬 STATUS CODE: ${response.statusCode}');
      print('📬 RAW RESPONSE TYPE: ${response.data.runtimeType}');
      print('📬 RAW RESPONSE DATA: ${response.data}');

      dynamic data;

      // ✅ نفك JSON إذا كان نص
      if (response.data is String) {
        try {
          data = jsonDecode(response.data);
        } catch (e) {
          print('⚠️ JSON Decode failed: $e');
          throw Exception('Invalid JSON response from server');
        }
      } else {
        data = response.data;
      }

      print('✅ PARSED DATA: $data');

      // ✅ التعامل مع الرد سواء فيه "user" أو لا
      final userData = data['user'] ?? data;

      return UserModel(
        id: userData['_id']?.toString() ?? '',
        name: userData['name'] ?? '',
        email: userData['email'] ?? '',
      );
    } on DioException catch (e) {
      print('❌ DioException: ${e.response?.data}');
      throw Exception(
          e.response?.data['message'] ?? 'Network error during registration');
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  // ---------------------------
  // ✅ إرسال كود التحقق للإيميل
  // ---------------------------
  Future<void> sendEmailVerification(String email, VerificationType type) async {
    try {
      final response = await _api.post(ApiEndpoints.sendVerification, {
        'email': email,
        'type': type == VerificationType.emailVerification
            ? 'email_verification'
            : 'password_reset',
      });

      print('📨 SEND VERIFICATION RESPONSE: ${response.data}');
      print('📨 RESPONSE TYPE: ${response.data.runtimeType}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Verification code sent to $email (${type.name})');
      } else {
        throw Exception(response.data['message'] ?? 'Failed to send code');
      }
    } on DioException catch (e) {
      print('❌ DioException while sending code: ${e.response?.data}');
      throw Exception(
          e.response?.data['message'] ?? 'Network error sending code');
    } catch (e) {
      print('❌ Unexpected error while sending code: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  // ---------------------------
  // ✅ التحقق من كود الإيميل
  // ---------------------------
  Future<bool> verifyEmailCode(
      String email, String code, VerificationType type) async {
    try {
      final response = await _api.post(ApiEndpoints.verifyCode, {
        'email': email,
        'code': code,
        'type': type == VerificationType.emailVerification
            ? 'email_verification'
            : 'password_reset',
      });

      print('📩 VERIFY RESPONSE TYPE: ${response.data.runtimeType}');
      print('📩 VERIFY RESPONSE: ${response.data}');

      // ✅ تحليل النتيجة حسب نوعها
      dynamic data;
      if (response.data is String) {
        try {
          data = jsonDecode(response.data);
        } catch (_) {
          data = response.data;
        }
      } else {
        data = response.data;
      }

      if (data is Map && data['message'] != null) {
        print('✅ Verification success message: ${data['message']}');
        return true;
      }

      if (data is String &&
          (data.contains('verified') || data.contains('success'))) {
        print('✅ Verification success (string detected)');
        return true;
      }

      return false;
    } on DioException catch (e) {
      print('❌ DioException verifying: ${e.response?.data}');
      throw Exception(
          e.response?.data['message'] ?? 'Verification request failed');
    } catch (e) {
      print('❌ Unexpected error verifying: $e');
      throw Exception('Unexpected error: $e');
    }
  }
  @override
  Future<void> forgotPassword(String email) async {
    try {
      print("📨 REPOSITORY CALL TRIGGERED");

      final res = await _api.post(ApiEndpoints.forgotPassword, {
        'email': email,
      });

      print("🔵 STATUS = ${res.statusCode}");
      print("🔵 DATA = ${res.data}");

      if (res.statusCode == 200) {
        print("📩 Reset code sent to email");
      } else {
        throw Exception(res.data['message'] ?? "Failed to send reset code");
      }
    } on DioException catch (e) {
      print("❌ DIO ERROR = ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? "Network error");
    }
  }
  // ===============================
  // 🔵 Step 2 – Verify Reset Code
  // ===============================
  @override
  Future<void> verifyResetCode(String email, String code) async {
    try {
      final res = await _api.post(ApiEndpoints.verifyResetCode, {
        'email': email,
        'code': code,
      });

      if (res.statusCode != 200) {
        throw Exception("Invalid code");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Invalid or expired code");
    }
  }

  // ===============================
  // 🔵 Step 3 – Reset Password
  // ===============================
  @override
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      final res = await _api.post(ApiEndpoints.resetPassword, {
        'email': email,
        'newPassword': newPassword,
      });

      if (res.statusCode != 200) {
        throw Exception(res.data['message'] ?? "Failed to reset password");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Network error");
    }
  }
}