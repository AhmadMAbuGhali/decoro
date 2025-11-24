import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../../core/services/network/api_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient client;
  ProductRemoteDataSource(this.client);

  Future<List<ProductModel>> fetchProducts({int page = 1, int limit = 20}) async {
    final res = await client.get('/products', query: {'page': '$page', 'limit': '$limit'});
    final data = res['data'] ?? res; // depending on API shape
    if (data is List) {
      return data.map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e))).toList();
    } else if (data is Map && data['products'] is List) {
      return (data['products'] as List).map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    return [];
  }

  Future<ProductModel> fetchProductById(String id) async {
    final res = await client.get('/products/$id');
    final map = res['data'] ?? res;
    return ProductModel.fromJson(Map<String, dynamic>.from(map));
  }

  Future<ProductModel> createProduct(Map<String, dynamic> body, {String? token}) async {
    final res = await client.post('/products', body: body, headers: client.defaultHeaders(token));
    return ProductModel.fromJson(Map<String, dynamic>.from(res['data'] ?? res));
  }

  Future<ProductModel> updateProduct(String id, Map<String, dynamic> body, {String? token}) async {
    final res = await client.put('/products/$id', body: body, headers: client.defaultHeaders(token));
    return ProductModel.fromJson(Map<String, dynamic>.from(res['data'] ?? res));
  }

  // upload single file as main image
  Future<ProductModel> uploadMainImage(String id, Uint8List bytes, String filename, {String? token}) async {
    final uri = client.buildUri('/products/$id/image');
    final req = http.MultipartRequest('POST', uri);
    if (token != null) req.headers['Authorization'] = 'Bearer $token';
    req.files.add(http.MultipartFile.fromBytes('image', bytes, filename: filename, contentType: MediaType('image','jpeg')));
    final streamed = await req.send();
    final res = await http.Response.fromStream(streamed);
    if (res.statusCode < 200 || res.statusCode >= 300) throw Exception('Upload main image failed: ${res.statusCode} ${res.body}');
    final decoded = jsonDecode(res.body);
    return ProductModel.fromJson(Map<String,dynamic>.from(decoded['data'] ?? decoded));
  }

  // upload multiple gallery files (field name 'image' per your backend)
  Future<ProductModel> uploadGallery(String id, List<MapEntry<String, Uint8List>> files, {String? token}) async {
    final uri = client.buildUri('/products/$id/gallery');
    final req = http.MultipartRequest('POST', uri);
    if (token != null) req.headers['Authorization'] = 'Bearer $token';
    for (final f in files) {
      req.files.add(http.MultipartFile.fromBytes('image', f.value, filename: f.key, contentType: MediaType('image','jpeg')));
    }
    final streamed = await req.send();
    final res = await http.Response.fromStream(streamed);
    if (res.statusCode < 200 || res.statusCode >= 300) throw Exception('Upload gallery failed: ${res.statusCode} ${res.body}');
    final decoded = jsonDecode(res.body);
    return ProductModel.fromJson(Map<String,dynamic>.from(decoded['data'] ?? decoded));
  }

  Future<ProductModel> deleteGalleryImage(String id, String publicId, {String? token}) async {
    final res = await client.post('/products/$id/gallery/delete', body: {'imageId': publicId}, headers: client.defaultHeaders(token));
    return ProductModel.fromJson(Map<String, dynamic>.from(res['data'] ?? res));
  }
}