class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String category;
  final String? mainImageUrl;
  final List<String> galleryUrls;
  final List<String> materials;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.mainImageUrl,
    this.galleryUrls = const [],
    this.materials = const [],
  });
}