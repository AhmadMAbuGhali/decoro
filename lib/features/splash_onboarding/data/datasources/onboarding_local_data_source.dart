import 'package:shared_preferences/shared_preferences.dart';

/// Handles saving & reading onboarding state from local storage.
class OnboardingLocalDataSource {
  static const _kFirstRunKey = 'is_first_run';

  /// Returns true if the user has never completed the onboarding.
  Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kFirstRunKey) ?? true;
  }

  /// Marks onboarding as completed.
  Future<void> setFirstRunFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kFirstRunKey, false);
  }

  /// Removes the onboarding flag (useful for debugging / testing).
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kFirstRunKey);
  }

  /// Debug helper – prints the current stored value.
  Future<void> debugPrintValue() async {
    final prefs = await SharedPreferences.getInstance();
    print("🔍 FIRST RUN VALUE = ${prefs.getBool(_kFirstRunKey)}");
  }
}