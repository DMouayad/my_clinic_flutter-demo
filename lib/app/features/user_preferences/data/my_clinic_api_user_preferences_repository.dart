import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';

import '../domain/base_user_preferences_repository.dart';
import 'my_clinic_api_user_preferences.dart';
import 'my_clinic_api_user_preferences_data_source.dart';

class MyClinicApiUserPreferencesRepository
    implements BaseUserPreferencesRepository<MyClinicApiUserPreferences> {
  MyClinicApiUserPreferencesRepository() {
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
    return (await _dataSource.updateUserPreferences(locale: locale))
        .mapSuccessToVoid(
      (result) => _userPreferences = preferences,
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateUserThemePreference(
    ThemeMode themeMode,
  ) async {
    return (await _dataSource.updateUserPreferences(themeMode: themeMode))
        .mapSuccessToVoid(
      (result) => _userPreferences = preferences,
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> loadUserPreferences() async {
    return (await _dataSource.fetchUserPreferences()).mapSuccessToVoid(
      (result) => _userPreferences = preferences,
    );
  }

  @override
  MyClinicApiUserPreferences? get preferences => _userPreferences;

  @override
  Future<Result<VoidValue, BasicError>> setUserPreferences(
      ThemeMode themeMode, Locale locale) async {
    return (await _dataSource.setUserPreferences(
      themeMode: themeMode,
      locale: locale,
    ))
        .mapSuccessToVoid(
      (_) {
        _userPreferences = preferences;
      },
    );
  }
}
