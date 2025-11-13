part of 'reset_code_bloc.dart';

abstract class ResetCodeEvent {}

class VerifyResetCodeEvent extends ResetCodeEvent {
  final String email;
  final String code;

  VerifyResetCodeEvent({
    required this.email,
    required this.code,
  });
}