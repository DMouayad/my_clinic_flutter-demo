part of 'staff_emails_bloc.dart';

abstract class StaffEmailsEvent extends Equatable {
  const StaffEmailsEvent();
  @override
  List<Object?> get props => [];
}

/// An event to load staff emails from server
class GetStaffEmails extends StaffEmailsEvent {}

/// An event to add a new staff email
class AddStaffEmail extends StaffEmailsEvent {
  final String email;
  final UserRole role;

  const AddStaffEmail(this.email, this.role);

  @override
  List<Object?> get props => [email, role];
}

/// An event to update staff email with provided id.
/// a new email address or UserRole must be passed.
class UpdateStaffEmail extends StaffEmailsEvent {
  final int id;
  final String? email;
  final UserRole? role;

  const UpdateStaffEmail({
    required this.id,
    this.email,
    this.role,
  }) : assert(email != null || role != null);

  @override
  List<Object?> get props => [id, email, role];
}

/// An event to delete staff email with provided id
class DeleteStaffEmail extends StaffEmailsEvent {
  final int id;

  const DeleteStaffEmail(this.id);

  @override
  List<Object?> get props => [id];
}
