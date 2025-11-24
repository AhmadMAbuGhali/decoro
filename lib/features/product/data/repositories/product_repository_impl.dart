import 'dart:typed_data';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) => remote.fetchProducts(page: page, limit: limit);

  @override
  Future<ProductModel> getProduct(String id) => remote.fetchProductById(id);

  @override
  Future<ProductModel> uploadMainImage(String id, Uint8List bytes, String filename) => remote.uploadMainImage(id, bytes, filename);

  @override
  Future<ProductModel> uploadGallery(String id, List<MapEntry<String, Uint8List>> files) => remote.uploadGallery(id, files);

  @override
  Future<ProductModel> deleteGalleryImage(String id, String publicId) => remote.deleteGalleryImage(id, publicId);
}