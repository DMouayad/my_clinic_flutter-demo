import 'package:equatable/equatable.dart';
//
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:clinic_v2/utils/enums.dart';

abstract class BaseServerUser extends Equatable {
  final int id;

  /// the id of an [BaseAppUser] that contains the account info for this user.
  final int? appUserId;
  final String name;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final BaseUserPreferences? preferences;

  /// Represents when the user email was verified - timezone is UTC
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  bool get isVerified => emailVerifiedAt != null;
  const BaseServerUser({
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
  List<Object?> get props => [
        id,
        email,
        name,
        role,
        phoneNumber,
        createdAt,
        emailVerifiedAt,
        preferences,
        appUserId,
      ];
}
