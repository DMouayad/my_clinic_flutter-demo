import 'package:flutter/material.dart';

//
import 'package:clinic_v2/shared/models/result/result.dart';

import 'my_clinic_api_user_preferences_data_source.dart';
import 'my_clinic_api_user_preferences.dart';
import '../base/base_user_preferences_repository.dart';

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
      onSuccess: (result) => _userPreferences =
          _userPreferences!.copyWith(localePreference: locale),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateUserThemePreference(
    ThemeMode themeMode,
  ) async {
    return (await _dataSource.updateUserPreferences(themeMode: themeMode))
        .mapSuccessToVoid(
      onSuccess: (result) => _userPreferences =
          _userPreferences!.copyWith(themePreference: themeMode),
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> loadUserPreferences() async {
    return (await _dataSource.fetchUserPreferences()).mapSuccessToVoid(
      onSuccess: (result) => _userPreferences = result,
    );
  }

  @override
  MyClinicApiUserPreferences? get userPreferences => _userPreferences;

  @override
  Future<Result<VoidValue, BasicError>> setUserPreferences(
    ThemeMode themeMode,
    Locale locale,
  ) async {
    return (await _dataSource.setUserPreferences(
      themeMode: themeMode,
      locale: locale,
    ))
        .mapSuccessToVoid(
      onSuccess: (_) {
        _userPreferences = MyClinicApiUserPreferences(
          themePreference: themeMode,
          localePreference: locale,
        );
      },
    );
  }

  @override
  set userPreferences(MyClinicApiUserPreferences? value) {
    _userPreferences = value;
  }
}
