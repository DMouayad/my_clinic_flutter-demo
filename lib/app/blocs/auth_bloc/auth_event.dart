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
  final ThemeMode themeMode;
  final Locale locale;

  const SignUpRequested({
    required this.email,
    required this.username,
    required this.password,
    required this.themeMode,
    required this.locale,
  });
}

class AuthInitRequested extends AuthEvent {
  const AuthInitRequested();
}

class AuthHasUserStateChanged extends AuthEvent {
  const AuthHasUserStateChanged();
}
