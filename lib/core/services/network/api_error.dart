import 'package:dio/dio.dart';

class ApiError {
  static String parse(dynamic error) {
    if (error is DioException) {
      return _handleDio(error);
    }
    return error.toString();
  }

  static String _handleDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Request timeout";
    }

    if (e.type == DioExceptionType.badResponse) {
      final data = e.response?.data;

      if (data is Map && data['message'] != null) {
        return data['message'];
      }

      return "Server error: ${e.response?.statusCode}";
    }

    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection";
    }

    return e.message ?? "Unknown error";
  }
}