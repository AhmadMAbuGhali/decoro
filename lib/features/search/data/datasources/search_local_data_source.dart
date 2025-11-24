import '../../../../config/constants/asset_paths.dart';
import '../models/search_result_model.dart';

abstract class SearchLocalDataSource {
  Future<List<SearchResultModel>> getSearchResults();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  @override
  Future<List<SearchResultModel>> getSearchResults() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      SearchResultModel(
        id: '1',
        title: 'Arm Chair',
        price: 400,
        image: AssetPaths.chir1,
        category: 'Chair',
      ),
      SearchResultModel(
        id: '2',
        title: 'Office Chair',
        price: 700,
        image: AssetPaths.chir1,
        category: 'Chair',
      ),
      SearchResultModel(
        id: '3',
        title: 'Modern Chair',
        price: 430,
        image: AssetPaths.chir1,
        category: 'Chair',
      ),
      SearchResultModel(
        id: '4',
        title: 'Wooden Chair',
        price: 300,
        image: AssetPaths.chir1,
        category: 'Chair',
      ),
      SearchResultModel(
        id: '4',
        title: 'ahmad Chair',
        price: 788,
        image: AssetPaths.chir1,
        category: 'Chair',
      ),
    ];
  }
}