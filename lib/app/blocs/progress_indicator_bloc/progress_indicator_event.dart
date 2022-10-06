part of 'progress_indicator_bloc.dart';

abstract class ProgressIndicatorEvent extends Equatable {
  const ProgressIndicatorEvent();
  @override
  List<Object?> get props => [];
}

class ShowIndicatorRequested extends ProgressIndicatorEvent {
  final Duration duration;
  const ShowIndicatorRequested(this.duration);

  @override
  List<Object?> get props => [duration];
}

class HideIndicatorRequested extends ProgressIndicatorEvent {
  const HideIndicatorRequested();
}

class ResetIndicatorDurationRequested extends ProgressIndicatorEvent {
  final Duration duration;
  const ResetIndicatorDurationRequested(this.duration);

  @override
  List<Object?> get props => [duration];
}
