import 'package:clinic_v2/api/utils/json_response_decoder.dart';
import 'package:clinic_v2/api/models/base_api_endpoint_result.dart';
import 'package:clinic_v2/api/utils/api_keys.dart';
import 'package:clinic_v2/api/utils/enums.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:get_it/get_it.dart';

import '../services/api_endpoint_request_maker.dart';

export 'package:clinic_v2/api/utils/enums.dart';

abstract class ApiEndpoint<T extends BaseApiEndpointResult> {
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

  // Helper service that handles http requests
  ApiEndpointRequestMaker get _requestMaker => GetIt.I.get();

  T resultFromApiResponseMap(dynamic map);

  /// Returns this endpoint specified result from api json response
  Result<T, AppError> resultFromJson(dynamic json) {
    return JsonResponseDecoder.decodeApiResponse(json).mapSuccess(
      (map) => resultFromApiResponseMap(map['data']),
    );
  }

  /// Performs an HTTP request to this endpoint with the specified parameters
  Future<Result<T, AppError>> request() async =>
      await _requestMaker.requestApiEndpoint(this);
}
