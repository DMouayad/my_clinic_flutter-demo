import 'error_code.dart';

class BaseError {
  final String? message;
  final String? type;
  final ErrorCode? code;
  final String? description;
  const BaseError({
    this.message,
    this.code,
    this.type,
    this.description,
  }) : assert(message != null || code != null);

  @override
  String toString() {
    return {
      'error': {
        'message': message,
        'type': type,
        'code': code.toString(),
        'description': description,
      }
    }.toString();
  }
}

abstract class NoError extends BaseError {}
