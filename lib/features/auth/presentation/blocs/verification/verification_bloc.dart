import 'package:bloc/bloc.dart';
import 'verification_event.dart';
import 'verification_state.dart';
import '../../../domain/repositories/auth_repository.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AuthRepository authRepository;

  VerificationBloc(this.authRepository) : super(VerificationInitial()) {
    on<SendVerificationCode>(_onSendCode);
    on<VerifyCodeSubmitted>(_onVerifyCode);
  }

  Future<void> _onSendCode(
      SendVerificationCode event, Emitter<VerificationState> emit) async {
    emit(VerificationLoading());
    try {
      await authRepository.sendEmailVerification(event.email, event.type);
      emit(VerificationCodeSent(event.email));
    } catch (e) {
      emit(VerificationFailure(e.toString()));
    }
  }

  Future<void> _onVerifyCode(
      VerifyCodeSubmitted event, Emitter<VerificationState> emit) async {
    emit(VerificationLoading());
    try {
      final verified = await authRepository.verifyEmailCode(
        event.email,
        event.code,
        event.type,
      );
      if (verified) {
        emit(VerificationSuccess(type: event.type));
      } else {
        emit(const VerificationFailure('Invalid or expired code'));
      }
    } catch (e) {
      emit(VerificationFailure(e.toString()));
    }
  }
}