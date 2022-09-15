import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinic_v2/app/core/entities/result/basic_error.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/startup/base_startup_service.dart';
import 'package:equatable/equatable.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  final BaseStartupService _startupService;

  StartupCubit(this._startupService) : super(StartupInProgress()) {
    // listen to changes of the startupService and emit the matched status.
    _startupService.onStartupStatusChanged
        ?.listen((event) => _handleStartupResult(event));
  }

  Future<void> initStartup() async {
    if (state is! StartupInProgress) emit(StartupInProgress());
    final initResponse = await _startupService.init();
    _handleStartupResult(initResponse);
  }

  void _handleStartupResult(Result? result) {
    result?.when(onSuccess: (_) {
      emit(StartupSuccess());
    }, onError: (error) {
      emit(StartupFailure(error));
    });
  }
}
