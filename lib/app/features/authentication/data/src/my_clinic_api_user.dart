import 'dart:convert';

import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/features/user_preferences/data/src/my_clinic_api_user_preferences.dart';

class MyClinicApiUser implements BaseServerUser {
  MyClinicApiUser({
    required this.name,
    required this.email,
    required this.role,
    required this.preferences,
    this.appUserId,
  });

  @override
  final String name;
  @override
  final String email;
  @override
  final UserRole role;
  @override
  final MyClinicApiUserPreferences preferences;
  @override
  final String? appUserId;

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.name,
      'preferences': preferences.toMap(),
      'app_user_id': appUserId,
    };
  }

  factory MyClinicApiUser.fromJson(String json) {
    return MyClinicApiUser.fromMap(jsonDecode(json));
  }

  factory MyClinicApiUser.fromMap(Map<String, dynamic> map) {
    return MyClinicApiUser(
      name: map['name'],
      email: map['email'],
      role: UserRole.values.byName(map['role']),
      appUserId: map.get('app_user_id'),
      preferences: MyClinicApiUserPreferences.fromMap(map['preferences']),
    );
  }
  factory MyClinicApiUser.fromApiResponseMap(Map<String, dynamic> map) {
    final roleName = map['role']['slug'] as String;
    return MyClinicApiUser(
      name: map['name'],
      email: map['email'],
      appUserId: map.get('app_user_id'),
      role: UserRole.values.byName(roleName),
      preferences: MyClinicApiUserPreferences.fromMap(map['preferences']),
    );
  }
}
