import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter/material.dart';

import 'base_user_preferences.dart';

abstract class BaseUserPreferencesRepository<T extends BaseUserPreferences> {
  Future onInit() async => null;
  T? get preferences;

  Future<Result<VoidValue, BasicError>> setUserPreferences(
      ThemeMode themeMode, Locale locale);
  Future<Result<VoidValue, BasicError>> loadUserPreferences();
  Future<Result<VoidValue, BasicError>> updateUserThemePreference(
    ThemeMode themeMode,
  );
  Future<Result<VoidValue, BasicError>> updateUserLocalePreference(
    Locale locale,
  );
}
