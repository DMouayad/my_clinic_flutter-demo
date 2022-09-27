import '../api_endpoint_result.dart';

class FetchStaffEmailsEndpointResult extends ApiEndpointResult {
  final List<Map<String, dynamic>> staffEmailsData;

  const FetchStaffEmailsEndpointResult(this.staffEmailsData);
  factory FetchStaffEmailsEndpointResult.fromApiResponse(dynamic data) {
    final staffEmailsData = (data as List)
        .map((e) => {
              'id': e['id'] as int,
              'email': e['email'] as String,
              'user': e['user'] as Map<String, dynamic>,
              'role': e['role'] as Map<String, dynamic>,
            })
        .toList();

    return FetchStaffEmailsEndpointResult(staffEmailsData);
  }
}
