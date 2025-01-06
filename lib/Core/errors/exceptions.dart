abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => 'AppException: $message';
}

class ServerException extends AppException {
  ServerException(super.message, {super.statusCode});
}

class CacheException extends AppException {
  CacheException(super.message);
}
