import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/onboarding_repository.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository repository;

  OnboardingBloc(this.repository) : super(OnboardingInitial()) {
    on<OnboardingPageChangedEvent>((event, emit) {
      emit(OnboardingPageChanged(event.page));
    });

    on<OnboardingCompleteRequested>((event, emit) async {
      await repository.completeOnboarding();
      emit(OnboardingSaved());
    });
  }
}