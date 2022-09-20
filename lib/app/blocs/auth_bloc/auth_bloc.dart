import 'dart:async';

import 'package:clinic_v2/app/services/logger_service.dart';
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
part 'login_state.dart';

/// Manages
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository authRepository;
  late final StreamSubscription<bool> _authHasUserStreamSub;

  AuthBloc(this.authRepository) : super(const AuthInitial()) {
    _authHasUserStreamSub = authRepository.hasLoggedInUser.listen((_) {
      add(const AuthStatusChangeRequested());
    });

    on<AuthStatusChangeRequested>(
        (event, emit) => emit(_getAuthHasUserState()));
    on<AuthInitRequested>((event, emit) async => emit(await _initAuth()));

    on<LoginRequested>(
      (event, emit) async {
        if (state != const LoginInProgress()) emit(const LoginInProgress());
        emit(await _login(event.email, event.password));
      },
    );

    on<SignUpRequested>(
      (event, emit) async {
        if (state != const SignUpInProgress()) emit(const SignUpInProgress());

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
      onError: (BasicError error) => const AuthHasNoLoggedInUser(),
    );
  }

  Future<AuthState> _login(String email, String password) async {
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    return loginResponse.when(
      onSuccess: (user) => AuthHasLoggedInUser(user),
      onError: (error) {
        if (error.exception == ErrorException.invalidPasswordCredential()) {}
        return LoginErrorState(error);
      },
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
        if (error.exception is EmailUnauthorizedToRegisterException) {
          return SignUpEmailIsNotAuthorizedToRegister();
        }
        return SignUpErrorState(error);
      },
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // Log.i(
    //   "AuthBloc transition: From [${transition.currentState}] "
    //   "To [${transition.nextState}] By event [${transition.event.runtimeType}]",
    // );
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
