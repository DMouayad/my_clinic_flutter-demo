import 'dart:convert';

import 'package:clinic_v2/api/errors/api_exception_class.dart';
import 'package:clinic_v2/app/core/entities/result/basic_error.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';

class ApiResponseError extends BasicError {
  final ApiExceptionClass? apiExceptionClass;
  const ApiResponseError({
    String? message,
    String? description,
    this.apiExceptionClass,
  }) : super(
          message: message,
          description: description,
        );

  static ApiResponseError fromMap(Map<String, dynamic> map) {
    return ApiResponseError(
      message: map.get('message'),
      apiExceptionClass: map.get('exception'),
      description: map.get('description'),
    );
  }

  factory ApiResponseError.fromJson(String json) {
    return fromMap(jsonDecode(json));
  }

  ErrorException get errorException =>
      ErrorException.fromApiException(apiExceptionClass);
}
