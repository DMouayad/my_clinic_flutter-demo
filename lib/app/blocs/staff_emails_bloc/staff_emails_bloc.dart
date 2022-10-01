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
    _repository.staffEmails.listen((list) => add(StaffEmailsWereUpdated(list)));

    on<StaffEmailsWereUpdated>((event, emit) {
      emit(StaffEmailWasLoaded(event.staffEmails));
    });

    on<FetchStaffEmails>((event, emit) async {
      if (state is! LoadingStaffEmails) {
        emit(LoadingStaffEmails());
      }
      (await _repository.getStaffEmails()).fold(
        ifFailure: (error) => emit(StaffEmailErrorState(error)),
      );
    });
  }

  @override
  void onTransition(Transition<StaffEmailsEvent, StaffEmailsState> transition) {
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
