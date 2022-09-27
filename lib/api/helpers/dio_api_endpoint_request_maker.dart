import 'package:dio/dio.dart';
import 'dart:io';
//
import 'package:clinic_v2/api/endpoints_results/api_endpoint_result.dart';
import 'package:clinic_v2/api/errors/api_response_error.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/extensions/dio_extension.dart';
import 'package:clinic_v2/app/services/auth_tokens/auth_tokens_service_provider.dart';
import 'package:clinic_v2/app/services/logger_service.dart';

import '../helpers/base_api_endpoint_request_maker.dart';

class DioApiEndpointRequestMaker<T extends ApiEndpointResult>
    with DioHelper
    implements BaseApiEndpointRequestMaker<T> {
  @override
  Future<Result<T, BasicError>> makeRequest(ApiEndpoint apiEndpoint) async {
    String? accessToken;
    if (apiEndpoint.includeAccessToken) {
      final tokenResult = await AuthTokensServiceProvider.instance.service
          .getValidAccessToken();
      return await tokenResult.foldAsync(ifSuccess: (token) async {
        return await _performRequest(apiEndpoint, accessToken);
      });
    } else {
      return await _performRequest(apiEndpoint, accessToken);
    }
  }

  Future<Result<T, BasicError>> _performRequest(
    ApiEndpoint apiEndpoint,
    String? accessToken,
  ) async {
    try {
      final response = await performDioRequest(
        apiEndpoint: apiEndpoint,
        accessToken: accessToken,
      );

      Log.logDioApiEndpointRequest(apiEndpoint, response);

      if (response.isSuccess) {
        return SuccessResult(ApiEndpointResult.fromJson<T>(response.data));
      }

      return ErrorResult(ApiResponseError.fromMap(response.data));
    } on SocketException {
      return ErrorResult.fromErrorException(
        const ErrorException.noConnectionFound(),
      );
    } on DioError catch (e) {
      return ErrorResult.fromDioError(e);
    } on Exception catch (e) {
      return ErrorResult.fromException(e);
    }
  }
}
