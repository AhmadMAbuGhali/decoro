import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _prefix = "decoro_local_";

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// حفظ String
  Future<void> setString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(_prefix + key, value);
  }

  /// قراءة String
  Future<String?> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(_prefix + key);
  }

  /// حفظ Boolean
  Future<void> setBool(String key, bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_prefix + key, value);
  }

  /// قراءة Boolean
  Future<bool?> getBool(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(_prefix + key);
  }

  /// حفظ رقم
  Future<void> setInt(String key, int value) async {
    final prefs = await _prefs;
    await prefs.setInt(_prefix + key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(_prefix + key);
  }

  /// حذف قيمة
  Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(_prefix + key);
  }

  /// مسح كل شيء خاص بالتطبيق
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}