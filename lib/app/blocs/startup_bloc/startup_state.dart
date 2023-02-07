part of 'startup_bloc.dart';

abstract class StartupState extends Equatable {
  const StartupState();
  @override
  List<Object> get props => [];
}

class StartupInProgress extends StartupState {}

class StartupSuccess extends StartupState {}

class StartupFailure extends StartupState {
  final AppError error;

  const StartupFailure(this.error);
  @override
  List<Object> get props => [error];
  @override
  String toString() {
    return "Startup Failed: $error";
  }
}
