import 'dart:convert';

import 'package:clinic_v2/shared/services/logger_service.dart';

import '../../shared/models/result/result.dart';

mixin JsonResponseDecoder {
  /// Parses json input and returns the result of this process:
  ///
  /// - [SuccessResult] with the response data (which is, usually, stored in
  ///   the `data` key of the decoded map from json).
  /// - [FailureResult] with the error that occurred when parsing json.
  ///
  static Result<Map<String, dynamic>, AppError> decodeApiResponse(
      dynamic json) {
    if (json is String && json.isNotEmpty) {
      try {
        json = jsonDecode(json);
      } on FormatException catch (e) {
        return FailureResult.withException(e);
      }
    }
    if (json is Map<String, dynamic> && json.containsKey('data')) {
      return SuccessResult((json));
    } else {
      Log.e(
        "expected json to be a Map but instead got "
        "${json.runtimeType}",
      );
      return FailureResult.withAppException(
        AppException.decodingJsonFailed,
      );
    }
  }
}
