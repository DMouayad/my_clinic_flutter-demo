import 'dart:io';

import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/api/models/base_http_client.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';
import 'package:clinic_v2/utils/helpers/device_id_helper.dart';
import 'package:dio/dio.dart';

class DioHttpClient extends BaseHttpClient {
  DioHttpClient() {
    _dioInstance = Dio()
      ..options = BaseOptions(
        validateStatus: (_) => true,
        baseUrl: ApiKeys.baseUrl,
        responseType: ResponseType.json,
        // connectTimeout: 5000,
        headers: {'accept': 'application/json'},
        contentType: ContentType.json.toString(),
      );
  }

  late final Dio _dioInstance;

  void _addBearerToken(Dio dio, String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  void _addAdditionalHeaders(Dio dio, Map<String, dynamic>? headers) {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
  }

  Future<Map<String, dynamic>?> _getEndpointData(
      ApiEndpoint apiEndpoint) async {
    Map<String, dynamic>? data = apiEndpoint.data;
    if (apiEndpoint.includeDeviceId) {
      data ??= {};
      data['device_id'] = await DeviceIdHelper.get;
    }
    return data;
  }

  @override
  Future<DioClientResponse> performHttpRequest({
    required ApiEndpoint apiEndpoint,
    String? accessToken,
  }) async {
    if (accessToken != null) _addBearerToken(_dioInstance, accessToken);

    final data = await _getEndpointData(apiEndpoint);
    _addAdditionalHeaders(_dioInstance, apiEndpoint.headers);

    _dioInstance.options.method = apiEndpoint.method.name;
    Log.logDioRequest(_dioInstance, apiEndpoint);
    return _dioInstance
        .request(
          apiEndpoint.url,
          data: data,
        )
        .then((response) => DioClientResponse(
              requestOptions: response.requestOptions,
              statusCode: response.statusCode,
              data: response.data,
              statusMessage: response.statusMessage,
              headers: response.headers,
              extra: response.extra,
              redirects: response.redirects,
              isRedirect: response.isRedirect,
            ));
  }
}

class DioClientResponse extends Response implements BaseHttpClientResponse {
  DioClientResponse({
    super.data,
    super.headers,
    super.statusCode,
    super.statusMessage,
    super.extra,
    super.isRedirect,
    super.redirects,
    required super.requestOptions,
  });

  @override
  Uri get uri => realUri;
}
