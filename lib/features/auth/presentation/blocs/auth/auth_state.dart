import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// --------------------------------------------------
// Initial
// --------------------------------------------------
class AuthInitial extends AuthState {}

// --------------------------------------------------
// Checking (Splash startup / app init)
// --------------------------------------------------
class AuthChecking extends AuthState {}

// --------------------------------------------------
// Generic Loading (login / register / verify / reset)
// --------------------------------------------------
class AuthLoading extends AuthState {}

// --------------------------------------------------
// Authentication success (user logged in)
// --------------------------------------------------
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// --------------------------------------------------
// No user logged in
// --------------------------------------------------
class AuthUnauthenticated extends AuthState {}

// --------------------------------------------------
// General success state (useful for send-code, verify-code, reset-pass)
// --------------------------------------------------
class AuthActionSuccess extends AuthState {
  final String message;

  const AuthActionSuccess([this.message = "Success"]);

  @override
  List<Object?> get props => [message];
}

// --------------------------------------------------
// Error
// --------------------------------------------------
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}