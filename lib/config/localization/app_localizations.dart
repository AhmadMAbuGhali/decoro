// Placeholder wrapper - use intl / arb in real project
class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  String t(String key) {
    // simple placeholder translations
    final map = <String, Map<String, String>>{
      'en': {'login': 'Login', 'email': 'Email', 'password': 'Password'},
      'ar': {'login': 'تسجيل الدخول', 'email': 'البريد الإلكتروني', 'password': 'كلمة المرور'},
    };
    return map[locale]?[key] ?? key;
  }
}