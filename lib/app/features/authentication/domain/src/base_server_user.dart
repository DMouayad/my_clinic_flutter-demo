import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/src/base_user_preferences.dart';
import 'package:equatable/equatable.dart';

abstract class BaseServerUser extends Equatable {
  /// the id of an [BaseAppUser] that contains the account info for this user.
  final String? appUserId;
  final String name;
  final String email;
  final UserRole role;
  final BaseUserPreferences preferences;

  const BaseServerUser({
    required this.name,
    required this.email,
    required this.role,
    required this.preferences,
    this.appUserId,
  });
}
