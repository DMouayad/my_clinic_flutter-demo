import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';

abstract class BaseStaffEmail<T extends BaseServerUser> {
  const BaseStaffEmail({
    required this.id,
    required this.email,
    required this.userRole,
    this.user,
  });

  final int id;
  final String email;
  final UserRole userRole;
  final T? user;
}
