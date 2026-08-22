class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.code});
}

class CacheException extends AppException {
  CacheException(super.message, {super.code});
}
