part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure, loadingMore }

class HomeState {
  final HomeStatus status;
  final List<ProductModel> products;

  // 🔵 فئات واجهة المستخدم (UI categories)
  final List<HomeCategory> categories;

  // 🔵 الـ index المختار
  final int selectedCategoryIndex;

  final int page;
  final bool hasMore;
  final String? error;

  HomeState({
    required this.status,
    this.products = const [],
    this.categories = const [],
    this.selectedCategoryIndex = 0,
    this.page = 0,
    this.hasMore = true,
    this.error,
  });

  factory HomeState.initial() => HomeState(
    status: HomeStatus.initial,
    categories: const [
      HomeCategory(title: "Chairs"),
      HomeCategory(title: "Tables"),
      HomeCategory(title: "Sofas"),
      HomeCategory(title: "Beds"),
    ],
  );

  HomeState copyWith({
    HomeStatus? status,
    List<ProductModel>? products,
    List<HomeCategory>? categories,
    int? selectedCategoryIndex,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategoryIndex:
      selectedCategoryIndex ?? this.selectedCategoryIndex,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }
}