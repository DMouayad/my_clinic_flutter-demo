import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter/material.dart';

import 'base_user_preferences.dart';

abstract class BaseUserPreferencesDataSource<T extends BaseUserPreferences> {
  Future<Result<T, BasicError>> fetchUserPreferences();

  Future<Result<VoidValue, BasicError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  });
  Future<Result<VoidValue, BasicError>> setUserPreferences({
    required ThemeMode themeMode,
    required Locale locale,
  });
}
