import 'package:clinic_v2/api/models/response_user_data.dart';

import '../api_endpoint_result.dart';

class FetchStaffEmailsEndpointResult extends ApiEndpointResult {
  final List<ApiResponseStaffEmailData> staffEmailsData;

  factory FetchStaffEmailsEndpointResult.fromApiResponse(dynamic data) {
    final staffEmailsData = (data as List).map(
      (map) {
        final userDataMap = map['user'] as Map<String, dynamic>;
        userDataMap['role'] = map['role'];

        return ApiResponseStaffEmailData(
          id: map['id'] as int,
          roleSlug: map['role']['slug'],
          email: map['email'],
          userData: ApiResponseUserData.fromMap(userDataMap),
        );
      },
    ).toList();

    return FetchStaffEmailsEndpointResult(staffEmailsData);
  }

  const FetchStaffEmailsEndpointResult(this.staffEmailsData);
}

class ApiResponseStaffEmailData {
  final int id;
  final String roleSlug;
  final String email;
  final ApiResponseUserData userData;

  const ApiResponseStaffEmailData({
    required this.id,
    required this.roleSlug,
    required this.email,
    required this.userData,
  });
}
