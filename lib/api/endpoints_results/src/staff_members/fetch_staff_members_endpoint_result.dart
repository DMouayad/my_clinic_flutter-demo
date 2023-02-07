import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';
import 'package:clinic_v2/api/models/response_user_data.dart';
import 'package:clinic_v2/shared/models/paginated_api_resource/src/pagination_info.dart';
import 'package:clinic_v2/shared/models/paginated_api_resource/src/resource_pagination_links.dart';

import '../../../models/base_api_endpoint_result.dart';

class FetchStaffMembersEndpointResult extends BaseApiEndpointResult {
  final List<ApiResponseStaffMemberData> staffMembersData;
  final PaginationInfo paginationInfo;
  final ResourcePaginationLinks paginationLinks;

  factory FetchStaffMembersEndpointResult.fromMap(Map<String, dynamic> map) {
    final staffMembersData = (map['data'] as List).map(
      (map) {
        final userDataMap = map['user'] as Map<String, dynamic>?;
        if (userDataMap != null) {
          userDataMap['role'] = map['role'];
        }

        return ApiResponseStaffMemberData(
          id: map['id'] as int,
          roleSlug: map['role']['slug'],
          email: map['email'],
          createdAt: DateTime.parse(map["created_at"]),
          userData: userDataMap != null
              ? ApiResponseUserData.fromMap(userDataMap)
              : null,
        );
      },
    ).toList();

    return FetchStaffMembersEndpointResult(
      staffMembersData,
      PaginationInfo.fromMap(map['meta']),
      ResourcePaginationLinks.fromMap(map['links']),
    );
  }

  const FetchStaffMembersEndpointResult(
      this.staffMembersData, this.paginationInfo, this.paginationLinks);
}
