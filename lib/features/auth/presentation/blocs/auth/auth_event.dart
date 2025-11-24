import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

//
// 🔵 Check Auth Status – runs at App start
//
class AuthCheckStatus extends AuthEvent {}

//
// 🔵 Login (Email & Password)
//
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

//
// 🔵 Register
//
class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

//
// 🔵 Logout
//
class AuthLogoutRequested extends AuthEvent {}

//
// 🔵 Send Verification Code (email verification / reset password)
//
class AuthSendVerificationCode extends AuthEvent {
  final String email;
  final String type; // "email_verification" OR "password_reset"

  const AuthSendVerificationCode({
    required this.email,
    required this.type,
  });

  @override
  List<Object?> get props => [email, type];
}

//
// 🔵 Verify Code
//
class AuthVerifyCode extends AuthEvent {
  final String email;
  final String code;
  final String type;

  const AuthVerifyCode({
    required this.email,
    required this.code,
    required this.type,
  });

  @override
  List<Object?> get props => [email, code, type];
}

//
// 🔵 Reset Password
//
class AuthResetPassword extends AuthEvent {
  final String email;
  final String newPassword;

  const AuthResetPassword({
    required this.email,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, newPassword];
}

//
// 🔵 Social Login (Google / Apple / Facebook)
//
class AuthGoogleRequested extends AuthEvent {}

class AuthAppleRequested extends AuthEvent {}

class AuthFacebookRequested extends AuthEvent {}