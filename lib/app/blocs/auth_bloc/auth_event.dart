part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String phoneNumber;

  const SignUpRequested({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });
}

class AuthInitRequested extends AuthEvent {
  const AuthInitRequested();
}

class AuthStatusCheckRequested extends AuthEvent {
  final BaseServerUser? user;

  const AuthStatusCheckRequested(this.user);
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ResetAuthState extends AuthEvent {
  const ResetAuthState();
}
