import 'package:dio/dio.dart';

class SimpleInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // add headers, logging, etc.
    handler.next(options);
  }
}