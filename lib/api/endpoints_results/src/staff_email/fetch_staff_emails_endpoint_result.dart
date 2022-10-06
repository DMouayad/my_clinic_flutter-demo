import 'package:clinic_v2/api/models/response_user_data.dart';
import 'package:clinic_v2/api/models/staff_email_response_data.dart';

import '../../../models/api_endpoint_result.dart';

class FetchStaffEmailsEndpointResult extends ApiEndpointResult {
  final List<ApiResponseStaffEmailData> staffEmailsData;

  factory FetchStaffEmailsEndpointResult.fromApiResponse(dynamic data) {
    final staffEmailsData = (data as List).map(
      (map) {
        final userDataMap = map['user'] as Map<String, dynamic>?;
        if (userDataMap != null) {
          userDataMap['role'] = map['role'];
        }

        return ApiResponseStaffEmailData(
          id: map['id'] as int,
          roleSlug: map['role']['slug'],
          email: map['email'],
          userData: userDataMap != null
              ? ApiResponseUserData.fromMap(userDataMap)
              : null,
        );
      },
    ).toList();

    return FetchStaffEmailsEndpointResult(staffEmailsData);
  }

  const FetchStaffEmailsEndpointResult(this.staffEmailsData);
}