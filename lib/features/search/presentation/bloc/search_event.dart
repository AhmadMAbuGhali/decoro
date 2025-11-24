import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSearchResults extends SearchEvent {
  final String query;
  LoadSearchResults({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ApplyFilters extends SearchEvent {
  final String? category;
  final String? price;

  ApplyFilters({this.category, this.price});

  @override
  List<Object?> get props => [category, price];
}

class ResetFilters extends SearchEvent {}