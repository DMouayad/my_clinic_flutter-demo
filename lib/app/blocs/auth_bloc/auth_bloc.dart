import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';

part 'auth_state.dart';
part 'sign_up_state.dart';
part 'auth_event.dart';

/// Manages
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository authRepository;

  AuthBloc(this.authRepository) : super(const AuthInitial()) {
    authRepository.hasLoggedInUser.listen((_) {
      print(_);
      add(const AuthHasUserStateChanged());
    });

    on<AuthHasUserStateChanged>((event, emit) => emit(_getAuthHasUserState()));
    on<AuthInitRequested>((event, emit) async => emit(await _initAuth()));
    on<LoginRequested>(
      (event, emit) async => emit(await _login(event.email, event.password)),
    );

    on<SignUpRequested>(
      (event, emit) async {
        emit(await _signUp(event.email, event.username, event.password,
            event.themeMode, event.locale));
      },
    );
  }

  AuthState _getAuthHasUserState() {
    return authRepository.currentUser != null
        ? AuthHasLoggedInUser(authRepository.currentUser!)
        : const AuthHasNoLoggedInUser();
  }

  Future<AuthState> _initAuth() async {
    return (await authRepository.onInit()).when(
      onSuccess: (BaseServerUser result) => AuthHasLoggedInUser(result),
      onError: (BasicError error) => AuthHasNoLoggedInUser(),
    );
  }

  Future<AuthState> _login(String email, String password) async {
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    return loginResponse.when(
      onSuccess: (user) => AuthHasLoggedInUser(user),
      onError: (error) => AuthError(error),
    );
  }

  Future<AuthState> _signUp(
    String email,
    String username,
    String password,
    ThemeMode themeMode,
    Locale locale,
  ) async {
    final signUpResponse = await authRepository.register(
      email: email,
      name: username,
      password: password,
      themeModePreference: themeMode,
      localePreference: locale,
    );

    return signUpResponse.when(
      onSuccess: (result) => SignUpSuccess(authRepository.currentUser!),
      onError: (error) {
        if (error.exception == ErrorException.emailUnauthorizedToRegister()) {
          SignUpEmailIsNotAuthorizedToRegister();
        } else if (error.exception == ErrorException.invalidEmailCredential()) {
          SignUpEmailNotFound();
        } else if (error.exception ==
            ErrorException.invalidPasswordCredential()) {
          SignUpPasswordIsIncorrect();
        }
        return SignUpError(error);
      },
    );
  }
}
