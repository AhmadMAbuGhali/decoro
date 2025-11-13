import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'reset_code_event.dart';
part 'reset_code_state.dart';

class ResetCodeBloc extends Bloc<ResetCodeEvent, ResetCodeState> {
  final AuthRepository repository;

  ResetCodeBloc(this.repository) : super(const ResetCodeState()) {
    on<VerifyResetCodeEvent>(_onVerify);
  }

  Future<void> _onVerify(
      VerifyResetCodeEvent event,
      Emitter<ResetCodeState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      await repository.verifyResetCode(event.email, event.code);

      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}