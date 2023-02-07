import 'package:clinic_v2/api/models/base_api_endpoint_result.dart';

class EmptyApiEndpointResult extends BaseApiEndpointResult {
  const EmptyApiEndpointResult();

  factory EmptyApiEndpointResult.fromMap(Map<String, dynamic> map) {
    return const EmptyApiEndpointResult();
  }
}
