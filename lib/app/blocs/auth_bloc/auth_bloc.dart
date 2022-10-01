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
  late final StreamSubscription<BaseServerUser?> _authHasUserStreamSub;

  AuthBloc(this.authRepository) : super(const AuthInitial()) {
    _authHasUserStreamSub = authRepository.hasLoggedInUser.listen((user) {
      if (state is! AuthInitFailed) {
        add(AuthStatusCheckRequested(user));
      }
    });

    on<AuthStatusCheckRequested>(
      (event, emit) => emit(_getAuthHasUserState(event.user)),
    );
    on<AuthInitRequested>((event, emit) async {
      emit(const AuthInitInProgress());
      (await authRepository.onInit()).fold(ifFailure: (error) {
        switch (error.exception.runtimeType) {
          case NoAccessTokenFoundException:
            emit(const AuthHasNoLoggedInUser());
            break;
          case NoRefreshTokenFoundException:
          case FailedToRefreshAuthTokensException:
            emit(AuthHasNoLoggedInUser(error: error));
            break;
          default:
            emit(AuthInitFailed(error));
            break;
        }
      });
    });

    on<LoginRequested>((event, emit) async {
      if (state != const LoginInProgress()) emit(const LoginInProgress());
      emit(await _login(event.email, event.password));
    });

    on<SignUpRequested>((event, emit) async {
      if (state != const SignUpInProgress()) emit(const SignUpInProgress());

      emit(await _signUp(
        email: event.email,
        username: event.username,
        phoneNumber: event.phoneNumber,
        password: event.password,
        themeMode: event.themeMode,
        locale: event.locale,
      ));
    });
    on<LogoutRequested>((event, emit) async {
      if (state is! LogoutInProgress) emit(const LogoutInProgress());
      emit(await _logoutUser());
    });
  }

  Future<AuthState> _logoutUser() async {
    return (await authRepository.logout()).mapTo(
      onSuccess: (_) => const AuthHasNoLoggedInUser(),
      onFailure: (error) => AuthErrorState(error),
    );
  }

  AuthState _getAuthHasUserState(BaseServerUser? currentUser) {
    if (state is! AuthHasLoggedInUser && currentUser != null) {
      return AuthHasLoggedInUser(currentUser);
    } else {
      if (state is! AuthHasNoLoggedInUser) {
        return const AuthHasNoLoggedInUser();
      } else {
        return state as AuthHasNoLoggedInUser;
      }
    }
  }

  Future<AuthState> _login(String email, String password) async {
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    return loginResponse.mapTo(
      onSuccess: (_) => const LoginSuccess(),
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
      onSuccess: (_) => const SignUpSuccess(),
      onFailure: (error) {
        if (error.exception is EmailUnauthorizedToRegisterException) {
          return SignUpEmailIsNotAuthorizedToRegister();
        }
        return SignUpErrorState(error);
      },
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    Log.logBlocTransition(this, transition);

    super.onTransition(transition);
  }

  @override
  Future<void> close() async {
    await _authHasUserStreamSub.cancel();
    return super.close();
  }
}
