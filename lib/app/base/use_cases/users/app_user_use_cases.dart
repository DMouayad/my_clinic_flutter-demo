// ignore_for_file: unused_element

import 'package:clinic_v2/core/features/users/domain/src/entities/base_app_user.dart';
import 'package:flutter/material.dart';

abstract class UserUseCases<T extends BaseAppUser> {
  ThemeMode? getSelectedThemeMode();
  Locale? getSelectedLocale();
  Future<void> updateSelectedThemeMode(ThemeMode themeMode);
  Future<void> updateSelectedLocale(Locale locale);
  Future<void> logout();
}
