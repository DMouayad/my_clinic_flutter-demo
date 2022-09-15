import 'package:clinic_v2/api/helpers/api_request_helper.dart';
import 'package:clinic_v2/api/helpers/dio_helper.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/user_preferences_domain.dart';
import 'package:clinic_v2/app/services/auth_token/base_auth_token_provider.dart';
import 'package:flutter/material.dart';

import 'my_clinic_api_user_preferences.dart';

class MyClinicApiUserPreferencesDataSource
    with DioHelper, ApiRequestHelper
    implements BaseUserPreferencesDataSource<MyClinicApiUserPreferences> {
  final BaseAuthTokensService _authTokenProvider;

  MyClinicApiUserPreferencesDataSource(this._authTokenProvider);

  MyClinicApiUserPreferences? userPreferences;

  @override
  Future<Result<VoidResult, BasicError>> loadUserPreferences() async {
    return (await _getUserPreferences()).when(
      onSuccess: (result) {
        userPreferences = result;
        return SuccessResult.voidResult();
      },
      onError: (e) => ErrorResult(e),
    );
  }

  Future<Result<MyClinicApiUserPreferences, BasicError>>
      _getUserPreferences() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<MyClinicApiUserPreferences, BasicError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  }) async {
    // TODO: implement updateUserPreferences
    throw UnimplementedError();
  }
}
