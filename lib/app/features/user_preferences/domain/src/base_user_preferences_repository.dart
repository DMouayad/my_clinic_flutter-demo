import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter/material.dart';

import 'base_user_preferences.dart';

abstract class BaseUserPreferencesRepository<T extends BaseUserPreferences> {
  Future onInit() async => null;
  void setUserPreferences(T userPreferences);
  ThemeMode getUserThemePreference();
  Locale getUserLocalePreference();
  Future<Result<VoidResult, BasicError>> updateUserThemePreference(
    ThemeMode themeMode,
  );
  Future<Result<VoidResult, BasicError>> updateUserLocalePreference(
      Locale locale);
}
