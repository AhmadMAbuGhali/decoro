part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadProducts extends HomeEvent {
  final int limit;
  LoadProducts({this.limit = 20});
}

class LoadMoreProducts extends HomeEvent {
  final int limit;
  LoadMoreProducts({this.limit = 20});
}

class RefreshProducts extends HomeEvent {
  final int limit;
  RefreshProducts({this.limit = 20});
}

// 🔵 فئة جديدة لاختيار التصنيف
class SelectCategory extends HomeEvent {
  final int index;
  SelectCategory(this.index);
}