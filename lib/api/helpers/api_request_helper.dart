import 'dart:io';

import 'package:clinic_v2/api/endpoints/api_endpoint.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/extensions/dio_extension.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:dio/dio.dart';

mixin ApiRequestHelper on DioHelper {
  Future<Result<R, BasicError>> requestApiEndpoint<R extends ApiEndpointResult>(
    ApiEndpoint apiEndpoint,
  ) async {
    try {
      final response = await performDioRequest(apiEndpoint);
      Log.logDioApiEndpointRequest(apiEndpoint, response);
      if (response.isSuccess) {
        return SuccessResult(ApiEndpointResult.fromJson<R>(response.data));
      }

      return ErrorResult(ApiResponseError.fromMap(response.data));
    } on SocketException {
      return ErrorResult.fromErrorException(ErrorException.noConnectionFound());
    } on DioError catch (e) {
      return ErrorResult.fromDioError(e);
    } on Exception catch (e) {
      return ErrorResult.fromException(e);
    }
  }
}
