import 'dart:io';

import 'package:clinic_v2/api/endpoints/api_endpoints.dart';
import 'package:clinic_v2/api/helpers/api_request_helper.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/api/utils/auth_tokens.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/src/my_clinic_api_user.dart';
import 'package:clinic_v2/app/features/authentication/domain/src/base_auth_data_source.dart';
import 'package:clinic_v2/app/services/auth_token/base_auth_token_provider.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

class MyClinicApiAuthDataSource
    with DioHelper, ApiRequestHelper
    implements BaseAuthDataSource<MyClinicApiUser> {
  final BaseAuthTokensService _authTokensService;

  MyClinicApiAuthDataSource(this._authTokensService);

  @override
  Future<Result<MyClinicApiUser, BasicError>> login(
    String email,
    String password,
  ) async {
    final response = await requestApiEndpoint<LoginEndpointResult>(
      ApiEndpoint.login(
        email,
        password,
        await _getUserDeviceId(email),
      ),
    );
    print(response);
    return response.when(
      onSuccess: (result) {
        // save returned auth tokens to storage
        _saveAuthTokens(result.authTokens);

        return SuccessResult(
          MyClinicApiUser.fromApiResponseMap(result.userWithRoleAndPrefs),
        );
      },
      onError: (BasicError error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> register(
    String username,
    String email,
    String password,
    ThemeMode themeModePreference,
    Locale localePreference,
  ) async {
    final response = await requestApiEndpoint<RegisterEndpointResult>(
      ApiEndpoint.register(
        username,
        email,
        password,
        await _getUserDeviceId(email),
      ),
    );
    return response.when(
      onSuccess: (endpointResult) {
        _saveAuthTokens(endpointResult.authTokens);

        return SuccessResult(
          MyClinicApiUser.fromApiResponseMap(endpointResult.userWithRole),
        );
      },
      onError: (error) => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> logout() async {
    return await (await _getValidAccessToken()).whenAsync(
      onSuccess: (accessToken) async {
        final logoutResponse = await requestApiEndpoint<LogoutEndpointResult>(
          ApiEndpoint.logout(accessToken),
        );
        return logoutResponse.when(
          onSuccess: (_) => SuccessResult.voidResult(),
          onError: (error) => ErrorResult(error),
        );
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> requestPasswordReset(String email) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> sendVerificationEmail() async {
    return (await _getValidAccessToken()).whenAsync(
      onSuccess: (accessToken) async {
        final response =
            await requestApiEndpoint<RequestEmailVerificationEndpointResult>(
          ApiEndpoint.requestEmailVerification(accessToken),
        );
        return response.when(
          onSuccess: (_) => SuccessResult.voidResult(),
          onError: (error) => ErrorResult(error),
        );
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  @override
  Future<Result<MyClinicApiUser, BasicError>> loadUser() async {
    return (await _getValidAccessToken()).whenAsync(
      onSuccess: (accessToken) async {
        final response = await requestApiEndpoint<GetUserInfoEndpointResult>(
          ApiEndpoint.getUserInfo(accessToken),
        );
        return response.when(
          onSuccess: (result) => SuccessResult(
            MyClinicApiUser.fromApiResponseMap(result.userWithRoleAndPrefs),
          ),
          onError: (error) => ErrorResult(error),
        );
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  Future<Result<String, BasicError>> _getValidAccessToken() async {
    final accessToken = await _authTokensService.getAccessToken();
    // return access token if found and isn't expired
    if (accessToken != null && !accessToken.isExpired) {
      return SuccessResult(accessToken.token);
    } else {
      final refreshToken = await _authTokensService.getRefreshToken();
      print(refreshToken);
      // if a refresh token found => request to refresh auth tokens
      if (refreshToken != null) {
        return (await _refreshAuthTokens(refreshToken)).when(
          onSuccess: (result) => SuccessResult(result.accessToken.token),
          onError: (error) => ErrorResult(error),
        );
      } else {
        return ErrorResult.fromErrorException(
          ErrorException.noRefreshTokenFound(),
        );
      }
    }
  }

  Future<Result<AuthTokens, BasicError>> _refreshAuthTokens(
    String refreshToken,
  ) async {
    final response = await requestApiEndpoint<RefreshAccessTokenEndpointResult>(
      ApiEndpoint.refreshAccessToken(refreshToken),
    );
    return await response.whenAsync(
      onSuccess: (result) async {
        // save new auth tokens to storage
        await _saveAuthTokens(result.authTokens);
        return SuccessResult(result.authTokens);
      },
      onError: (error) async => ErrorResult(error),
    );
  }

  Future<void> _saveAuthTokens(AuthTokens authTokens) async {
    await _authTokensService.saveRefreshToken(authTokens.refreshToken);
    await _authTokensService.saveAccessToken(authTokens.accessToken);
  }

  Future<String> _getUserDeviceId(String email) async {
    return await PlatformDeviceId.getDeviceId ??
        (Platform.localHostname + ' - ' + email);
  }
}
