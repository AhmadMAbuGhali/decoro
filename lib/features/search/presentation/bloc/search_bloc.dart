import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/search_result.dart';
import '../../domin/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc(this.repository) : super(const SearchState()) {
    on<LoadSearchResults>(_load);
    on<SearchQueryChanged>(_search);
    on<ApplyFilters>(_applyFilters);
    on<ResetFilters>(_resetFilters);
  }

  Future<void> _load(LoadSearchResults event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final results = await repository.search(event.query);
      emit(state.copyWith(
        allResults: results,
        filteredResults: results,
        isLoading: false,
      ));
    } catch (e) {
      // keep it simple — return empty results on error
      emit(state.copyWith(isLoading: false, allResults: [], filteredResults: []));
    }
  }

  Future<void> _search(SearchQueryChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final results = await repository.search(event.query);
      emit(state.copyWith(
        allResults: results,
        filteredResults: results,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _applyFilters(ApplyFilters event, Emitter<SearchState> emit) {
    List<SearchResult> filtered = state.allResults;

    if (event.category != null) {
      filtered = filtered.where((e) => e.category == event.category).toList();
    }

    if (event.price != null) {
      if (event.price == "Under \$500") {
        filtered = filtered.where((e) => e.price < 500).toList();
      } else {
        filtered = filtered.where((e) => e.price > 500).toList();
      }
    }

    emit(state.copyWith(
      filteredResults: filtered,
      selectedCategory: event.category,
      selectedPrice: event.price,
    ));
  }

  void _resetFilters(ResetFilters event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      filteredResults: state.allResults,
      selectedCategory: null,
      selectedPrice: null,
    ));
  }
}