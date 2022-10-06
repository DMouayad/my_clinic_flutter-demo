part of 'progress_indicator_bloc.dart';

abstract class ProgressIndicatorState extends Equatable {
  const ProgressIndicatorState(this.duration);
  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

class ProgressIndicatorInitial extends ProgressIndicatorState {
  const ProgressIndicatorInitial() : super(const Duration());
}

class ProgressIndicatorIsVisible extends ProgressIndicatorState {
  const ProgressIndicatorIsVisible(super.duration);
  @override
  String toString() {
    return 'ProgressIndicatorIsVisible<time remaining: $duration>';
  }
}

class ProgressIndicatorIsHidden extends ProgressIndicatorState {
  const ProgressIndicatorIsHidden() : super(const Duration());
}
