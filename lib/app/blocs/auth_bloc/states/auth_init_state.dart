part of '../../../../../app/blocs/auth_bloc/auth_bloc.dart';

class AuthInitFailed extends AuthErrorState {
  const AuthInitFailed(super.error);
}

class AuthInitInProgress extends AuthState {
  const AuthInitInProgress();
}

class AuthInitRetryInProgress extends AuthState {
  const AuthInitRetryInProgress();
}
