import 'package:clinic_v2/api/endpoints_results/src/empty_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

abstract class ApiEndpointWithEmptyResult
    extends ApiEndpoint<EmptyApiEndpointResult> {
  ApiEndpointWithEmptyResult({
    required super.url,
    required super.method,
    required super.includeAccessToken,
    required super.includeDeviceId,
    super.data,
    super.headers,
  });

  @override
  Result<EmptyApiEndpointResult, AppError> resultFromJson(json) {
    // since the result of this endpoint is empty (204 status code),
    // no decoding of the response body IS REQUIRED.
    return SuccessResult(resultFromApiResponseMap(json));
  }

  @override
  EmptyApiEndpointResult resultFromApiResponseMap(map) {
    return const EmptyApiEndpointResult();
  }
}
