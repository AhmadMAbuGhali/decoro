part of 'reset_code_bloc.dart';

class ResetCodeState {
  final bool isLoading;
  final bool success;
  final String errorMessage;

  const ResetCodeState({
    this.isLoading = false,
    this.success = false,
    this.errorMessage = '',
  });

  ResetCodeState copyWith({
    bool? isLoading,
    bool? success,
    String? errorMessage,
  }) {
    return ResetCodeState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}