import '../../domin/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  SearchResultModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.category,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['_id'] ?? "",
      title: json['name'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      image: json['mainImage']?['url'] ??
          (json['gallery'] != null && json['gallery'].isNotEmpty
              ? json['gallery'][0]['url']
              : ""),
      category: json['category'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "image": image,
      "category": category,
    };
  }

  SearchResult toEntity() {
    return SearchResult(
      id: id,
      title: title,
      price: price,
      image: image,
      category: category,
    );
  }
}