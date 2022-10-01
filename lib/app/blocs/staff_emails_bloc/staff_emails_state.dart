part of 'staff_emails_bloc.dart';

abstract class StaffEmailsState extends Equatable {
  const StaffEmailsState();

  @override
  List<Object?> get props => [];
}

class StaffEmailsInitial extends StaffEmailsState {}

class StaffEmailWasLoaded extends StaffEmailsState {
  final List<BaseStaffEmail>? staffEmails;

  const StaffEmailWasLoaded(this.staffEmails);

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
