import 'dart:io';

import 'package:clinic_v2/api/endpoints_results/src/empty_endpoint_result.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/models/base_api_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/api/models/base_http_client.dart';
import 'package:clinic_v2/domain/authentication/base/base_auth_tokens_service.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';
import 'package:get_it/get_it.dart';

class ApiEndpointRequestMaker {
  final BaseHttpClient _httpClient;

  const ApiEndpointRequestMaker(this._httpClient);

  BaseAuthTokensService get _authTokensService => GetIt.I.get();

  Future<Result<T, AppError>>
      requestApiEndpoint<T extends BaseApiEndpointResult>(
    ApiEndpoint<T> apiEndpoint,
  ) async {
    if (apiEndpoint.includeAccessToken) {
      final tokenResult = await _authTokensService.getValidAccessToken();
      return await tokenResult.flatMapSuccessAsync((token) async {
        return await _performRequest(apiEndpoint, token);
      });
    } else {
      return await _performRequest(apiEndpoint);
    }
  }

  Future<Result<T, AppError>> _performRequest<T extends BaseApiEndpointResult>(
    ApiEndpoint<T> apiEndpoint, [
    String? accessToken,
  ]) async {
    try {
      Log.logApiEndpointRequest(apiEndpoint);
      final response = await _httpClient.performHttpRequest(
        apiEndpoint: apiEndpoint,
        accessToken: accessToken,
      );
      Log.logHttpResponse(response);
      if (response.isSuccess) {
        if (T is EmptyApiEndpointResult) {
          return SuccessResult.voidResult();
        }
        return apiEndpoint.resultFromJson(response.data);
      } else {
        return FailureResult(ApiResponseError.fromResponse(response.data));
      }
    } on SocketException {
      return FailureResult.withAppException(
        const AppException.noConnectionFound(),
      );
    } on Exception catch (e) {
      Log.e(e);
      return FailureResult.withException(e);
    }
  }
}
