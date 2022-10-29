part of 'staff_bloc.dart';

abstract class StaffBlocEvent extends Equatable {
  const StaffBlocEvent();
  @override
  List<Object?> get props => [];
}

/// An event to load staff emails from server
class FetchStaffMembers extends RequestsApiEndpoint implements StaffBlocEvent {
  const FetchStaffMembers({super.sortedBy, super.perPage, super.page});
}

/// An event to add a new staff email
class AddStaffMember extends StaffBlocEvent {
  final String email;
  final UserRole role;

  const AddStaffMember(this.email, this.role);

  @override
  List<Object?> get props => [email, role];
}

/// An event to update staff email with provided id.
/// a new email address or UserRole must be passed.
class UpdateStaffMember extends StaffBlocEvent {
  final int id;
  final String? email;
  final UserRole? role;

  const UpdateStaffMember({
    required this.id,
    this.email,
    this.role,
  }) : assert(email != null || role != null);

  @override
  List<Object?> get props => [id, email, role];
}

/// An event to delete staff email with provided id
class DeleteStaffMember extends StaffBlocEvent {
  final int id;

  const DeleteStaffMember(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateStaffMembersRequested extends StaffBlocEvent {
  final PaginatedResource<BaseStaffMember>? newStaffMembers;
  const UpdateStaffMembersRequested(this.newStaffMembers);

  @override
  List<Object?> get props => [newStaffMembers];
}
