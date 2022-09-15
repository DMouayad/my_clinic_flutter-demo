import 'dart:io';

import 'package:clinic_v2/api/endpoints/api_endpoints.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:dio/dio.dart';

mixin ApiRequestHelper on DioHelper {
  Future<Result<R, ApiResponseError>>
      requestApiEndpoint<R extends ApiEndpointResult>(
    ApiEndpoint apiEndpoint,
  ) async {
    try {
      final response = await performDioRequest(apiEndpoint);
      if (response.success) {
        if (response.statusCode == HttpStatus.noContent) {
          return SuccessResult.voidResult();
        }
        return SuccessResult(ApiEndpointResult.fromJson<R>(response.data));
      }
      return ErrorResult(ApiResponseError.fromJson(response.data));
    } on SocketException {
      return ErrorResult.noInternetConnection();
    } on DioError catch (e) {
      return ErrorResult.fromDioError(e);
    } catch (e) {
      return ErrorResult.fromException(e);
    }
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
