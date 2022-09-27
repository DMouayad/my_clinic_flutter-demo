import 'dart:async';

import 'package:clinic_v2/app/core/entities/result/basic_error.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_emails_event.dart';
part 'staff_emails_state.dart';

class StaffEmailsBloc extends Bloc<StaffEmailsEvent, StaffEmailsState> {
  final BaseStaffEmailRepository _repository;

  StaffEmailsBloc(this._repository) : super(StaffEmailsInitial()) {
    on<GetStaffEmails>((event, emit) async {
      if (state is! LoadingStaffEmails) {
        emit(LoadingStaffEmails());
      }
      emit(await _loadStaffEmails());
    });
  }

  Future<StaffEmailsState> _loadStaffEmails() async {
    return (await _repository.getStaffEmails()).when(
      onSuccess: (result) {
        return StaffEmailWasLoaded(_repository.staffEmails!);
      },
      onError: (error) => StaffEmailErrorState(error),
    );
  }

  @override
  void onTransition(Transition<StaffEmailsEvent, StaffEmailsState> transition) {
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
