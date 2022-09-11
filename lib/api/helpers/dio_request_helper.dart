import 'dart:convert';
import 'dart:io';

import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:dio/dio.dart';

mixin DioRequestHelper {
  Future<Result<JsonResult, BaseError>> handleRequest(
      Future<Response> call) async {
    try {
      return _getResponseResult(await call);
    } on SocketException {
      return ErrorResult.noInternetConnection();
    } on DioError catch (e) {
      return ErrorResult.fromDioError(e);
    } catch (e) {
      return ErrorResult.fromException(e);
    }
  }

  Result<JsonResult, BaseError> _getResponseResult(Response response) {
    if (response.success) {
      if (response.statusCode! == HttpStatus.noContent) {
        return SuccessResult.voidResult();
      }

      return SuccessResult.withJsonResult(response.data);
    }
    return ErrorResult(_getErrorFromResponse(response));
  }

  BaseError _getErrorFromResponse(Response response) {
    final errorMap = jsonDecode(response.data['data']) as Map<String, dynamic>;
    for (String key in ApiKeys.errorJsonKeys) {}
    final message =
        _errorKeyExists(errorMap, 'message') ? errorMap['message'] : null;
    final type =
        _errorKeyExists(errorMap, 'exception') ? errorMap['exception'] : null;
    final description = _errorKeyExists(errorMap, 'description')
        ? errorMap['description']
        : null;
    return BaseError(message: message, type: type, description: description);
  }

  bool _errorKeyExists(Map<String, dynamic> json, String key) {
    return json.containsKey(key) && ApiKeys.errorJsonKeys.contains(key);
  }
}

extension IsSuccess on Response {
  bool get success {
    if (statusCode != null) {
      return (statusCode! ~/ 100) == 2;
    }
    return false;
  }
}
