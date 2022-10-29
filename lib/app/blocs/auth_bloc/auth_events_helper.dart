part of "auth_bloc.dart";

mixin AuthEventsHelper {
  Future<AuthState> logoutUser(BaseAuthRepository authRepository) async {
    return (await authRepository.logout()).mapTo(
      onSuccess: (_) => const AuthHasNoLoggedInUser(),
      onFailure: (error) => AuthErrorState(error),
    );
  }

  Future<AuthState> signUp(
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

  Future<AuthState> login(BaseAuthRepository authRepository,
      {required String email, required String password}) async {
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

  AuthState getAuthHasUserState(BaseServerUser? currentUser, AuthState state) {
    if (currentUser != null) {
      return AuthHasLoggedInUser(currentUser);
    } else {
      return const AuthHasNoLoggedInUser();
    }
  }

  Future<void> authInit(
    Emitter<AuthState> emit,
    BaseAuthRepository authRepository,
  ) async {
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
  }
}
