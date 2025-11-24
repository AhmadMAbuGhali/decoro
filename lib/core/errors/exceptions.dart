/// Base app exception
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Thrown when server returns error codes 500/400 with message.
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Thrown when there is no internet connection.
class NetworkException extends AppException {
  const NetworkException() : super("No Internet Connection");
}

/// Thrown when parsing / unexpected issues happen.
class UnknownException extends AppException {
  const UnknownException([String message = "Unknown error"]) : super(message);
}