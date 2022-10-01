import 'dart:io';

import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/app/core/helpers/device_id_helper.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:dio/dio.dart';

mixin DioHelper {
  Dio get _getDioInstance => Dio()
    ..options = BaseOptions(
      validateStatus: (_) => true,
      baseUrl: ApiKeys.baseUrl,
      responseType: ResponseType.json,
      headers: {'accept': 'application/json'},
      contentType: ContentType.json.toString(),
    );

  void _addBarerToken(Dio dio, String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  void _addAdditionalHeaders(Dio dio, Map<String, dynamic>? headers) {
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
  }

  Future<FormData?> _getEndpointData(ApiEndpoint apiEndpoint) async {
    Map<String, dynamic>? data = apiEndpoint.data;
    if (apiEndpoint.includeDeviceId) {
      data ??= {};
      data['device_id'] = await DeviceIdHelper.get;
    }
    return data != null ? FormData.fromMap(data) : null;
  }

  Future<Response> performDioRequest({
    required ApiEndpoint apiEndpoint,
    String? accessToken,
  }) async {
    final Dio dio = _getDioInstance;
    if (accessToken != null) _addBarerToken(dio, accessToken);

    final formData = await _getEndpointData(apiEndpoint);
    _addAdditionalHeaders(dio, apiEndpoint.headers);

    dio.options.method = apiEndpoint.method.name;
    Log.logDioRequest(dio, apiEndpoint);
    return dio.request(
      apiEndpoint.url,
      data: formData,
    );
    // switch (apiEndpoint.method) {
    //   case RequestMethod.POST:
    //     return dio.post(
    //       apiEndpoint.url,
    //       data: formData,
    //     );
    //   case RequestMethod.GET:
    //     return dio.get(apiEndpoint.url);
    //   case RequestMethod.DELETE:
    //     return dio.delete(
    //       apiEndpoint.url,
    //       data: formData,
    //     );
    //   case RequestMethod.PUT:
    //     return dio.put(
    //       apiEndpoint.url,
    //       data: formData,
    //     );
    // }
  }
}
