import 'package:clinic_v2/api/models/api_endpoint_result.dart';
import 'package:clinic_v2/api/helpers/base_api_endpoint_request_maker.dart';
import 'package:clinic_v2/api/helpers/dio_api_endpoint_request_maker.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/api/utils/enums.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

export 'package:clinic_v2/api/utils/enums.dart';

abstract class ApiEndpoint<T extends ApiEndpointResult> {
  final String url;
  final RequestMethod method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final bool includeAccessToken;
  final bool includeDeviceId;

  const ApiEndpoint({
    required this.url,
    required this.method,
    required this.includeAccessToken,
    required this.includeDeviceId,
    this.data,
    this.headers,
  });

  String get fullUrl => ApiKeys.baseUrl + url;

  // the http client that performs http requests to the server
  // all [ApiEndpoint] classes will use this by default
  BaseApiEndpointRequestMaker<T> get _requestMaker =>
      DioApiEndpointRequestMaker();

  Future<Result<T, BasicError>> request() async =>
      await _requestMaker.makeRequest(this);
}
