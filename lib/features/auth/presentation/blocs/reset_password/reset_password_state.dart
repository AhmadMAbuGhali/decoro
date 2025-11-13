part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final bool success;
  final String errorMessage;

  ResetPasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.success = false,
    this.errorMessage = '',
  });

  ResetPasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? success,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}