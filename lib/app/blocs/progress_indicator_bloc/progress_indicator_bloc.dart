import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'progress_indicator_event.dart';
part 'progress_indicator_state.dart';

class ProgressIndicatorBloc
    extends Bloc<ProgressIndicatorEvent, ProgressIndicatorState> {
  StreamSubscription<int>? _tickerSubscription;
  Stream<int>? _ticker;

  ProgressIndicatorBloc() : super(const ProgressIndicatorInitial()) {
    on<ShowIndicatorRequested>((event, emit) async {
      emit(ProgressIndicatorIsVisible(event.duration));
      _startTimer(event.duration);
    }, transformer: restartable());
    on<HideIndicatorRequested>(
      (event, emit) => emit(const ProgressIndicatorIsHidden()),
    );

    on<ResetIndicatorDurationRequested>((event, emit) async {
      await _tickerSubscription?.cancel();
      _ticker = const Stream.empty();
      emit(ProgressIndicatorIsVisible(event.duration));
      _startTimer(event.duration);
    });
  }

  void _startTimer(Duration duration) async {
    _ticker = TimeTicker.tick(duration.inSeconds);
    _tickerSubscription = _ticker?.listen((ticks) async {
      if (ticks == 0) {
        add(const HideIndicatorRequested());
      } else {}
    });
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

class TimeTicker {
  static Stream<int> tick(int ticksCount) {
    return Stream.periodic(
        const Duration(seconds: 1), (x) => ticksCount - x - 1).take(ticksCount);
  }
}
