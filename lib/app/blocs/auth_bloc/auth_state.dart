part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class LoginInProgress extends AuthState {
  const LoginInProgress();
}

class AuthError extends AuthState {
  final BasicError error;
  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthHasLoggedInUser extends AuthState {
  final BaseServerUser currentUser;
  const AuthHasLoggedInUser(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}

class AuthHasNoLoggedInUser extends AuthState {
  const AuthHasNoLoggedInUser();
}
