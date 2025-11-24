import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _prefix = "decoro_secure_";

  /// تخزين آمن
  Future<void> write(String key, String value) async {
    await _storage.write(key: _prefix + key, value: value);
  }

  /// قراءة قيمة آمنة
  Future<String?> read(String key) async {
    return await _storage.read(key: _prefix + key);
  }

  /// حذف قيمة
  Future<void> delete(String key) async {
    await _storage.delete(key: _prefix + key);
  }

  /// قراءة كل البيانات المخزنة
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  /// حذف كل البيانات (عند تسجيل خروج)
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}