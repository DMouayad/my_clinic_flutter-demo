import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:equatable/equatable.dart';

abstract class BaseStaffMember<T extends BaseServerUser> extends Equatable {
  const BaseStaffMember({
    required this.id,
    required this.email,
    required this.userRole,
    this.user,
  });

  final int id;
  final String email;
  final UserRole userRole;
  final T? user;

  @override
  List<Object?> get props => [id, email, userRole, user];

  BaseStaffMember copyWith({
    int? id,
    String? email,
    UserRole? userRole,
    T? user,
  });
}
