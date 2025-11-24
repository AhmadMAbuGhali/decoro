import '../entities/search_result.dart';

abstract class SearchRepository {
  /// Search API: returns list of SearchResult for [query].
  Future<List<SearchResult>> search(String query);
}