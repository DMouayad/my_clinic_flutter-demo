import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';
import 'package:clinic_v2/api/models/response_user_data.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/pagination_info.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/resource_pagination_links.dart';

import '../../../models/api_endpoint_result.dart';

class FetchStaffMembersEndpointResult extends ApiEndpointResult {
  final List<ApiResponseStaffMemberData> staffMembersData;
  final PaginationInfo paginationInfo;
  final ResourcePaginationLinks paginationLinks;

  factory FetchStaffMembersEndpointResult.fromApiResponse(
      Map<String, dynamic> response) {
    final staffMembersData = (response['data'] as List).map(
      (map) {
        final userDataMap = map['user'] as Map<String, dynamic>?;
        if (userDataMap != null) {
          userDataMap['role'] = map['role'];
        }

        return ApiResponseStaffMemberData(
          id: map['id'] as int,
          roleSlug: map['role']['slug'],
          email: map['email'],
          userData: userDataMap != null
              ? ApiResponseUserData.fromMap(userDataMap)
              : null,
        );
      },
    ).toList();

    return FetchStaffMembersEndpointResult(
      staffMembersData,
      PaginationInfo.fromMap(response['meta']),
      ResourcePaginationLinks.fromMap(response['links']),
    );
  }

  const FetchStaffMembersEndpointResult(
      this.staffMembersData, this.paginationInfo, this.paginationLinks);
}
