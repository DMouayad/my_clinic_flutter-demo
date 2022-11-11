part of "auth_bloc.dart";

mixin AuthEventsHelper {
  Future<AuthState> getLogoutState(BaseAuthRepository authRepository) async {
    return (await authRepository.logout()).mapTo(
      onSuccess: (_) => const AuthHasNoLoggedInUser(),
      onFailure: (error) => AuthErrorState(error),
    );
  }

  Future<AuthState> getSignUpState(
    BaseAuthRepository authRepository, {
    required String email,
    required String username,
    required String phoneNumber,
    required String password,
  }) async {
    final signUpResponse = await authRepository.register(
      email: email,
      name: username,
      phoneNumber: phoneNumber,
      password: password,
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

  Future<AuthState> getLoginState(
    BaseAuthRepository authRepository, {
    required String email,
    required String password,
  }) async {
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    return loginResponse.mapTo(
      onSuccess: (_) => const LoginSuccess(),
      onFailure: (error) {
        if (error.exception ==
            const ErrorException.invalidPasswordCredential()) {
          return LoginPasswordIsIncorrect();
        }
        if (error.exception == const ErrorException.invalidEmailCredential()) {
          return LoginEmailNotFound();
        }
        return LoginErrorState(error);
      },
    );
  }

  AuthState getAuthHasUserState(BaseServerUser? currentUser, AuthState state) {
    if (currentUser != null) {
      return AuthHasLoggedInUser(currentUser);
    } else {
      return const AuthHasNoLoggedInUser();
    }
  }

  Future<AuthState?> getAuthInitState(BaseAuthRepository authRepository) async {
    return (await authRepository.onInit()).mapTo(
        onSuccess: (_) => null,
        onFailure: (error) {
          switch (error.exception.runtimeType) {
            case NoAccessTokenFoundException:
              return const AuthHasNoLoggedInUser();
            case NoRefreshTokenFoundException:
            case FailedToRefreshAuthTokensException:
              return AuthHasNoLoggedInUser(error: error);
            default:
              return AuthInitFailed(error);
          }
        });
  }
}
