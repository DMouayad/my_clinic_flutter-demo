import 'package:equatable/equatable.dart';
import 'dart:core';
import 'error_exception.dart';
export 'error_exception.dart';

class BasicError extends Error with EquatableMixin {
  final String? message;
  final ErrorException? exception;
  final String? description;
  late final StackTrace st;
  BasicError({
    this.message,
    this.exception,
    this.description,
  }) : assert(message != null || exception != null || description != null) {
    st = StackTrace.current;
  }

  @override
  String toString() {
    return ''' <$runtimeType>
                 message:     $message 
                 exception:   ${exception?.name} 
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
