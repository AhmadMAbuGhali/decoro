part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class PasswordChanged extends ResetPasswordEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class PasswordSubmitted extends ResetPasswordEvent {
  final String email;
  PasswordSubmitted(this.email);
}