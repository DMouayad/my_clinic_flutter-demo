import 'dart:convert';

import 'package:clinic_v2/api/models/response_user_data.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/features/user_preferences/data/src/my_clinic_api_user_preferences.dart';

class MyClinicApiUser implements BaseServerUser {
  MyClinicApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    this.preferences,
    this.appUserId,
    this.emailVerifiedAt,
  });

  @override
  final DateTime? emailVerifiedAt;
  @override
  final int id;
  @override
  final String phoneNumber;
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
  @override
  final DateTime createdAt;

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'created_at': createdAt.toIso8601String(),
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
      phoneNumber: map['phoneNumber'],
      createdAt: DateTime.parse(map['created_at']),
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
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      createdAt: DateTime.parse(map['created_at']),
      role: UserRole.values.byName(role),
      emailVerifiedAt: DateTime.tryParse(map.get('email_verified_at')),
    );
  }

  factory MyClinicApiUser.fromApiResponse(ApiResponseUserData data) {
    return MyClinicApiUser(
      id: data.id,
      name: data.name,
      phoneNumber: data.phoneNumber,
      email: data.email,
      createdAt: DateTime.parse(data.createdAt),
      emailVerifiedAt: data.emailVerifiedAt != null
          ? DateTime.parse(data.emailVerifiedAt!)
          : null,
      appUserId: data.appUserId,
      role: UserRole.values.byName(data.roleSlug),
      preferences: data.preferencesMap != null
          ? MyClinicApiUserPreferences.fromMap(data.preferencesMap!)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        appUserId,
        name,
        email,
        role,
        preferences,
        id,
        createdAt,
        emailVerifiedAt,
      ];

  @override
  bool? get stringify => true;
}
