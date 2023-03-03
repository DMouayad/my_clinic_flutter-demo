import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/api/endpoints/user_endpoints.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:get_it/get_it.dart';

import '../base/base_auth_data_source.dart';
import '../base/base_auth_tokens_service.dart';
import 'my_clinic_api_user.dart';

class ApiAuthDataSource implements BaseAuthDataSource<ApiUser> {
  const ApiAuthDataSource();

  BaseAuthTokensService get _authTokensService => GetIt.I.get();

  @override
  Future<Result<ApiUser, AppError>> login({
    required String email,
    required String password,
  }) async {
    final response =
        await LoginApiEndpoint(email: email, password: password).request();

    return await response.mapSuccessAsync(
      (result) async {
        // save returned auth tokens to storage
        await _authTokensService.saveAuthTokens(result.authTokens);
        return ApiUser.fromApiResponse(result.userWithRoleAndPrefs);
      },
    );
  }

  @override
  Future<Result<ApiUser, AppError>> register({
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
        return ApiUser.fromApiResponse(result.userWithRole);
      },
    );
  }

  @override
  Future<Result<VoidValue, AppError>> logout() async {
    return await (await LogoutApiEndpoint().request()).mapSuccessToVoidAsync(
        onSuccess: (_) async {
      await _authTokensService.deleteRefreshToken();
      await _authTokensService.deleteAccessToken();
    });
  }

  @override
  Future<Result<VoidValue, AppError>> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, AppError>> sendVerificationEmail() async {
    return (await RequestEmailVerificationApiEndpoint().request())
        .mapSuccessToVoid();
  }

  @override
  Future<Result<ApiUser?, AppError>> loadUser() async {
    if ((await _authTokensService.getAccessToken()) == null) {
      return const SuccessResult(null);
    } else {
      return (await FetchUserEndpoint().request()).mapSuccess(
        (result) => ApiUser.fromApiResponse(result.userWithRoleAndPrefs),
      );
    }
  }
}
