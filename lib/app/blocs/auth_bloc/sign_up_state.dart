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
  const SignUpSuccess();
}

class SignUpEmailIsNotAuthorizedToRegister extends SignUpErrorState {
  SignUpEmailIsNotAuthorizedToRegister()
      : super(
          BasicError(
            exception: const ErrorException.emailUnauthorizedToRegister(),
          ),
        );
}
