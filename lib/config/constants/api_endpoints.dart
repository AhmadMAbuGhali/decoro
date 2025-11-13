class ApiEndpoints {
  static const String base = 'http://localhost:3000/api';
  static const String login = '$base/auth/login';
  static const String register = '$base/auth/register';
  static const String  sendVerification= '$base/verify/send';
  static const String verifyCode = "$base/verify/confirm";
  static const forgotPassword = "$base/auth/forgot-password";
  static const verifyResetCode = "$base/auth/verify-reset-code";
  static const resetPassword = "$base/auth/reset-password";


}