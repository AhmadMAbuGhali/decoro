import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthWithEmailRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthWithEmailRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthWithGoogleRequested extends AuthEvent {}

class AuthWithAppleRequested extends AuthEvent {}

class AuthWithFacebookRequested extends AuthEvent {}