import 'package:clinic_v2/api/endpoints_results/api_endpoint_result.dart';
import 'package:clinic_v2/api/helpers/base_api_endpoint_request_maker.dart';
import 'package:clinic_v2/api/helpers/dio_api_endpoint_request_maker.dart';
import 'package:clinic_v2/api/utils/enums.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/auth_tokens/auth_tokens_service_provider.dart';

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

  BaseApiEndpointRequestMaker<T> get _requestMaker =>
      DioApiEndpointRequestMaker(AuthTokensServiceProvider.instance.service);
  Future<Result<T, BasicError>> request() async =>
      await _requestMaker.makeRequest(this);
}
