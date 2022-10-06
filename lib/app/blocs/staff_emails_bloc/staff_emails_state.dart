part of 'staff_emails_bloc.dart';

abstract class StaffEmailsState extends Equatable {
  const StaffEmailsState();

  @override
  List<Object?> get props => [];
}

class StaffEmailsInitial extends StaffEmailsState {}

abstract class StaffEmailsSuccess extends StaffEmailsState {
  const StaffEmailsSuccess();
}

class StaffEmailWasAdded extends StaffEmailsSuccess {}

class StaffEmailWasUpdated extends StaffEmailsSuccess {}

class StaffEmailWasDeleted extends StaffEmailsSuccess {}
// class StaffEmailsWereUpdated extends StaffEmailsState {
//   final List<BaseStaffEmail>? staffEmails;
//
//   const StaffEmailsWereUpdated(this.staffEmails);
//
//   @override
//   List<Object?> get props => [staffEmails];
// }

abstract class StaffEmailsEventProcessing extends StaffEmailsState {
  const StaffEmailsEventProcessing();
}

class AddStaffEmailProcessing extends StaffEmailsEventProcessing {
  const AddStaffEmailProcessing();
}

class UpdateStaffEmailProcessing extends StaffEmailsEventProcessing {
  const UpdateStaffEmailProcessing();
}

class DeleteStaffEmailProcessing extends StaffEmailsEventProcessing {
  const DeleteStaffEmailProcessing();
}

class StaffEmailsWereLoaded extends StaffEmailsState {
  final List<BaseStaffEmail>? staffEmails;
  const StaffEmailsWereLoaded(this.staffEmails);
  @override
  String toString() {
    return '''$runtimeType: Total(${staffEmails?.length})''';
  }

  @override
  List<Object?> get props => [staffEmails];
}

class LoadingStaffEmails extends StaffEmailsState {}

class StaffEmailErrorState extends StaffEmailsState {
  final BasicError error;

  const StaffEmailErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
