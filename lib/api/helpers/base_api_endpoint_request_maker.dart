import 'package:clinic_v2/api/endpoints_results/api_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseApiEndpointRequestMaker<T extends ApiEndpointResult> {
  Future<Result<T, BasicError>> makeRequest(ApiEndpoint<T> apiEndpoint);
}
