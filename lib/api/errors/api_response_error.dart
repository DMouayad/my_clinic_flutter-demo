import 'dart:convert';
import 'dart:io';

import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/app/core/entities/result/basic_error.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/services/logger_service.dart';

class ApiResponseError extends BasicError {
  ApiResponseError({
    String? message,
    String? description,
    ErrorException? errorException,
  }) : super(
          message: message,
          description: description,
          exception: errorException,
        );

  static ApiResponseError fromResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      final errorMap = response.get('error') as Map<String, dynamic>?;
      final apiExceptionClass = errorMap?['exception'] as String?;
      ErrorException? errorException;

      if (apiExceptionClass != null) {
        errorException = ErrorException.fromApiException(
          ApiExceptionClass.values
              .firstWhere((c) => c.name == apiExceptionClass),
        );
      } else if (response.get('status') == HttpStatus.unauthorized) {
        errorException = const ErrorException.userUnauthorized();
      }
      return ApiResponseError(
        message: errorMap?.get('message') ?? response.get('message'),
        errorException: errorException,
        description: errorMap?.get('description'),
      );
    }
    return ApiResponseError(message: 'Unexpected error');
  }
}
