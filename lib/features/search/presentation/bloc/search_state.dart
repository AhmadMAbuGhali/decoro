import 'package:equatable/equatable.dart';

import '../../domin/entities/search_result.dart';

class SearchState extends Equatable {
  final List<SearchResult> allResults;
  final List<SearchResult> filteredResults;

  final String? selectedCategory;
  final String? selectedPrice;

  final bool isLoading;

  const SearchState({
    this.allResults = const [],
    this.filteredResults = const [],
    this.selectedCategory,
    this.selectedPrice,
    this.isLoading = false,
  });

  SearchState copyWith({
    List<SearchResult>? allResults,
    List<SearchResult>? filteredResults,
    String? selectedCategory,
    String? selectedPrice,
    bool? isLoading,
  }) {
    return SearchState(
      allResults: allResults ?? this.allResults,
      filteredResults: filteredResults ?? this.filteredResults,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPrice: selectedPrice ?? this.selectedPrice,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [allResults, filteredResults, selectedCategory, selectedPrice, isLoading];
}