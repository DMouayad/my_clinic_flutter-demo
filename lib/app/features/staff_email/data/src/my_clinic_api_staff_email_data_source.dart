import 'package:clinic_v2/api/endpoints/api_endpoint.dart';
import 'package:clinic_v2/api/helpers/api_request_helper.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';

import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/helpers/device_id_helper.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';

import 'my_clinic_api_staff_email.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';

class MyClinicApiStaffEmailDataSource
    extends BaseStaffEmailDataSource<MyClinicApiStaffEmail>
    with DioHelper, ApiRequestHelper {
  final BaseAuthTokensService _authTokensService;

  MyClinicApiStaffEmailDataSource(this._authTokensService);

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
  Future<Result<List<MyClinicApiStaffEmail>, BasicError>>
      getStaffEmails() async {
    return await (await _authTokensService.getValidAccessToken()).whenAsync(
      onSuccess: (accessToken) async {
        final response = await requestApiEndpoint<GetStaffEmailsEndpointResult>(
          ApiEndpoint.getStaffEmailsFullInfo(
            accessToken: accessToken,
            deviceId: await DeviceIdHelper.get,
          ),
        );
        return response.when(
          onSuccess: (result) {
            return SuccessResult(
              result.staffEmailsData
                  .map((e) => MyClinicApiStaffEmail.fromApiResponse(e))
                  .toList(),
            );
          },
          onError: (error) => ErrorResult(error),
        );
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> updateStaffEmail(
      {required int id, String? email, UserRole? userRole}) {
    // TODO: implement updateStaffEmail
    throw UnimplementedError();
  }
}
