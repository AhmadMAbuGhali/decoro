abstract class OnboardingRepository{

  Future<bool> isFirstRun();

  Future<void> completeOnboarding();

}
