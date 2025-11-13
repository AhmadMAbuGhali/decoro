import 'package:equatable/equatable.dart';

/// نوع التحقق (للتفريق بين التسجيل ونسيان كلمة المرور)
enum VerificationType { emailVerification, passwordReset }

/// الأحداث الخاصة بالتحقق
abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

/// إرسال كود التحقق للإيميل
class SendVerificationCode extends VerificationEvent {
  final String email;
  final VerificationType type;

  const SendVerificationCode(this.email, this.type);

  @override
  List<Object> get props => [email, type];
}

/// التحقق من الكود
class VerifyCodeSubmitted extends VerificationEvent {
  final String email;
  final String code;
  final VerificationType type;

  const VerifyCodeSubmitted(this.email, this.code, this.type);

  @override
  List<Object> get props => [email, code, type];
}