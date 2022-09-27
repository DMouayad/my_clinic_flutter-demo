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
      (event, emit) => emit(_getAuthHasUserState()),
    );
    on<AuthInitRequested>((event, emit) async {
      (await authRepository.onInit()).fold(
        ifFailure: (error) => emit(AuthErrorState(error)),
      );
    });

    on<LoginRequested>(
      (event, emit) async {
        if (state != const LoginInProgress()) emit(const LoginInProgress());
        emit(await _login(event.email, event.password));
      },
    );

    on<SignUpRequested>(
      (event, emit) async {
        if (state != const SignUpInProgress()) emit(const SignUpInProgress());

        emit(await _signUp(
          email: event.email,
          username: event.username,
          phoneNumber: event.phoneNumber,
          password: event.password,
          themeMode: event.themeMode,
          locale: event.locale,
        ));
      },
    );
  }
  @override
  Future<void> close() async {
    await _authHasUserStreamSub.cancel();
    return super.close();
  }

  AuthState _getAuthHasUserState() {
    return authRepository.currentUser != null
        ? AuthHasLoggedInUser(authRepository.currentUser!)
        : const AuthHasNoLoggedInUser();
  }

  Future<AuthState> _login(String email, String password) async {
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    return loginResponse.mapTo(
      onSuccess: (user) => AuthHasLoggedInUser(user),
      onFailure: (error) {
        if (error.exception ==
            const ErrorException.invalidPasswordCredential()) {}
        return LoginErrorState(error);
      },
    );
  }

  Future<AuthState> _signUp({
    required String email,
    required String username,
    required String phoneNumber,
    required String password,
    required ThemeMode themeMode,
    required Locale locale,
  }) async {
    final signUpResponse = await authRepository.register(
      email: email,
      name: username,
      phoneNumber: phoneNumber,
      password: password,
      themeModePreference: themeMode,
      localePreference: locale,
    );

    return signUpResponse.mapTo(
      onSuccess: (result) => SignUpSuccess(authRepository.currentUser!),
      onFailure: (error) {
        if (error.exception is EmailUnauthorizedToRegisterException) {
          return const SignUpEmailIsNotAuthorizedToRegister();
        }
        return SignUpErrorState(error);
      },
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    Log.logBlocTransition(this, transition,
        logLevel: transition.nextState is AuthErrorState
            ? Level.warning
            : Level.info);
    super.onTransition(transition);
  }
}
