part of '../auth_bloc.dart';

class AuthStatusCheckRequested extends AuthEvent {
  final BaseServerUser? user;

  const AuthStatusCheckRequested(this.user);

  @override
  Future<void> handle(BaseAuthRepository<BaseServerUser> repository,
      AuthState state, Emitter<AuthState> emit) async {
    if (user != null) {
      emit(AuthHasLoggedInUser(user!));
    } else if (state is! AuthHasNoLoggedInUser) {
      emit(const AuthHasNoLoggedInUser());
    }
  }
}
