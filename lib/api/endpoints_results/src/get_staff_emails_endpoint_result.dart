import '../api_endpoint_result.dart';

class GetStaffEmailsEndpointResult extends ApiEndpointResult {
  final List<Map<String, dynamic>> staffEmailsData;

  const GetStaffEmailsEndpointResult(this.staffEmailsData);
  factory GetStaffEmailsEndpointResult.fromApiResponse(dynamic data) {
    final staffEmailsData = (data as List)
        .map((e) => {
              'id': e['id'] as int,
              'email': e['email'] as String,
              'user': e['user'] as Map<String, dynamic>,
              'role': e['role'] as Map<String, dynamic>,
            })
        .toList();

    return GetStaffEmailsEndpointResult(staffEmailsData);
  }
}
