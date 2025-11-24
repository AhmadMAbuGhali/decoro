import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String id;
  final String title;
  final double price;
  final String image;
  final String category;

  const SearchResult({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, price, image, category];
}