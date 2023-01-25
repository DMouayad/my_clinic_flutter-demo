part of '../auth_bloc.dart';

class ResetAuthState extends AuthEvent {
  const ResetAuthState();

  @override
  Future<void> handle(
    BaseAuthRepository<BaseServerUser> repository,
    AuthState state,
    Emitter<AuthState> emit,
  ) async {
    (await repository.resetAuth()).fold(
      ifFailure: (error) => emit(AuthStateResetFailed(error)),
    );
  }
}
