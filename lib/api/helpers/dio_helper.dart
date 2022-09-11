import 'dart:_http';

import 'package:clinic_v2/api/exceptions/bearer_token_not_found_exception.dart';
import 'package:clinic_v2/api/helpers/auth_token_provider.dart';
import 'package:clinic_v2/api/utils/api_endpoints.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:dio/dio.dart';

mixin ProvidesAuthToken {
  late final BaseAuthTokenProvider tokenProvider;
}
mixin DioHelper implements ProvidesAuthToken {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: ApiKeys.baseUrl,
      headers: {'accept': 'application_json'},
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    );

  Future<void> _addBarerToken() async {
    final getTokenResult = await tokenProvider.getToken();
    getTokenResult.when(
      onSuccess: (token) {
        _dio.options.headers["Authorization"] = "Bearer $token";
      },
      onError: (e) =>
          throw BearerTokenNotFoundException(tokenProvider.tokenKey),
    );
  }

  Result<Future<Response>, BaseError> _performRequest(
    Future<Response> request,
    bool requiresToken,
  ) {
    try {
      if (requiresToken) _addBarerToken();
      return SuccessResult(request);
    } on BearerTokenNotFoundException catch (e) {
      return ErrorResult.fromException(e);
    }
  }

  Result<Future<Response>, BaseError> get(ApiEndpoint endpoint) {
    return _performRequest(_dio.get(endpoint.url), endpoint.requiresToken);
  }

  Result<Future<Response>, BaseError> post(ApiEndpoint endpoint) {
    return _performRequest(_dio.post(endpoint.url), endpoint.requiresToken);
  }

  Result<Future<Response>, BaseError> put(ApiEndpoint endpoint) {
    return _performRequest(_dio.put(endpoint.url), endpoint.requiresToken);
  }

  Result<Future<Response>, BaseError> delete(ApiEndpoint endpoint) {
    return _performRequest(_dio.delete(endpoint.url), endpoint.requiresToken);
  }
}
