import 'package:clinic_v2/app/core/extensions/map_extensions.dart';

class ApiResponseUserData {
  final int id;
  final int? appUserId;
  final String name;
  final String email;
  final String phoneNumber;
  final String roleSlug;
  final String? roleName;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? themePreference;
  final String? localePreference;

  ApiResponseUserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.roleSlug,
    this.roleName,
    this.appUserId,
    this.emailVerifiedAt,
    this.themePreference,
    this.localePreference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'app_user_id': appUserId,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role_slug': roleSlug,
      'role_name': roleName,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'theme_preference': themePreference,
      'locale_preference': localePreference,
    };
  }

  factory ApiResponseUserData.fromMap(Map<String, dynamic> map) {
    final roleMap = map.get('role') as Map<String, dynamic>?;
    final prefsMap = map.get('preferences') as Map<String, dynamic>?;
    return ApiResponseUserData(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      roleSlug: roleMap?.get('slug') as String,
      // optional fields //
      roleName: roleMap?.get('name') as String?,
      appUserId: map.get('app_user_id') as int?,
      emailVerifiedAt: map.get('email_verified_at') as String?,
      themePreference: prefsMap?.get('theme') as String?,
      localePreference: prefsMap?.get('locale') as String?,
    );
  }
  Map<String, dynamic> get roleMap {
    return {
      'slug': roleSlug,
      'name': roleName,
    };
  }

  Map<String, dynamic>? get preferencesMap {
    return localePreference != null && themePreference != null
        ? {
            'theme': themePreference,
            'locale': localePreference,
          }
        : null;
  }
}
