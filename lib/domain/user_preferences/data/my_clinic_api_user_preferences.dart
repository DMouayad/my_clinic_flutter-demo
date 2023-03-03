import 'dart:convert';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/utils/extensions/map_extensions.dart';
import '../base/base_user_preferences.dart';

class ApiUserPreferences extends BaseUserPreferences {
  const ApiUserPreferences({
    int? id,
    int? userId,
    required ThemeMode themePreference,
    required Locale localePreference,
  }) : super(
          id: id,
          userId: userId,
          themePreference: themePreference,
          localePreference: localePreference,
        );

  String toJson() {
    return jsonEncode(toMap());
  }

  factory ApiUserPreferences.fromJson(String json) {
    return ApiUserPreferences.fromMap(jsonDecode(json));
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'theme': themePreference,
      'locale': localePreference,
    };
  }

  factory ApiUserPreferences.fromMap(Map<String, dynamic> map) {
    return ApiUserPreferences(
      id: map.get('id'),
      userId: map.get('user_id'),
      themePreference: ThemeMode.values.byName(map.get('theme')),
      localePreference: Locale(map.get('locale')),
    );
  }

  @override
  ApiUserPreferences copyWith({
    ThemeMode? themePreference,
    Locale? localePreference,
  }) {
    return ApiUserPreferences(
      id: id,
      userId: userId,
      themePreference: themePreference ?? this.themePreference,
      localePreference: localePreference ?? this.localePreference,
    );
  }
}
