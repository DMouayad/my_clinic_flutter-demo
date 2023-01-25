part of '../staff_bloc.dart';

class UpdateStaffMembersRequested extends StaffBlocEvent {
  final PaginatedResource<BaseStaffMember>? newStaffMembers;

  const UpdateStaffMembersRequested(this.newStaffMembers);

  @override
  List<Object?> get props => [newStaffMembers];

  @override
  Future<void> handle(
    BaseStaffMemberRepository repository,
    StaffBlocState state,
    Emitter<StaffBlocState> emit,
  ) async {
    if (state is StaffBlocEventProcessing) {
      StaffBlocSuccess getRequestedEventSuccessState() {
        switch (state.runtimeType) {
          case AddingStaffMember:
            return StaffMemberWasAdded();
          case UpdatingStaffMember:
            return StaffMemberWasUpdated();
          case DeletingStaffMember:
            return StaffMemberWasDeleted();
          default:
            throw UnimplementedError();
        }
      }

      emit(getRequestedEventSuccessState());
    }
    emit(StaffMembersWereLoaded(newStaffMembers));
  }
}
