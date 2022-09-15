import 'error_exception.dart';

class BasicError {
  final String? message;
  final ErrorException? exception;
  final String? description;

  const BasicError({
    this.message,
    this.exception,
    this.description,
  }) : assert(message != null || exception != null || description != null);

  @override
  String toString() {
    return {
      'error': {
        'message': message,
        'exception': exception.toString(),
        'description': description,
      }
    }.toString();
  }
}

abstract class NoError extends BasicError {}
