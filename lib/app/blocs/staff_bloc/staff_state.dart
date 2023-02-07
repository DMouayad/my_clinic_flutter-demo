part of 'staff_bloc.dart';

abstract class StaffBlocState extends Equatable {
  const StaffBlocState();

  @override
  List<Object?> get props => [];
}

class StaffBlocInitialState extends StaffBlocState {}

abstract class StaffBlocSuccess extends StaffBlocState {
  const StaffBlocSuccess();
}

class StaffMemberWasAdded extends StaffBlocSuccess {}

class StaffMemberWasUpdated extends StaffBlocSuccess {}

class StaffMemberWasDeleted extends StaffBlocSuccess {}

abstract class StaffBlocEventProcessing extends StaffBlocState {
  const StaffBlocEventProcessing();
}

class AddingStaffMember extends StaffBlocEventProcessing {
  const AddingStaffMember();
}

class UpdatingStaffMember extends StaffBlocEventProcessing {
  const UpdatingStaffMember();
}

class DeletingStaffMember extends StaffBlocEventProcessing {
  const DeletingStaffMember();
}

class StaffMembersWereLoaded extends StaffBlocState {
  final PaginatedResource<BaseStaffMember>? staffMembers;

  const StaffMembersWereLoaded(this.staffMembers);

  @override
  String toString() {
    return '''$runtimeType: Total(${staffMembers?.data.length})''';
  }

  @override
  List<Object?> get props => [staffMembers];
}

class LoadingStaffMembers extends StaffBlocState {}

class StaffBlocErrorState extends StaffBlocState {
  final AppError error;

  const StaffBlocErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
