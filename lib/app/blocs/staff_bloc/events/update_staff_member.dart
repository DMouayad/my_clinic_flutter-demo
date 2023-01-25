part of '../staff_bloc.dart';

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

  @override
  Future<void> handle(
    BaseStaffMemberRepository repository,
    StaffBlocState state,
    Emitter<StaffBlocState> emit,
  ) async {
    emit(const UpdatingStaffMember());
    (await repository.updateStaffMember(id, email, role)).fold(
      ifFailure: (error) {
        emit(StaffBlocErrorState(error));
      },
    );
  }
}
