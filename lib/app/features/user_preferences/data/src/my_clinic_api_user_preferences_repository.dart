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
    _dataSource = const MyClinicApiUserPreferencesDataSource();
  }
  late final MyClinicApiUserPreferencesDataSource _dataSource;
  MyClinicApiUserPreferences? _userPreferences;

  @override
  Future onInit() async => null;

  @override
  Future<Result<VoidValue, BasicError>> updateUserLocalePreference(
    Locale locale,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> updateUserThemePreference(
      ThemeMode themeMode) {
    // TODO: implement updateUserThemePreference
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> loadUserPreferences() async {
    return (await _dataSource.fetchUserPreferences()).mapSuccessToVoid(
      (result) => _userPreferences = preferences,
    );
  }

  @override
  MyClinicApiUserPreferences? get preferences => _userPreferences;
}
