import ' api_result.dart';
import 'api_error.dart';

abstract class BaseRepository {
  Future<ApiResult<T>> guardApi<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiError.parse(e));
    }
  }
}