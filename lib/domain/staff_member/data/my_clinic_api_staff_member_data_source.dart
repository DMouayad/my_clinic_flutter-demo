import 'package:clinic_v2/api/endpoints/staff_member_endpoints.dart';
import 'package:clinic_v2/shared/models/paginated_api_resource/paginated_api_resource.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

import 'package:clinic_v2/utils/enums.dart';

import '../base/base_staff_member_data_source.dart';
import 'my_clinic_api_staff_member.dart';

class MyClinicApiStaffMemberDataSource
    extends BaseStaffMemberDataSource<MyClinicApiStaffMember> {
  const MyClinicApiStaffMemberDataSource();

  @override
  Future<Result<MyClinicApiStaffMember, AppError>> addStaffMember(
      String email, UserRole userRole) async {
    return (await AddStaffMemberApiEndpoint(
      email: email,
      role: userRole,
    ).request())
        .mapSuccess(
      (result) =>
          MyClinicApiStaffMember.fromApiResponse(result.staffMemberData),
    );
  }

  @override
  Future<Result<VoidValue, AppError>> deleteStaffMember(int id) async {
    return (await DeleteStaffMemberApiEndpoint(id: id).request())
        .mapSuccessToVoid();
  }

  @override
  Future<Result<PaginatedResource<MyClinicApiStaffMember>, AppError>>
      fetchStaffMembers({
    int? page,
    int? perPage,
    List<String>? sortedBy,
  }) async {
    final response = await FetchStaffMembersApiEndpoint(
      page: page,
      perPage: perPage,
      sortedBy: sortedBy,
    ).request();
    return response.mapSuccess((result) {
      return PaginatedResource(
          data: result.staffMembersData
              .map((e) => MyClinicApiStaffMember.fromApiResponse(e))
              .toList(),
          paginationInfo: result.paginationInfo,
          paginationLinks: result.paginationLinks);
    });
  }

  @override
  Future<Result<VoidValue, AppError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]) async {
    return (await UpdateStaffMemberApiEndpoint(
      id: id,
      newEmail: email,
      newRole: userRole,
    ).request())
        .mapSuccessToVoid();
  }
}
