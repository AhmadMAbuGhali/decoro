enum Environment { dev, staging, prod }

class AppEnv {
  /// 🔥 Current active environment
  static Environment current = Environment.dev;

  /// 📌 Base API URL for backend depending on environment
  static String get apiBaseUrl {
    switch (current) {
      case Environment.dev:
        return "http://localhost:3000/api";

      case Environment.staging:
        return "https://staging.decoro.com/api";

      case Environment.prod:
        return "https://decoro.com/api";
    }
  }

  /// Quick boolean helpers
  static bool get isDev => current == Environment.dev;
  static bool get isStaging => current == Environment.staging;
  static bool get isProduction => current == Environment.prod;

  /// Optional: Environment-based logging level
  static bool get enableDebugLogs => isDev;

  /// Optional: Setup method to switch environments if needed
  static void setEnvironment(Environment env) {
    current = env;
  }
}