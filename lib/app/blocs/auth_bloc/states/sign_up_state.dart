part of '../auth_bloc.dart';

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

class EmailNotAuthorizedToRegister extends SignUpErrorState {
  EmailNotAuthorizedToRegister()
      : super(
          BasicError(
            exception: const ErrorException.emailUnauthorizedToRegister(),
          ),
        );
}

class EmailAlreadySignedUp extends SignUpErrorState {
  EmailAlreadySignedUp()
      : super(
          BasicError(
            exception: const ErrorException.emailAlreadyRegistered(),
          ),
        );
}
