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
          AppError(appException: AppException.invalidEmailCredential),
        );
}

class LoginPasswordIsIncorrect extends LoginErrorState {
  LoginPasswordIsIncorrect()
      : super(
          AppError(appException: AppException.invalidPasswordCredential),
        );
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}
