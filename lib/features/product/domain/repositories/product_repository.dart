import '../entities/product.dart';
import '../../data/models/product_model.dart';
import 'dart:typed_data';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20});
  Future<ProductModel> getProduct(String id);
  Future<ProductModel> uploadMainImage(String id, Uint8List bytes, String filename);
  Future<ProductModel> uploadGallery(String id, List<MapEntry<String, Uint8List>> files);
  Future<ProductModel> deleteGalleryImage(String id, String publicId);
}