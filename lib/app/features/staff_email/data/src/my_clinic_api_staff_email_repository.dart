import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';

import 'my_clinic_api_staff_email.dart';
import 'my_clinic_api_staff_email_data_source.dart';

class MyClinicApiStaffEmailRepository extends BaseStaffEmailRepository {
  MyClinicApiStaffEmailRepository() {
    _dataSource = const MyClinicApiStaffEmailDataSource();
  }

  late final MyClinicApiStaffEmailDataSource _dataSource;

  List<MyClinicApiStaffEmail>? _staffEmails;

  @override
  List<MyClinicApiStaffEmail>? get staffEmails => _staffEmails;

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
  Future<Result<VoidValue, BasicError>> getStaffEmails() async {
    return (await _dataSource.fetchStaffEmails()).mapSuccessToVoid(
      (result) => _staffEmails = result,
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
      {required int id, String? email, UserRole? userRole}) {
    // TODO: implement updateStaffEmail
    throw UnimplementedError();
  }
}
