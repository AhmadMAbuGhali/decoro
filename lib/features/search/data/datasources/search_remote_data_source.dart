import 'package:decoro/core/services/network/api_client.dart';
import '../models/search_result_model.dart';

class SearchRemoteDataSource {
  final ApiClient client;

  SearchRemoteDataSource(this.client);

  /// Calls API to search products.
  /// Uses query param 'q' by default. Change path if API different.
  Future<List<SearchResultModel>> search(String query) async {
    final res = await client.get('/products', query: {'q': query});
    // ApiClient returns Map<String, dynamic> or {'data': ...}
    final data = res['data'] ?? res;

    // if the endpoint returns wrapper { data: [ ... ] } or { products: [...] }
    List items = [];
    if (data is List) {
      items = data;
    } else if (data is Map && data['products'] is List) {
      items = data['products'] as List;
    } else if (data is Map && data['results'] is List) {
      items = data['results'] as List;
    }

    return items.map((e) => SearchResultModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}