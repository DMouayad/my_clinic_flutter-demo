part of 'auth_bloc.dart';

class LoginInProgress extends AuthState {
  const LoginInProgress();
}

class LoginErrorState extends AuthErrorState {
  const LoginErrorState(super.error);
}

class LoginEmailNotFound extends LoginErrorState {
  LoginEmailNotFound()
      : super(
          BasicError(exception: const ErrorException.invalidEmailCredential()),
        );
}

class LoginPasswordIsIncorrect extends LoginErrorState {
  LoginPasswordIsIncorrect()
      : super(
          BasicError(
            exception: const ErrorException.invalidPasswordCredential(),
          ),
        );
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}
