part of '../auth_bloc.dart';

class AuthInitRequested extends AuthEvent {
  const AuthInitRequested();

  @override
  Future<void> handle(BaseAuthRepository<BaseServerUser> repository,
      AuthState state, Emitter<AuthState> emit) async {
    if (state != const AuthInitInProgress()) emit(const AuthInitInProgress());

    final authInitState = (await repository.onInit()).mapTo(
      onSuccess: (_) => null,
      onFailure: (error) {
        if (error.appException != AppException.noAccessTokenFound) {
          return AuthInitFailed(error);
        }
      },
    );
    if (authInitState != null) {
      emit(authInitState);
    }
  }
}
