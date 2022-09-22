part of 'staff_emails_bloc.dart';

abstract class StaffEmailsEvent extends Equatable {
  const StaffEmailsEvent();
  @override
  List<Object?> get props => [];
}

class LoadStaffEmails extends StaffEmailsEvent {}
