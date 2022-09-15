import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter/material.dart';

import 'base_user_preferences.dart';

abstract class BaseUserPreferencesDataSource<T extends BaseUserPreferences> {
  Future<Result<VoidResult, BasicError>> loadUserPreferences();

  Future<Result<T, BasicError>> updateUserPreferences({
    ThemeMode? themeMode,
    Locale? locale,
  });
}
