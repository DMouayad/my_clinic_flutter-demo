import 'package:clinic_v2/api/endpoints/user_preferences_endpoints.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter/material.dart';

import '../domain/base_user_preferences_data_source.dart';
import 'my_clinic_api_user_preferences.dart';

class MyClinicApiUserPreferencesDataSource
    implements BaseUserPreferencesDataSource<MyClinicApiUserPreferences> {
  const MyClinicApiUserPreferencesDataSource();

  @override
  Future<Result<MyClinicApiUserPreferences, BasicError>>
      fetchUserPreferences() async {
    final response = await FetchUserPreferencesApiEndpoint().request();
    return response.mapSuccess(
      (result) => MyClinicApiUserPreferences.fromMap(result.toMap()),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  }) async {
    final response = await UpdateUserPreferencesApiEndpoint(
      locale: locale?.languageCode,
      theme: themeMode?.name,
    ).request();
    return response.mapSuccessToVoid();
  }

  @override
  Future<Result<VoidValue, BasicError>> setUserPreferences(
      {required ThemeMode themeMode, required Locale locale}) async {
    return (await CreateUserPreferencesApiEndpoint(
      locale: locale.languageCode,
      theme: themeMode.name,
    ).request())
        .mapSuccessToVoid();
  }
}
