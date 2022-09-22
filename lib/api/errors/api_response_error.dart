import 'dart:convert';
import 'dart:io';

import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/app/core/entities/result/basic_error.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';

class ApiResponseError extends BasicError {
  const ApiResponseError({
    String? message,
    String? description,
    ErrorException? errorException,
  }) : super(
          message: message,
          description: description,
          exception: errorException,
        );

  static ApiResponseError fromMap(Map<String, dynamic> map) {
    final errorMap = map['error'] as Map<String, dynamic>;
    final apiExceptionClass = map['error']['exception'] as String?;
    late ErrorException? errorException;

    if (apiExceptionClass != null) {
      errorException = ErrorException.fromApiException(
        ApiExceptionClass.values.firstWhere((c) => c.name == apiExceptionClass),
      );
    } else if (map['status'] == HttpStatus.unauthorized) {
      errorException = const ErrorException.userUnauthorized();
    }
    return ApiResponseError(
      message: errorMap.get('message'),
      errorException: errorException,
      description: errorMap.get('description'),
    );
  }

  factory ApiResponseError.fromJson(String json) {
    return fromMap(jsonDecode(json));
  }
}
