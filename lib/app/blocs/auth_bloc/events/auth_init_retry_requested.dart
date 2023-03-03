part of '../auth_bloc.dart';

class AuthInitRetryRequested extends AuthEvent {
  const AuthInitRetryRequested();

  @override
  Future<void> handle(
    BaseAuthRepository repository,
    AuthState state,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthInitInProgress && state is! AuthInitRetryInProgress) {
      emit(const AuthInitRetryInProgress());
    }

    final authInitState = (await repository.onInit()).mapTo(
      onSuccess: (_) => null,
      onFailure: (error) => AuthInitFailed(error),
    );
    if (authInitState != null) {
      emit(authInitState);
    }
  }
}
