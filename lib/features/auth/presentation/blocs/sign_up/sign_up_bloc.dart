import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';





class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase useCase;

  SignUpBloc(this.useCase) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final UserEntity user = await useCase(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess(user));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}