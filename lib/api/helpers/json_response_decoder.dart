import 'dart:convert';

import 'package:clinic_v2/shared/services/logger_service.dart';

import '../../shared/models/result/result.dart';

mixin JsonResponseDecoder {
  static Result<Map<String, dynamic>, AppError> decode(dynamic json) {
    if (json is String && json.isNotEmpty) {
      try {
        json = jsonDecode(json);
      } on FormatException catch (e) {
        return FailureResult.withException(e);
      }
    }
    if (json is Map<String, dynamic> && json.containsKey('data')) {
      return SuccessResult((json['data'] as Map<String, dynamic>));
    } else {
      Log.e(
        "Could not decode json which was of type"
        "${json.runtimeType}",
      );
      return FailureResult.withAppException(
        AppException.decodingJsonFailed,
      );
    }
  }
}
