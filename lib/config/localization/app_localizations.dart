import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  final String locale;
  static Map<String, dynamic>? _cache;

  AppLocalizations(this.locale);

  /// Load ARB file
  static Future<AppLocalizations> load(String locale) async {
    final data = await rootBundle.loadString('assets/translations/$locale.arb');
    _cache = jsonDecode(data);
    return AppLocalizations(locale);
  }

  /// Translate key
  String t(String key) {
    return _cache?[key] ?? key;
  }

  /// Supported locales
  static const supportedLocales = ['en', 'ar'];
}