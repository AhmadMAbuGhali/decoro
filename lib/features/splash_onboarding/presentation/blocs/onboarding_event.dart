import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingCompleteRequested extends OnboardingEvent {}

class OnboardingPageChangedEvent extends OnboardingEvent {
  final int page;

  OnboardingPageChangedEvent(this.page);

  @override
  List<Object?> get props => [page];
}