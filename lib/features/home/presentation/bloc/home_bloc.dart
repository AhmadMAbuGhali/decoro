import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../data/models/home_category.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository repo;

  HomeBloc(this.repo) : super(HomeState.initial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMore);
    on<RefreshProducts>(_onRefresh);

    // 🔵 اختيار فئة
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadProducts(LoadProducts e, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final list = await repo.getProducts(page: 1, limit: e.limit);
      emit(state.copyWith(
        status: HomeStatus.success,
        products: list,
        page: 1,
        hasMore: list.length == e.limit,
      ));
    } catch (err) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: err.toString(),
      ));
    }
  }

  Future<void> _onLoadMore(LoadMoreProducts e, Emitter<HomeState> emit) async {
    if (!state.hasMore || state.status == HomeStatus.loadingMore) return;

    emit(state.copyWith(status: HomeStatus.loadingMore));
    try {
      final next = state.page + 1;
      final list = await repo.getProducts(page: next, limit: e.limit);
      final all = [...state.products, ...list];
      emit(state.copyWith(
        status: HomeStatus.success,
        products: all,
        page: next,
        hasMore: list.length == e.limit,
      ));
    } catch (err) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: err.toString(),
      ));
    }
  }

  Future<void> _onRefresh(RefreshProducts e, Emitter<HomeState> emit) async {
    try {
      final list = await repo.getProducts(page: 1, limit: e.limit);
      emit(state.copyWith(
        status: HomeStatus.success,
        products: list,
        page: 1,
        hasMore: list.length == e.limit,
      ));
    } catch (err) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: err.toString(),
      ));
    }
  }

  // 🔵 اختيار فئة
  Future<void> _onSelectCategory(
      SelectCategory e, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedCategoryIndex: e.index));
  }
}