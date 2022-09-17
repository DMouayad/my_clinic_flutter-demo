import 'dart:convert';

import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/user_preferences_domain.dart';
import 'package:flutter/material.dart';

class MyClinicApiUserPreferences extends BaseUserPreferences {
  MyClinicApiUserPreferences({
    required int id,
    required int userId,
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

  factory MyClinicApiUserPreferences.fromJson(String json) {
    return MyClinicApiUserPreferences.fromMap(jsonDecode(json));
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'theme_preference': themePreference,
      'locale_preference': localePreference,
    };
  }

  factory MyClinicApiUserPreferences.fromMap(Map<String, dynamic> map) {
    return MyClinicApiUserPreferences(
      id: map['id'],
      userId: map['user_id'],
      themePreference: map.get('theme_preference'),
      localePreference: map.get('locale_preference'),
    );
  }
}
