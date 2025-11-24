import 'package:dio/dio.dart';
import 'package:decoro/core/services/network/auth_interceptor.dart';
import 'package:decoro/core/services/session/session_manager.dart';
import 'package:decoro/core/services/network/dio_client.dart';

class DioClient {

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://localhost:3000/api',
      ),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        "Accept": "application/json",
      },
    ),
  )..interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (m) => print("📡 $m"),
    ),
  );

}