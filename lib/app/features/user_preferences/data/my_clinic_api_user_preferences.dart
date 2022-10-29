import 'dart:convert';

import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:flutter/material.dart';

import '../domain/base_user_preferences.dart';

class MyClinicApiUserPreferences extends BaseUserPreferences {
  const MyClinicApiUserPreferences({
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

  factory MyClinicApiUserPreferences.fromJson(String json) {
    return MyClinicApiUserPreferences.fromMap(jsonDecode(json));
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'theme': themePreference,
      'locale': localePreference,
    };
  }

  factory MyClinicApiUserPreferences.fromMap(Map<String, dynamic> map) {
    return MyClinicApiUserPreferences(
      id: map.get('id'),
      userId: map.get('user_id'),
      themePreference: ThemeMode.values.byName(map.get('theme')),
      localePreference: Locale(map.get('locale')),
    );
  }

  @override
  MyClinicApiUserPreferences copyWith({
    ThemeMode? themePreference,
    Locale? localePreference,
  }) {
    return MyClinicApiUserPreferences(
      id: id,
      userId: userId,
      themePreference: themePreference ?? this.themePreference,
      localePreference: localePreference ?? this.localePreference,
    );
  }
}
