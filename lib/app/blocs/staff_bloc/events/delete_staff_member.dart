part of '../staff_bloc.dart';

/// An event to delete staff email with provided id
class DeleteStaffMember extends StaffBlocEvent {
  final int id;

  const DeleteStaffMember(this.id);

  @override
  List<Object?> get props => [id];

  @override
  Future<void> handle(
    BaseStaffMemberRepository repository,
    StaffBlocState state,
    Emitter<StaffBlocState> emit,
  ) async {
    emit(const DeletingStaffMember());
    (await repository.deleteStaffMember(id)).fold(ifFailure: (error) {
      emit(StaffBlocErrorState(error));
    });
  }
}
