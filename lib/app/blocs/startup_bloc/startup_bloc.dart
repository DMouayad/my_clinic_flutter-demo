import 'dart:async';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/services/startup/base_startup_service.dart';

part 'startup_state.dart';
part 'startup_event.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final BaseStartupService _startupService;

  StartupBloc(this._startupService) : super(StartupInProgress()) {
    _startupService.startupStatusResult?.listen((result) {
      add(StartupStateChangeRequested(result));
    });
    on<InitializeStartupEvent>((event, emit) async {
      if (state is! StartupInProgress) emit(StartupInProgress());
      emit(await _initStartup());
    });
    on<StartupStateChangeRequested>(((event, emit) {
      emit(_getStartupState(event.result));
    }));
  }

  Future<StartupState> _initStartup() async {
    final initResult = await _startupService.init();
    return _getStartupState(initResult);
  }

  StartupState _getStartupState(Result? result) {
    return result?.when(
            onSuccess: (_) => StartupSuccess(),
            onError: (error) => StartupFailure(error)) ??
        const StartupFailure(BasicError(message: 'An error occurred'));
  }
}
