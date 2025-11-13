import 'package:dio/dio.dart';
import '../../../config/constants/api_endpoints.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.base,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}