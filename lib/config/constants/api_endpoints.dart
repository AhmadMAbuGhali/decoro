class ApiEndpoints {


  // ========== AUTH ==========
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  // ========== EMAIL VERIFICATION ==========
  static const String sendVerification = '/verify/send';
  static const String verifyCode = '/verify/confirm';

  // ========== PASSWORD RESET ==========
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyResetCode = '/auth/verify-reset-code';
  static const String resetPassword = '/auth/reset-password';

  // ========== PRODUCTS ==========
  static const String products = '/products';
  static String productById(String id) => '$products/$id';
  static String productMainImage(String id) => '$products/$id/image';
  static String productGallery(String id) => '$products/$id/gallery';
  static String productDeleteGallery(String id) => '$products/$id/gallery/delete';

  // ========== ORDERS ==========
  static const String orders = '/orders';
  static String orderById(String id) => '$orders/$id';
  static String orderStatus(String id) => '$orders/$id/status';
  static String userOrders(String userId) => '$orders/user/$userId';
}