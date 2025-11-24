import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class ProductListState extends Equatable {
  final List<ProductModel> products;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final bool hasMore;
  final int page;

  const ProductListState({
    this.products = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.hasMore = true,
    this.page = 1,
  });

  ProductListState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    bool? hasMore,
    int? page,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, hasError, errorMessage, hasMore, page];
}