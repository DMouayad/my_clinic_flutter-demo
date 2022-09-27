import 'package:clinic_v2/api/endpoints/user_preferences_endpoints.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/helpers/device_id_helper.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/user_preferences_domain.dart';
import 'package:flutter/material.dart';
import 'my_clinic_api_user_preferences.dart';

class MyClinicApiUserPreferencesDataSource
    implements BaseUserPreferencesDataSource<MyClinicApiUserPreferences> {
  const MyClinicApiUserPreferencesDataSource();

  @override
  Future<Result<MyClinicApiUserPreferences, BasicError>>
      fetchUserPreferences() async {
    final response = await FetchUserPreferencesApiEndpoint().request();
    return response.flatMapSuccess(
      (result) => SuccessResult(
        MyClinicApiUserPreferences.fromMap(result.toMap()),
      ),
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
    return response.mapSuccess((_) => VoidValue());
  }
}
