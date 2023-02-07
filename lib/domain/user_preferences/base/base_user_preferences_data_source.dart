import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter/material.dart';

import 'base_user_preferences.dart';

abstract class BaseUserPreferencesDataSource<T extends BaseUserPreferences> {
  Future<Result<T, AppError>> fetchUserPreferences();

  Future<Result<VoidValue, AppError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  });
  Future<Result<VoidValue, AppError>> setUserPreferences({
    required ThemeMode themeMode,
    required Locale locale,
  });
}
