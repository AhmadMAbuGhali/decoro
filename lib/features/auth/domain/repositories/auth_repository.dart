import '../entities/user_entity.dart';
import '../../../auth/presentation/blocs/verification/verification_event.dart';

abstract class AuthRepository {
  // --------------------------------------------------
  // 🔵 Basic Auth
  // --------------------------------------------------

  /// Login with email + password
  Future<UserEntity> login(String email, String password);

  /// Register with name + email + password
  Future<UserEntity> register(String name, String email, String password);

  /// Get saved user (local only) OR call /auth/me
  Future<UserEntity?> me();

  /// Check if user has a valid saved access token
  Future<bool> isLoggedIn();

  /// Logout (server + clear local session)
  Future<void> logout();

  // --------------------------------------------------
  // 🟣 Email Verification
  // --------------------------------------------------

  Future<void> sendEmailVerification(
      String email,
      VerificationType type,
      );

  Future<bool> verifyEmailCode(
      String email,
      String code,
      VerificationType type,
      );

  // --------------------------------------------------
  // 🟠 Forgot Password
  // --------------------------------------------------

  Future<void> forgotPassword(String email);

  Future<void> verifyResetCode(String email, String code, VerificationType type);

  Future<void> resetPassword(String email, String newPassword);

  // --------------------------------------------------
  // 🟡 OAuth (UI جاهزة)
  // --------------------------------------------------

  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithFacebook();

  // --------------------------------------------------
  // 🔴 Token Management
  // --------------------------------------------------

  Future<void> refreshIfNeeded();

  // Raw session (optional use cases)
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}