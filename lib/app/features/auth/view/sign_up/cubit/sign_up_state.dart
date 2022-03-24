part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpError extends SignUpState {
  final CustomError error;

  const SignUpError(this.error);
  @override
  List<Object?> get props => [error];
}

class SignUpStepOne extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpStepTwo extends SignUpState {
  final UserRole userRole;

  const SignUpStepTwo(this.userRole);
  @override
  List<Object?> get props => [userRole];
}

class SignUpEmailIsNotValid extends SignUpState {}
