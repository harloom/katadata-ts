class ServerException implements Exception {
  final String errorMessage;
  final int statusCode;

  ServerException(this.errorMessage,this.statusCode);
}

class CacheException implements Exception {}

class SessionExpiredException implements Exception {}

class DatabaseException implements Exception {}
