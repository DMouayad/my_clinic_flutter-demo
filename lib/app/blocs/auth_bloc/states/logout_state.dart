part of '../../../../../app/blocs/auth_bloc/auth_bloc.dart';

class LogoutInProgress extends AuthState {
  const LogoutInProgress();
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

class LogoutFailed extends AuthState {
  const LogoutFailed(this.error);
  final BasicError error;

  @override
  List<Object> get props => [error];
}
