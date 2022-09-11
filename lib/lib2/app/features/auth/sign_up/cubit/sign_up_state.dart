part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpError extends SignUpState {
  final BaseError error;

  const SignUpError(this.error);
  @override
  List<Object?> get props => [error];
}

class SignUpStepOne extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpStepTwo extends SignUpState {
  final BaseServerUser serverUser;

  const SignUpStepTwo(this.serverUser);
  @override
  List<Object?> get props => [serverUser];
}

class SignUpEmailIsNotValid extends SignUpState {}

class SignUpEmailIsValid extends SignUpState {}
