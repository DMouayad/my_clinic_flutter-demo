part of 'auth_bloc.dart';

class LoginInProgress extends AuthState {
  const LoginInProgress();
}

class LoginErrorState extends AuthErrorState {
  const LoginErrorState(super.error);
}

class LoginEmailNotFound extends LoginErrorState {
  const LoginEmailNotFound()
      : super(
          const BasicError(exception: ErrorException.invalidEmailCredential()),
        );
}

class LoginPasswordIsIncorrect extends LoginErrorState {
  const LoginPasswordIsIncorrect()
      : super(
          const BasicError(
              exception: ErrorException.invalidPasswordCredential()),
        );
}
