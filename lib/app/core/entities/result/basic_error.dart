import 'package:equatable/equatable.dart';

import 'error_exception.dart';

class BasicError extends Equatable {
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
    return ''' <$runtimeType>
                 message: $message 
                 exception: ${exception?.name} 
                 description: $description ''';
  }

  @override
  List<Object?> get props => [message, description, exception];

  BasicError copyWith({
    String? message,
    ErrorException? exception,
    String? description,
  }) {
    return BasicError(
      message: message ?? this.message,
      exception: exception ?? this.exception,
      description: description ?? this.description,
    );
  }
}

abstract class NoError extends BasicError {}
