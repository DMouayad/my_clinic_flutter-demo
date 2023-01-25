import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/api/endpoints/user_endpoints.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:get_it/get_it.dart';

import '../base/base_auth_data_source.dart';
import '../base/base_auth_tokens_service.dart';
import 'my_clinic_api_user.dart';

class MyClinicApiAuthDataSource implements BaseAuthDataSource<MyClinicApiUser> {
  const MyClinicApiAuthDataSource();

  BaseAuthTokensService get _authTokensService => GetIt.I.get();

  @override
  Future<Result<MyClinicApiUser, BasicError>> login(
      String email, String password) async {
    final response =
        await LoginApiEndpoint(email: email, password: password).request();

    return await response.mapSuccessAsync(
      (result) async {
        // save returned auth tokens to storage
        await _authTokensService.saveAuthTokens(result.authTokens);
        return MyClinicApiUser.fromApiResponse(result.userWithRoleAndPrefs);
      },
    );
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await RegisterApiEndpoint(
      name: username,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    ).request();

    return await response.mapSuccessAsync(
      (result) async {
        await _authTokensService.saveAuthTokens(result.authTokens);
        return MyClinicApiUser.fromApiResponse(result.userWithRole);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> logout() async {
    return await (await LogoutApiEndpoint().request()).mapSuccessToVoidAsync(
        onSuccess: (_) async {
      await _authTokensService.deleteRefreshToken();
      await _authTokensService.deleteAccessToken();
    });
  }

  @override
  Future<Result<VoidValue, BasicError>> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> sendVerificationEmail() async {
    return (await RequestEmailVerificationApiEndpoint().request())
        .mapSuccessToVoid();
  }

  @override
  Future<Result<MyClinicApiUser?, BasicError>> loadUser() async {
    if ((await _authTokensService.getAccessToken()) == null) {
      return const SuccessResult(null);
    } else {
      return (await FetchUserEndpoint().request()).mapSuccess(
        (result) =>
            MyClinicApiUser.fromApiResponse(result.userWithRoleAndPrefs),
      );
    }
  }
}
