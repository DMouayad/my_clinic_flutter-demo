import 'package:flutter/material.dart';

//
import 'package:clinic_v2/shared/models/result/result.dart';

import 'my_clinic_api_user_preferences_data_source.dart';
import 'my_clinic_api_user_preferences.dart';
import '../base/base_user_preferences_repository.dart';

class ApiUserPreferencesRepository
    implements BaseUserPreferencesRepository<ApiUserPreferences> {
  ApiUserPreferencesRepository() {
    _dataSource = const ApiUserPreferencesDataSource();
  }

  late final ApiUserPreferencesDataSource _dataSource;
  ApiUserPreferences? _userPreferences;

  @override
  Future onInit() async => null;

  @override
  Future<Result<VoidValue, AppError>> updateUserLocalePreference(
    Locale locale,
  ) async {
    return (await _dataSource.updateUserPreferences(locale: locale))
        .mapSuccessToVoid(
      onSuccess: (result) => _userPreferences =
          _userPreferences!.copyWith(localePreference: locale),
    );
  }

  @override
  Future<Result<VoidValue, AppError>> updateUserThemePreference(
    ThemeMode themeMode,
  ) async {
    return (await _dataSource.updateUserPreferences(themeMode: themeMode))
        .mapSuccessToVoid(
      onSuccess: (result) => _userPreferences =
          _userPreferences!.copyWith(themePreference: themeMode),
    );
  }

  @override
  Future<Result<VoidValue, AppError>> loadUserPreferences() async {
    return (await _dataSource.fetchUserPreferences()).mapSuccessToVoid(
      onSuccess: (result) => _userPreferences = result,
    );
  }

  @override
  Future<Result<VoidValue, AppError>> createUserPreferences(
    ThemeMode themeMode,
    Locale locale,
  ) async {
    return (await _dataSource.setUserPreferences(
      themeMode: themeMode,
      locale: locale,
    ))
        .mapSuccessToVoid(
      onSuccess: (_) {
        setUserPreferences(ApiUserPreferences(
          themePreference: themeMode,
          localePreference: locale,
        ));
      },
    );
  }

  @override
  ApiUserPreferences? getUserPreferences() => _userPreferences;

  @override
  void setUserPreferences(ApiUserPreferences? value) {
    _userPreferences = value;
  }
}
