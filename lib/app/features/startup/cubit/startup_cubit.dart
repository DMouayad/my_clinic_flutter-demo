import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/helpers/parse_server.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInProgress());

  Future<void> initServerConnection() async {
    final intiResponse = await initParse();

    if (intiResponse.success) {
      emit(StartupSuccess());
    } else {
      emit(
        StartupFailure(
          intiResponse.error ??
              CustomError(
                message: "Couldn't connect to the server, try again later",
              ),
        ),
      );
    }
  }

  Future<CustomResponse<ParseResponse>> initParse() async {
    return await ParseServer.init();
  }
}
