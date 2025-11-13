import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository repository;

  ForgotPasswordBloc(this.repository) : super(const ForgotPasswordState()) {
    on<SendForgotRequest>((event, emit) async {
      print("🔥 BLOC HANDLER RECEIVED EVENT WITH EMAIL = ${event.email}");
      await _onSendForgot(event, emit);
    });
  }

  Future<void> _onSendForgot(
      SendForgotRequest event,
      Emitter<ForgotPasswordState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      await repository.forgotPassword(event.email);

      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}