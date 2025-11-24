import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';
import '../../data/repositories/product_repository_impl.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepositoryImpl repo;
  static const int _limit = 12;

  ProductListBloc({required this.repo}) : super(const ProductListState()) {
    on<LoadProducts>(_onLoad);
    on<LoadMoreProducts>(_onLoadMore);
  }

  Future<void> _onLoad(LoadProducts event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(isLoading: true, hasError: false, errorMessage: null));
    try {
      final page = 1; // دايمًا 1 عند أول تحميل
      final list = await repo.getProducts(page: page, limit: _limit);

      emit(state.copyWith(
        products: list,
        isLoading: false,
        page: 1,
        hasMore: list.length >= _limit,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMore(LoadMoreProducts event, Emitter<ProductListState> emit) async {
    if (state.isLoading || !state.hasMore) return;

    final next = state.page + 1;
    emit(state.copyWith(isLoading: true));

    try {
      final list = await repo.getProducts(page: next, limit: _limit);

      final combined = [...state.products, ...list];

      emit(state.copyWith(
        products: combined,
        isLoading: false,
        page: next,
        hasMore: list.length >= _limit,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      ));
    }
  }
}