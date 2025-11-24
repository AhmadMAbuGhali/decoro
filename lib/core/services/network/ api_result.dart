class ApiResult<T> {
  final T? data;
  final String? error;

  const ApiResult._({this.data, this.error});

  factory ApiResult.success(T data) =>
      ApiResult._(data: data, error: null);

  factory ApiResult.failure(String error) =>
      ApiResult._(data: null, error: error);

  bool get isSuccess => error == null;
}