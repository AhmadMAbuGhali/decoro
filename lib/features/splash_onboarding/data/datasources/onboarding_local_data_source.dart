import 'package:shared_preferences/shared_preferences.dart';


class OnboardingLocalDataSource{
  // key
  static const _KFirstRunKey = 'is_first_run';

  // if key not present => return true (first run )
Future<bool> isFirstRun() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_KFirstRunKey) ?? true;

}


//sets the flag to indicate onboarding is complete
Future<void> setFirstRunFalse() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_KFirstRunKey, false);

}

Future<void> reset() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_KFirstRunKey);
}





}