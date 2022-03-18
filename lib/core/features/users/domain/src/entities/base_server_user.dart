import 'package:clinic_v2/core/common/utilities/enums.dart';

abstract class BaseServerUser {
  /// the id of an [BaseAppUser] that contains the basic info for this user.
  final String? appUserId;
  final String name;
  final String email;
  final UserRole role;

  BaseServerUser({
    required this.name,
    required this.email,
    required this.role,
    this.appUserId,
  });
}
