import 'package:flutter/material.dart';
//
import 'package:clinic_v2/api/endpoints/auth_endpoints.dart';
import 'package:clinic_v2/api/endpoints/user_endpoints.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/src/my_clinic_api_user.dart';
import 'package:clinic_v2/app/features/authentication/domain/src/base_auth_data_source.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';

class MyClinicApiAuthDataSource implements BaseAuthDataSource<MyClinicApiUser> {
  final BaseAuthTokensService _authTokensService;

  MyClinicApiAuthDataSource(this._authTokensService);

  @override
  Future<Result<MyClinicApiUser, BasicError>> login(
    String email,
    String password,
  ) async {
    final response =
        await LoginApiEndpoint(email: email, password: password).request();

    return await response.whenAsync(
      onSuccess: (result) async {
        // save returned auth tokens to storage
        await _authTokensService.saveAuthTokens(result.authTokens);
        return SuccessResult(
          MyClinicApiUser.fromApiResponse(result.userWithRoleAndPrefs),
        );
      },
      onError: (BasicError error) async => ErrorResult(error),
    );
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required ThemeMode themeModePreference,
    required Locale localePreference,
  }) async {
    final response = await RegisterApiEndpoint(
      name: username,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    ).request();
    return await response.foldAsync(
      ifSuccess: (endpointResult) async {
        await _authTokensService.saveAuthTokens(endpointResult.authTokens);

        return SuccessResult(
          MyClinicApiUser.fromApiResponse(endpointResult.userWithRole),
        );
      },
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> logout() async {
    final logoutResponse = await LogoutApiEndpoint().request();
    return logoutResponse.fold();
  }

  @override
  Future<Result<VoidResult, BasicError>> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> sendVerificationEmail() async {
    return (await RequestEmailVerificationApiEndpoint().request()).fold();
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> loadUser() async {
    final response = await FetchUserEndpoint().request();
    return response.when(
      onSuccess: (result) => SuccessResult(
        MyClinicApiUser.fromApiResponse(result.userWithRoleAndPrefs),
      ),
      onError: (error) => ErrorResult(error),
    );
  }
}
