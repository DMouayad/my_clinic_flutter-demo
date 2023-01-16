import 'dart:async';

//
import 'package:clinic_v2/app/services/base_startup_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';

part 'startup_state.dart';

part 'startup_event.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  final BaseStartupService _startupService;
  late final StreamSubscription<Result>? _startupResultStreamSubscription;

  StartupBloc(this._startupService) : super(StartupInProgress()) {
    _startupResultStreamSubscription =
        _startupService.startupResultStream?.listen((result) {
      add(StartupStateChangeRequested(result));
    });
    on<StartupInitRequested>((event, emit) async {
      if (state is! StartupInProgress) emit(StartupInProgress());
      emit(await _initStartup());
    });
    on<StartupStateChangeRequested>(((event, emit) {
      final newState = _getStartupState(event.result);
      if (newState != state) {
        emit(newState);
      }
    }));
  }

  Future<StartupState> _initStartup() async {
    final initResult = await _startupService.init();
    return _getStartupState(initResult);
  }

  StartupState _getStartupState(Result? result) {
    return result!.mapTo(
      onSuccess: (_) {
        // cancel subscription since startup process is finished
        _startupResultStreamSubscription?.cancel();
        return StartupSuccess();
      },
      onFailure: (error) => StartupFailure(error),
    );
  }

  @override
  void onTransition(Transition<StartupEvent, StartupState> transition) {
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
