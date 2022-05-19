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
    final initResponse = await _initParse();
    if (initResponse.success) {
      emit(StartupSuccess());
    } else {
      if (initResponse.error?.code == ErrorCode.connectionNotFound.name ||
          (await Parse().checkConnectivity()) == ParseConnectivityResult.none) {
        retryToInitWhenConnectionIsRestored();
      }

      emit(
        StartupFailure(
          initResponse.error ??
              CustomError(
                message: "Couldn't connect to the server, try again later",
              ),
        ),
      );
    }
  }

  void retryToInitWhenConnectionIsRestored() {
    if (state is! StartupRetryInProgress) {
      final connectivityStream = Parse().connectivityStream.listen((event) {});

      connectivityStream.onData((connectivityResult) {
        if (connectivityResult != ParseConnectivityResult.none &&
            state is! StartupSuccess) {
          emit(StartupRetryInProgress());
          initServerConnection();
          connectivityStream.cancel();
        }
      });
    }
  }

  Future<CustomResponse<NoResult>> _initParse() async {
    return await ParseServer.init();
  }
}
