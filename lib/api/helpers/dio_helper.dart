import 'dart:io';

import 'package:clinic_v2/api/endpoints/api_endpoints.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:dio/dio.dart';

mixin DioHelper {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: ApiKeys.baseUrl,
      headers: {'accept': 'application_json'},
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    );

  void _addBarerToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future<Response> performDioRequest(ApiEndpoint apiEndpoint) async {
    if (apiEndpoint.token != null) _addBarerToken(apiEndpoint.token!);
    switch (apiEndpoint.method) {
      case RequestMethod.POST:
        return _dio.post(apiEndpoint.urlWithoutBaseUrl, data: apiEndpoint.data);
      case RequestMethod.GET:
        return _dio.get(apiEndpoint.urlWithoutBaseUrl);
      case RequestMethod.DELETE:
        return _dio.delete(apiEndpoint.urlWithoutBaseUrl,
            data: apiEndpoint.data);
      case RequestMethod.PUT:
        return _dio.put(apiEndpoint.urlWithoutBaseUrl, data: apiEndpoint.data);
    }
  }
}
