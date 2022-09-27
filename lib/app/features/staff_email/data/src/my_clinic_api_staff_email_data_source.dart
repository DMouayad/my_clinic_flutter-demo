import 'package:clinic_v2/api/endpoints/staff_email_endpoints.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

import 'package:clinic_v2/app/core/enums.dart';

import 'my_clinic_api_staff_email.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';

class MyClinicApiStaffEmailDataSource
    extends BaseStaffEmailDataSource<MyClinicApiStaffEmail> {
  const MyClinicApiStaffEmailDataSource();

  @override
  Future<Result<VoidValue, BasicError>> addStaffEmail(
      String email, UserRole userRole) {
    // TODO: implement addStaffEmail
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id) {
    // TODO: implement deleteStaffEmail
    throw UnimplementedError();
  }

  @override
  Future<Result<List<MyClinicApiStaffEmail>, BasicError>>
      fetchStaffEmails() async {
    final response = await FetchStaffEmailsApiEndpoint().request();
    return response.mapSuccess((result) {
      return result.staffEmailsData
          .map((e) => MyClinicApiStaffEmail.fromApiResponse(e))
          .toList();
    });
  }

  @override
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
      {required int id, String? email, UserRole? userRole}) {
    // TODO: implement updateStaffEmail
    throw UnimplementedError();
  }
}
