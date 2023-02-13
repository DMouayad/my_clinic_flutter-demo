import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter/material.dart';

import '../../../domain/user_preferences/base/base_user_preferences.dart';

abstract class BaseUserPreferencesRepository<T extends BaseUserPreferences> {
  Future onInit() async => null;

  T? getUserPreferences();

  void setUserPreferences(T? value);

  Future<Result<VoidValue, AppError>> createUserPreferences(
    ThemeMode themeMode,
    Locale locale,
  );

  Future<Result<VoidValue, AppError>> loadUserPreferences();

  Future<Result<VoidValue, AppError>> updateUserThemePreference(
    ThemeMode themeMode,
  );

  Future<Result<VoidValue, AppError>> updateUserLocalePreference(
    Locale locale,
  );
}
