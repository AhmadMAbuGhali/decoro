import '../../presentation/blocs/verification/verification_event.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<UserEntity> signInWithEmail(String email, String password);
  Future<UserEntity> registerWithEmail(String email, String password);

  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  });

  // Verification email (for account activation)
  Future<void> sendEmailVerification(String email, VerificationType type);

  // Forgot Password Flow
  Future<void> forgotPassword(String email);
  Future<void> verifyResetCode(String email, String code);
  Future<void> resetPassword(String email, String newPassword);
}