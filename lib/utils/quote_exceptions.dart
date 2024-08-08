class AppException implements Exception {
  final String message;
  final String prefix;

  AppException([this.message = '', this.prefix = '']);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message = '']) : super(message, 'Error During Communication: ');
}