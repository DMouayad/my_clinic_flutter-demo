import 'package:clinic_v2/api/endpoints/api_endpoint.dart';
import 'package:clinic_v2/api/helpers/api_request_helper.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/helpers/device_id_helper.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/user_preferences_domain.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';
import 'package:flutter/material.dart';

import 'my_clinic_api_user_preferences.dart';

class MyClinicApiUserPreferencesDataSource
    with DioHelper, ApiRequestHelper
    implements BaseUserPreferencesDataSource<MyClinicApiUserPreferences> {
  final BaseAuthTokensService _authTokensService;

  MyClinicApiUserPreferencesDataSource(this._authTokensService);

  @override
  Future<Result<MyClinicApiUserPreferences, BasicError>>
      fetchUserPreferences() async {
    return (await _getUserPreferences()).fold();
  }

  Future<Result<MyClinicApiUserPreferences, BasicError>>
      _getUserPreferences() async {
    final accessTokenResult = await _authTokensService.getValidAccessToken();

    return await accessTokenResult.foldAsync(
      ifSuccess: (accessToken) async {
        return (await requestApiEndpoint<FetchUserPreferencesEndpointResult>(
          ApiEndpoint.fetchUserPreferences(
            accessToken: accessToken,
            deviceId: await DeviceIdHelper.get,
          ),
        ))
            .fold(ifSuccess: (result) {
          return SuccessResult(
            MyClinicApiUserPreferences.fromMap(result.toMap()),
          );
        });
      },
    );
  }

  @override
  Future<Result<VoidResult, BasicError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  }) async {
    final accessTokenResult = await _authTokensService.getValidAccessToken();

    return await accessTokenResult.foldAsync(
      ifSuccess: (accessToken) async {
        final updateResult =
            await requestApiEndpoint<UpdateUserPreferencesEndpointResult>(
          ApiEndpoint.updateUserPreferences(
            accessToken: accessToken,
            deviceId: await DeviceIdHelper.get,
          ),
        );
        return updateResult.fold();
      },
    );
  }
}
