part of '../auth_bloc.dart';

class LoginInProgress extends AuthState {
  const LoginInProgress();
}

class LoginErrorState extends AuthErrorState {
  const LoginErrorState(super.error);
}

class LoginEmailNotFound extends LoginErrorState {
  LoginEmailNotFound()
      : super(
          AppError(appException: const AppException.invalidEmailCredential()),
        );
}

class LoginPasswordIsIncorrect extends LoginErrorState {
  LoginPasswordIsIncorrect()
      : super(
          AppError(
            appException: const AppException.invalidPasswordCredential(),
          ),
        );
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}
