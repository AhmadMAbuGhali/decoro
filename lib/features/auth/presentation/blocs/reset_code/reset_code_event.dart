part of 'reset_code_bloc.dart';

abstract class ResetCodeEvent {}

class VerifyResetCodeEvent extends ResetCodeEvent {
  final String email;
  final String code;
  final VerificationType type; // 👈 تمت الإضافة

  VerifyResetCodeEvent({
    required this.email,
    required this.code,
    required this.type,
  });
}