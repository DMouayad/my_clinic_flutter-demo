import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter/material.dart';

import '../../../domain/user_preferences/base/base_user_preferences.dart';

abstract class BaseUserPreferencesRepository<T extends BaseUserPreferences> {
  Future onInit() async => null;

  T? get userPreferences;

  set userPreferences(T? value);

  Future<Result<VoidValue, AppError>> setUserPreferences(
      ThemeMode themeMode, Locale locale);

  Future<Result<VoidValue, AppError>> loadUserPreferences();

  Future<Result<VoidValue, AppError>> updateUserThemePreference(
    ThemeMode themeMode,
  );

  Future<Result<VoidValue, AppError>> updateUserLocalePreference(
    Locale locale,
  );
}
