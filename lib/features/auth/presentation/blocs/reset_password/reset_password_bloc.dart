import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository repository;

  ResetPasswordBloc(this.repository) : super(ResetPasswordState()) {
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<PasswordSubmitted>(_onPasswordSubmitted);
  }

  Future<void> _onPasswordSubmitted(
      PasswordSubmitted event,
      Emitter<ResetPasswordState> emit,
      ) async {
    print("🔥 SUBMIT RECEIVED WITH EMAIL = ${event.email}");

    if (state.password.isEmpty ||
        state.confirmPassword.isEmpty ||
        state.password != state.confirmPassword) {
      emit(state.copyWith(errorMessage: "Passwords do not match"));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: ""));

    try {
      print("🔵 CALLING API resetPassword...");
      await repository.resetPassword(event.email, state.password);
      print("✅ PASSWORD RESET SUCCESS");

      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      print("❌ RESET ERROR: $e");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}