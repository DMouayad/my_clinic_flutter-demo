import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/helpers/parse_server.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:equatable/equatable.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInProgress());

  Future<void> initParse() async {
    final response = await ParseServer.init();
    if (response.success) {
      emit(StartupSuccess());
    } else {
      emit(
        StartupFailure(
          response.error ??
              CustomError(
                message: "Couldn't connect to the server, try again later",
              ),
        ),
      );
    }
  }
}
