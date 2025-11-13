enum Environment { dev, staging, prod }

class AppEnv {
  static Environment current = Environment.dev;

  static bool get isProduction => current == Environment.prod;
  static bool get isStaging => current == Environment.staging;
  static bool get isDev => current == Environment.dev;
}