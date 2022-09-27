import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';

import 'my_clinic_api_staff_email.dart';
import 'my_clinic_api_staff_email_data_source.dart';

class MyClinicApiStaffEmailRepository extends BaseStaffEmailRepository {
  MyClinicApiStaffEmailRepository(BaseAuthTokensService authTokensService) {
    _dataSource = MyClinicApiStaffEmailDataSource(authTokensService);
  }

  late final MyClinicApiStaffEmailDataSource _dataSource;

  List<MyClinicApiStaffEmail>? _staffEmails;

  @override
  List<MyClinicApiStaffEmail>? get staffEmails => _staffEmails;

  @override
  Future<Result<VoidResult, BasicError>> addStaffEmail(
      String email, UserRole userRole) {
    // TODO: implement addStaffEmail
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> deleteStaffEmail(int id) {
    // TODO: implement deleteStaffEmail
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> getStaffEmails() async {
    return (await _dataSource.getStaffEmails()).when(
      onSuccess: (result) {
        _staffEmails = result;
        return SuccessResult.voidResult();
      },
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> updateStaffEmail(
      {required int id, String? email, UserRole? userRole}) {
    // TODO: implement updateStaffEmail
    throw UnimplementedError();
  }
}
