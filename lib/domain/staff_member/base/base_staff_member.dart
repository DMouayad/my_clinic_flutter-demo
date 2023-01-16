import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:equatable/equatable.dart';

abstract class BaseStaffMember<T extends BaseServerUser> extends Equatable {
  const BaseStaffMember({
    required this.id,
    required this.email,
    required this.userRole,
    required this.createdAt,
    this.user,
  });

  final int id;
  final String email;
  final UserRole userRole;
  final T? user;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, email, userRole, createdAt, user];

  BaseStaffMember copyWith({
    int? id,
    String? email,
    UserRole? userRole,
    DateTime? createdAt,
    T? user,
  });
}
