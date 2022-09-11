import 'package:clinic_v2/common/common/utilities/enums.dart';
import 'package:flutter/material.dart';

/// Base entity for an app user (doctor, nurse, secretary, etc...)
abstract class BaseAppUser {
  final String id;
  final UserRole role;
  ThemeMode? selectedThemeMode;
  Locale? selectedLocale;
  bool isLoggedIn;

  BaseAppUser({
    required this.id,
    required this.role,
    this.isLoggedIn = true,
    this.selectedLocale,
    this.selectedThemeMode,
  });
}
