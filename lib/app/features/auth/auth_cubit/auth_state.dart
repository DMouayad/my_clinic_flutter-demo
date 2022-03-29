part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class StoredUserWasFetched extends AuthState {
  const StoredUserWasFetched();
}

class AuthError extends AuthState {
  final CustomError error;
  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthHasLoggedInUser extends AuthState {
  const AuthHasLoggedInUser();
  // final BaseServerUser currentUser;
  // const AuthHasLoggedInUser(this.currentUser);
  // @override
  // List<Object> get props => [currentUser];
}

class AuthHasNoLoggedInUser extends AuthState {
  const AuthHasNoLoggedInUser();
}
