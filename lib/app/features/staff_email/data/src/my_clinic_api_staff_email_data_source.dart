import 'package:clinic_v2/api/endpoints/staff_email_endpoints.dart';
import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

import 'package:clinic_v2/app/core/enums.dart';

import 'my_clinic_api_staff_email.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';

class MyClinicApiStaffEmailDataSource
    extends BaseStaffEmailDataSource<MyClinicApiStaffEmail> {
  const MyClinicApiStaffEmailDataSource();

  @override
  Future<Result<MyClinicApiStaffEmail, BasicError>> addStaffEmail(
      String email, UserRole userRole) async {
    return (await AddStaffEmailApiEndpoint(
      email: email,
      role: userRole,
    ).request())
        .mapSuccess(
      (result) => MyClinicApiStaffEmail.fromApiResponse(result.staffEmailData),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id) async {
    return (await DeleteStaffEmailApiEndpoint(staffEmailId: id).request())
        .mapSuccessToVoid();
  }

  @override
  Future<Result<PaginatedResource<MyClinicApiStaffEmail>, BasicError>>
      fetchStaffEmails([int? page]) async {
    final response = await FetchStaffEmailsApiEndpoint(page).request();
    return response.mapSuccess((result) {
      return PaginatedResource(
          data: result.staffEmailsData
              .map((e) => MyClinicApiStaffEmail.fromApiResponse(e))
              .toList(),
          paginationInfo: result.paginationInfo,
          paginationLinks: result.paginationLinks);
    });
  }

  @override
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
    int id, [
    String? email,
    UserRole? userRole,
  ]) async {
    return (await UpdateStaffEmailApiEndpoint(
      staffEmailId: id,
      newEmail: email,
      newRole: userRole,
    ).request())
        .mapSuccessToVoid();
  }
}
