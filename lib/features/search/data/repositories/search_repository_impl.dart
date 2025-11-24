
import '../../domin/entities/search_result.dart';
import '../../domin/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';
import '../models/search_result_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remote;

  SearchRepositoryImpl(this.remote);

  @override
  Future<List<SearchResult>> search(String query) async {
    final models = await remote.search(query);
    return models.map((m) => m.toEntity()).toList();
  }
}