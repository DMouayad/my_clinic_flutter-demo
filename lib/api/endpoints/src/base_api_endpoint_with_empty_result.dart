import 'package:clinic_v2/api/endpoints_results/src/empty_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';

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
  EmptyApiEndpointResult resultFromMap(Map<String, dynamic> map) {
    return const EmptyApiEndpointResult();
  }
}
