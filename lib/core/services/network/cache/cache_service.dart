import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  /// مفتاح التخزين الأساسي
  static const _productsKey = 'cache_products_list';

  /// مدة صلاحية الكاش (اختياري) – 30 دقيقة
  static const Duration _defaultExpiry = Duration(minutes: 30);

  /// تخزين JSON string
  Future<void> saveProductsJson(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_productsKey, json);

    // حفظ وقت التخزين لضبط صلاحية الكاش
    await prefs.setInt('${_productsKey}_time', DateTime.now().millisecondsSinceEpoch);
  }

  /// قراءة JSON من الكاش
  ///
  /// يقوم بفحص صلاحية الكاش قبل إرجاع البيانات.
  Future<String?> getProductsJson() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTime = prefs.getInt('${_productsKey}_time');
    final now = DateTime.now().millisecondsSinceEpoch;

    // إذا كان الوقت غير موجود → لا يوجد كاش صالح
    if (savedTime == null) {
      return null;
    }

    // التحقق من مدة الصلاحية
    if ((now - savedTime) > _defaultExpiry.inMilliseconds) {
      await clearProducts();
      return null;
    }

    return prefs.getString(_productsKey);
  }

  /// حذف كاش المنتجات
  Future<void> clearProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_productsKey);
    await prefs.remove('${_productsKey}_time');
  }

  /// 🔍 Debug helper
  Future<void> debugPrintCache() async {
    final prefs = await SharedPreferences.getInstance();
    print("Products Cache: ${prefs.getString(_productsKey)}");
    print("Saved Time: ${prefs.getInt('${_productsKey}_time')}");
  }
}