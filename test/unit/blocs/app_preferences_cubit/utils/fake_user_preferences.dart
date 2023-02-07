import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:flutter/material.dart';

class FakeUserPreferences extends BaseUserPreferences {
  const FakeUserPreferences({
    required super.localePreference,
    required super.themePreference,
  });

  @override
  BaseUserPreferences copyWith({
    ThemeMode? themePreference,
    Locale? localePreference,
  }) {
    return FakeUserPreferences(
      localePreference: localePreference ?? this.localePreference,
      themePreference: themePreference ?? this.themePreference,
    );
  }
}
