part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthHasLoggedInUser extends AuthState {}

class AuthHasNoLoggedInUser extends AuthState {}
