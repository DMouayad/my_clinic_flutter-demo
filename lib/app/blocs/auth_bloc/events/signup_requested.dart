part of '../auth_bloc.dart';

class SignUpRequested extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String phoneNumber;

  const SignUpRequested({
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  @override
  Future<void> handle(
    BaseAuthRepository repository,
    AuthState state,
    Emitter<AuthState> emit,
  ) async {
    if (state != const SignUpInProgress()) emit(const SignUpInProgress());

    final signUpResponse = await repository.register(
      email: email,
      name: username,
      phoneNumber: phoneNumber,
      password: password,
    );

    final signUpState = signUpResponse.mapTo(
      onSuccess: (_) => const SignUpSuccess(),
      onFailure: (error) {
        if (error.appException == AppException.emailUnauthorizedToRegister) {
          return EmailNotAuthorizedToRegister();
        }
        if (error.appException == AppException.emailAlreadyRegistered) {
          return EmailAlreadySignedUp();
        }

        return SignUpErrorState(error);
      },
    );
    emit(signUpState);
  }
}
