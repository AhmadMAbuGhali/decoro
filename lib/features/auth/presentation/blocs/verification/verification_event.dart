import 'package:equatable/equatable.dart';

/// نوع التحقق (لتحديد نوع العملية)
enum VerificationType { emailVerification, passwordReset }

/// تحويل النوع إلى String كما يريده الـ Backend
extension VerificationTypeMapper on VerificationType {
  String toBackendString() {
    switch (this) {
      case VerificationType.emailVerification:
        return "email_verification";
      case VerificationType.passwordReset:
        return "password_reset";
    }
  }
}

/// الأحداث الخاصة بالتحقق
abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

/// إرسال كود التحقق
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