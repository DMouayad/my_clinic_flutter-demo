part of '../auth_bloc.dart';

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  Future<void> handle(BaseAuthRepository<BaseServerUser> repository,
      AuthState state, Emitter<AuthState> emit) async {
    if (state != const LoginInProgress()) emit(const LoginInProgress());
    await getLoginState(
      repository,
      email: email,
      password: password,
    ).then((state) => emit(state));
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
        if (error.appException == AppException.invalidPasswordCredential) {
          return LoginPasswordIsIncorrect();
        }
        if (error.appException == AppException.invalidEmailCredential) {
          return LoginEmailNotFound();
        }
        return LoginErrorState(error);
      },
    );
  }
}
