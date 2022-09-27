import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/user_preferences/data/src/my_clinic_api_user_preferences_data_source.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/user_preferences_domain.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';
import 'package:flutter/material.dart';

import 'my_clinic_api_user_preferences.dart';

class MyClinicApiUserPreferencesRepository
    implements BaseUserPreferencesRepository<MyClinicApiUserPreferences> {
  MyClinicApiUserPreferencesRepository(
      BaseAuthTokensService authTokenProvider) {
    _dataSource = MyClinicApiUserPreferencesDataSource(authTokenProvider);
  }
  late final MyClinicApiUserPreferencesDataSource _dataSource;
  MyClinicApiUserPreferences? userPreferences;

  @override
  Future onInit() {
    // TODO: implement onInit
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> updateUserLocalePreference(
    Locale locale,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidResult, BasicError>> updateUserThemePreference(
      ThemeMode themeMode) {
    // TODO: implement updateUserThemePreference
    throw UnimplementedError();
  }

  @override
  Locale getUserLocalePreference() {
    return _dataSource.userPreferences!.localePreference;
  }

  @override
  ThemeMode getUserThemePreference() {
    return _dataSource.userPreferences!.themePreference;
  }

  @override
  void setUserPreferences(MyClinicApiUserPreferences userPreferences) {
    _dataSource.userPreferences = userPreferences;
  }
}
