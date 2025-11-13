part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SendForgotRequest extends ForgotPasswordEvent {
  final String email;
  SendForgotRequest(this.email);
}