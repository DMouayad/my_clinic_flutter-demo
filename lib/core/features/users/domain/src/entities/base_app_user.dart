
import 'package:clinic_v2/core/common/models/user_calendar.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:flutter/material.dart';

/// Base entity for an app user (doctor, nurse, secretary, etc...)
abstract class BaseAppUser {
  final String id;
  final UserRole role;
  ThemeMode? selectedThemeMode;
  Locale? selectedLocale;
  bool isLoggedIn;
  UserCalendar userCalendar;

  BaseAppUser({
    required this.id,
    required this.role,
    required this.userCalendar,
    this.isLoggedIn = true,
    this.selectedLocale,
    this.selectedThemeMode,
  });
}
