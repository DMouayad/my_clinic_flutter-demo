import 'package:flutter/material.dart';

abstract class BaseUserPreferences {
  final int id;
  final int userId;
  ThemeMode themePreference;
  Locale localePreference;

  BaseUserPreferences({
    required this.id,
    required this.userId,
    required this.localePreference,
    required this.themePreference,
  });
}
