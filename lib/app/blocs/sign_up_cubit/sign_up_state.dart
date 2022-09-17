part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpError extends SignUpState {
  final BasicError error;

  const SignUpError(this.error);
  @override
  List<Object?> get props => [error];
}

class SignUpInProgress extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final BaseServerUser serverUser;

  const SignUpSuccess(this.serverUser);
  @override
  List<Object?> get props => [serverUser];
}

class SignUpEmailIsNotAuthorizedToRegister extends SignUpState {}

class SignUpEmailNotFound extends SignUpState {}

class SignUpPasswordIsIncorrect extends SignUpState {}