import 'package:clinic_v2/domain/authentication/base/base_auth_tokens_service.dart';
import 'package:dio/dio.dart';
import 'dart:io';
//
import 'package:clinic_v2/api/models/api_endpoint_result.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/extensions/dio_extension.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';

import 'base_api_endpoint_request_maker.dart';

class DioApiEndpointRequestMaker<T extends ApiEndpointResult>
    with DioHelper
    implements BaseApiEndpointRequestMaker<T> {
  final BaseAuthTokensService _authTokensService;
  DioApiEndpointRequestMaker(this._authTokensService);

  @override
  Future<Result<T, BasicError>> makeRequest(ApiEndpoint apiEndpoint) async {
    if (apiEndpoint.includeAccessToken) {
      final tokenResult = await _authTokensService.getValidAccessToken();
      return await tokenResult.flatMapSuccessAsync((token) async {
        return await _performRequest(apiEndpoint, token);
      });
    } else {
      return await _performRequest(apiEndpoint);
    }
  }

  Future<Result<T, BasicError>> _performRequest(
    ApiEndpoint apiEndpoint, [
    String? accessToken,
  ]) async {
    try {
      Log.logApiEndpointRequest(apiEndpoint);
      final response = await performDioRequest(
        apiEndpoint: apiEndpoint,
        accessToken: accessToken,
      );
      Log.logDioResponse(response);
      if (response.isSuccess) {
        if (T is EmptyApiEndpointResult) {
          return SuccessResult.voidResult();
        }
        return SuccessResult(ApiEndpointResult.fromJson<T>(response.data));
      } else {
        return FailureResult(ApiResponseError.fromResponse(response.data));
      }
    } on SocketException {
      return FailureResult.fromErrorException(
        const ErrorException.noConnectionFound(),
      );
    } on DioError catch (e) {
      Log.e(e);
      return FailureResult.fromDioError(e);
    } on Exception catch (e) {
      Log.e(e);
      return FailureResult.fromException(e);
    }
  }
}
