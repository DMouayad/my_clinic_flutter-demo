import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_emails_event.dart';
part 'staff_emails_state.dart';

class StaffEmailsBloc extends Bloc<StaffEmailsEvent, StaffEmailsState> {
  StaffEmailsBloc() : super(StaffEmailsInitial()) {
    on<StaffEmailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
