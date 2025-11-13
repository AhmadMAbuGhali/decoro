abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  final int currentPage;
  OnboardingInitial({this.currentPage = 0});
}

class OnboardingSaving extends OnboardingState {}



class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  OnboardingPageChanged(this.currentPage);
}

class OnboardingSaved extends OnboardingState {}