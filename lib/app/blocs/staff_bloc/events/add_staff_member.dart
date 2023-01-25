part of '../staff_bloc.dart';

/// An event to add a new staff member
class AddStaffMember extends StaffBlocEvent {
  final String email;
  final UserRole role;

  const AddStaffMember(this.email, this.role);

  @override
  List<Object?> get props => [email, role];

  @override
  Future<void> handle(
    BaseStaffMemberRepository repository,
    StaffBlocState state,
    Emitter<StaffBlocState> emit,
  ) async {
    if (state is! StaffBlocEventProcessing) {
      emit(const AddingStaffMember());
    }
    await repository.addStaffMember(email, role).then((result) {
      if (result.isFailure) {
        emit(StaffBlocErrorState((result as FailureResult).error));
      }
    });
  }
}
