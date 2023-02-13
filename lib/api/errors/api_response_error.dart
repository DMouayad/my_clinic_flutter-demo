import 'dart:io';

import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/utils/extensions/map_extensions.dart';

class ApiResponseError extends AppError {
  ApiResponseError({
    String? message,
    String? description,
    AppException? appException,
  }) : super(
          message: message,
          description: description,
          appException: appException,
        );

  static ApiResponseError fromResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      final errorMap = response.get('error') as Map<String, dynamic>?;
      AppException? appException = _getExceptionClass(
        apiExceptionClass: errorMap?['exception'] as String?,
        status: response.get('status'),
      );

      return ApiResponseError(
        message: errorMap?.get('message') ??
            response.get('message') ??
            "Unknown error happened",
        appException: appException,
        description: errorMap?.get('description'),
      );
    }
    return ApiResponseError(message: 'Unexpected error');
  }

  static AppException? _getExceptionClass({
    required String? apiExceptionClass,
    required int status,
  }) {
    if (apiExceptionClass != null) {
      return AppException.fromApiException(
        ApiExceptionClass.values.firstWhere(
            (c) => c.exceptionClass == apiExceptionClass, orElse: () {
          throw UnimplementedError(
              'no ApiExceptionClass was found for $apiExceptionClass');
        }),
      );
    } else if (status == HttpStatus.unauthorized) {
      return AppException.userUnauthorized;
    }
    return null;
  }
}
