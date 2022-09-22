import 'dart:convert';

import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/features/user_preferences/data/src/my_clinic_api_user_preferences.dart';

class MyClinicApiUser implements BaseServerUser {
  MyClinicApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.preferences,
    this.appUserId,
    this.emailVerifiedAt,
  });

  @override
  final DateTime? emailVerifiedAt;
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final UserRole role;
  @override
  final MyClinicApiUserPreferences? preferences;
  @override
  final int? appUserId;

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'preferences': preferences?.toMap(),
      'app_user_id': appUserId,
    };
  }

  factory MyClinicApiUser.fromJson(String json) {
    return MyClinicApiUser.fromMap(jsonDecode(json));
  }

  factory MyClinicApiUser.fromMap(Map<String, dynamic> map) {
    return MyClinicApiUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: UserRole.values.byName(map['role']),
      appUserId: map.get('app_user_id'),
      emailVerifiedAt: DateTime.tryParse(map.get('email_verified_at')),
      preferences: MyClinicApiUserPreferences.fromMap(map['preferences']),
    );
  }

  factory MyClinicApiUser.fromStaffEmailMap(
      Map<String, dynamic> map, String role) {
    return MyClinicApiUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: UserRole.values.byName(role),
      emailVerifiedAt: DateTime.tryParse(map.get('email_verified_at')),
    );
  }
  factory MyClinicApiUser.fromApiResponseMap(Map<String, dynamic> map) {
    final roleName = map.get('role').get('role') as String;
    final prefsMap = map.get('preferences') as Map<String, dynamic>;
    return MyClinicApiUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: DateTime.tryParse(map.get('email_verified_at')),
      appUserId: map.get('app_user_id'),
      role: UserRole.values.byName(roleName),
      preferences: MyClinicApiUserPreferences.fromMap(prefsMap),
    );
  }

  @override
  List<Object?> get props => [appUserId, name, email, role, preferences];
  @override
  bool? get stringify => true;
}
