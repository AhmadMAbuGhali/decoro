import 'package:dio/dio.dart';

class SimpleInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add headers, token, etc.
    handler.next(options);
  }
}