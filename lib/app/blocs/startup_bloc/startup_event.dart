part of 'startup_bloc.dart';

abstract class StartupEvent {
  const StartupEvent();
}

class InitializeStartupEvent extends StartupEvent {}

class StartupStateChangeRequested extends StartupEvent {
  final Result result;

  const StartupStateChangeRequested(this.result);
}