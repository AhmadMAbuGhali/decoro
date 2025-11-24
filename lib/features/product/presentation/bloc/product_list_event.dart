import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductListEvent {
  final bool refresh;
  LoadProducts({this.refresh = false});
}

class LoadMoreProducts extends ProductListEvent {}