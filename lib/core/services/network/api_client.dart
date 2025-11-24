import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;

  ApiClient({
    required this.baseUrl,
    http.Client? client,
    Duration? timeout,
  })  : _client = client ?? http.Client(),
        timeout = timeout ?? const Duration(seconds: 20);

  Uri buildUri(String path, [Map<String, String>? query]) =>
      Uri.parse('$baseUrl$path').replace(queryParameters: query);

  Map<String, String> defaultHeaders([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, String>? query}) async {
    final res = await _client
        .get(buildUri(path, query), headers: defaultHeaders())
        .timeout(timeout);

    return _decodeOrThrow(res);
  }

  Future<Map<String, dynamic>> post(String path,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final res = await _client
        .post(buildUri(path),
        headers: headers ?? defaultHeaders(),
        body: body == null ? null : jsonEncode(body))
        .timeout(timeout);

    return _decodeOrThrow(res);
  }

  Future<Map<String, dynamic>> put(String path,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final res = await _client
        .put(buildUri(path),
        headers: headers ?? defaultHeaders(),
        body: body == null ? null : jsonEncode(body))
        .timeout(timeout);

    return _decodeOrThrow(res);
  }

  Future<Map<String, dynamic>> delete(String path,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    final req = http.Request('DELETE', buildUri(path))
      ..headers.addAll(headers ?? defaultHeaders())
      ..body = body == null ? '' : jsonEncode(body);

    final streamed =
    await _client.send(req).timeout(timeout);

    final res = await http.Response.fromStream(streamed);
    return _decodeOrThrow(res);
  }

  Map<String, dynamic> _decodeOrThrow(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return {};

      try {
        final decoded = jsonDecode(res.body);
        if (decoded is Map<String, dynamic>) return decoded;
        return {'data': decoded};
      } catch (_) {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception(
          "Request failed with status ${res.statusCode}: ${res.body}");
    }
  }
}