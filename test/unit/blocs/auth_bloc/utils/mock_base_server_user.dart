import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';

class MockBaseServerUser implements BaseServerUser {
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
  final BaseUserPreferences? preferences;
  @override
  final int? appUserId;
  @override
  final DateTime createdAt;

  @override
  bool get isVerified => emailVerifiedAt != null;

  @override
  List<Object?> get props => [
        appUserId,
        name,
        email,
        role,
        preferences,
        phoneNumber,
        id,
        createdAt,
        emailVerifiedAt,
      ];

  @override
  bool? get stringify => true;

  const MockBaseServerUser({
    this.emailVerifiedAt,
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.role,
    this.preferences,
    this.appUserId,
    required this.createdAt,
  });
}
