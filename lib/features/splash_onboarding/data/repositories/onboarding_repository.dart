/// Repository abstraction for onboarding logic and local persistence.
abstract class OnboardingRepository {
  /// Returns true if this is the user's first time opening the app.
  Future<bool> isFirstRun();

  /// Marks onboarding as completed.
  Future<void> completeOnboarding();

  /// Debug helper for development.
  Future<void> debugPrintValue();
}