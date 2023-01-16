import 'package:clinic_v2/api/models/api_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_endpoint.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

abstract class BaseApiEndpointRequestMaker<T extends ApiEndpointResult> {
  Future<Result<T, BasicError>> makeRequest(ApiEndpoint<T> apiEndpoint);
}
