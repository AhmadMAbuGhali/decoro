import 'package:equatable/equatable.dart';
import 'verification_event.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationCodeSent extends VerificationState {
  final String email;

  const VerificationCodeSent(this.email);

  @override
  List<Object> get props => [email];
}

class VerificationSuccess extends VerificationState {
  final VerificationType type;

  const VerificationSuccess({required this.type});

  @override
  List<Object> get props => [type];
}

class VerificationFailure extends VerificationState {
  final String message;

  const VerificationFailure(this.message);

  @override
  List<Object> get props => [message];
}