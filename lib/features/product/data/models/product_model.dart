class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String category;
  final Map<String, dynamic>? mainImage; // {url, public_id}
  final List<Map<String, dynamic>> gallery; // list of {url, public_id, _id}
  final List<String> materials;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.mainImage,
    required this.gallery,
    required this.materials,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final main = json['mainImage'] ?? json['image'] ?? json['imageUrl'] ?? null;
    final galleryRaw = json['gallery'] ?? json['images'] ?? [];
    return ProductModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0).toInt(),
      category: json['category'] ?? '',
      mainImage: main is Map ? Map<String, dynamic>.from(main) : (main != null ? {'url': main.toString()} : null),
      gallery: (galleryRaw as List).map((e) => Map<String, dynamic>.from(e)).toList(),
      materials: ((json['materials'] as List?) ?? []).map((e) => e.toString()).toList(),
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'price': price,
    'stock': stock,
    'category': category,
    'mainImage': mainImage,
    'gallery': gallery,
    'materials': materials,
  };
}