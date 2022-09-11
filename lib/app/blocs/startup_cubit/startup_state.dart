part of 'startup_cubit.dart';

abstract class StartupState extends Equatable {
  const StartupState();
  @override
  List<Object> get props => [];
}

class StartupInProgress extends StartupState {}

class StartupSuccess extends StartupState {}

class StartupFailure extends StartupState {
  final BaseError error;

  const StartupFailure(this.error);
  @override
  List<Object> get props => [error];
}
