part of 'auth_bloc.dart';

abstract class SignUpState extends AuthState {
  const SignUpState();
}

class SignUpInitialState extends SignUpState {}

class SignUpErrorState extends AuthErrorState {
  const SignUpErrorState(super.error);
}

class SignUpInProgress extends SignUpState {
  const SignUpInProgress();
}

class SignUpSuccess extends SignUpState {
  final BaseServerUser serverUser;

  const SignUpSuccess(this.serverUser);
  @override
  List<Object> get props => [serverUser];
}

class SignUpEmailIsNotAuthorizedToRegister extends SignUpErrorState {
  const SignUpEmailIsNotAuthorizedToRegister()
      : super(
          const BasicError(
              exception: ErrorException.emailUnauthorizedToRegister()),
        );
}
