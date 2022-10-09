import 'package:clinic_v2/api/models/response_user_data.dart';
import 'package:clinic_v2/api/models/staff_email_response_data.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/pagination_info.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/resource_pagination_links.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

import '../../../models/api_endpoint_result.dart';

class FetchStaffEmailsEndpointResult extends ApiEndpointResult {
  final List<ApiResponseStaffEmailData> staffEmailsData;
  final PaginationInfo paginationInfo;
  final ResourcePaginationLinks paginationLinks;

  factory FetchStaffEmailsEndpointResult.fromApiResponse(
      Map<String, dynamic> response) {
    final staffEmailsData = (response['data'] as List).map(
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

    return FetchStaffEmailsEndpointResult(
      staffEmailsData,
      PaginationInfo.fromMap(response['meta']),
      ResourcePaginationLinks.fromMap(response['links']),
    );
  }

  const FetchStaffEmailsEndpointResult(
      this.staffEmailsData, this.paginationInfo, this.paginationLinks);
}
