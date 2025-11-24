// lib/core/services/network/auth_interceptor.dart
import 'dart:async';
import 'dart:convert';
import 'package:synchronized/synchronized.dart';
import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';
import '../storage/local_storage_service.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../session/session_manager.dart';
import 'dio_client.dart';

/// Auth interceptor:
/// - attaches Authorization header
/// - when receives 401 tries to refresh token (single-flight)
/// - retries the failed request once after successful refresh
class AuthInterceptor extends Interceptor {
  final SessionManager sessionManager;
  final Dio _refreshDio = Dio(); // independent client for refresh calls
  final _refreshLock = Lock();

  AuthInterceptor({required this.sessionManager}) {
    // ensure base options for _refreshDio match server base if needed
    _refreshDio.options.baseUrl = DioClient.dio.options.baseUrl;
    _refreshDio.options.connectTimeout = const Duration(seconds: 15);
    _refreshDio.options.receiveTimeout = const Duration(seconds: 15);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await sessionManager.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
      // ignore
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // only handle 401 (unauthorized)
    final status = err.response?.statusCode ?? 0;
    final reqOptions = err.requestOptions;

    if (status == 401 && !_isRefreshEndpoint(reqOptions.path)) {
      try {
        // prevent multiple refresh calls concurrently
        await _refreshLock.synchronized(() async {
          final refreshToken = await sessionManager.getRefreshToken();
          if (refreshToken == null || refreshToken.isEmpty) {
            // no refresh token -> forward error
            return;
          }

          // call refresh endpoint
          final resp = await _refreshDio.post(
             '/auth/refresh',
            data: {'refreshToken': refreshToken},
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ),
          );

          if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
            // try to extract new tokens
            final body = resp.data is String ? jsonDecode(resp.data) : resp.data;
            final access = body['accessToken'] ?? body['token'] ?? body['access_token'] ?? body['access'];
            final refresh = body['refreshToken'] ?? body['refresh_token'] ?? null;

            if (access != null) {
              await sessionManager.saveTokens(
                accessToken: access.toString(),
                refreshToken: refresh?.toString() ?? refreshToken,
              );
            } else {
              // refresh failed logically
              await sessionManager.clear();
              return;
            }
          } else {
            // couldn't refresh
            await sessionManager.clear();
            return;
          }
        });

        // After refresh attempt, retry original request once
        final newAccess = await sessionManager.getAccessToken();
        if (newAccess != null && newAccess.isNotEmpty) {
          final opts = Options(
            method: reqOptions.method,
            headers: Map<String, dynamic>.from(reqOptions.headers)..['Authorization'] = 'Bearer $newAccess',
            responseType: reqOptions.responseType,
            followRedirects: reqOptions.followRedirects,
            validateStatus: reqOptions.validateStatus,
            receiveTimeout: reqOptions.receiveTimeout,
            sendTimeout: reqOptions.sendTimeout,
          );

          final cloneReq = await _retryRequest(reqOptions, opts);
          return handler.resolve(cloneReq);
        } else {
          // no new token -> forward original error
          return handler.next(err);
        }
      } catch (e) {
        // anything goes wrong -> forward original error
        return handler.next(err);
      }
    }

    // other errors
    return handler.next(err);
  }

  bool _isRefreshEndpoint(String path) {
    final normalized = path.toLowerCase();
    return normalized.contains('/auth/refresh') || normalized.contains('/refresh');
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions, Options opts) {
    // use DioClient.dio to retry (it has interceptors attached, but Authorization header already set)
    return DioClient.dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: opts,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }
}