abstract class OnboardingEvent {}

class OnboardingCompleteRequested extends OnboardingEvent {}
class OnboardingPageChangedEvent extends OnboardingEvent {
  final int page;
  OnboardingPageChangedEvent(this.page);
}