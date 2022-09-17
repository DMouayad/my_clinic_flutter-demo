import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthInitial()) {
    authRepository.hasLoggedInUser.listen((hasUser) {
      if (hasUser) {
        emit(AuthHasLoggedInUser(authRepository.currentUser!));
      } else {
        emit(const AuthHasNoLoggedInUser());
      }
    });
  }
  final BaseAuthRepository authRepository;

  Future<void> init() async {
    (await authRepository.onInit()).when(
      onSuccess: (result) => emit(UserWasLoaded(result)),
      onError: (error) => emit(AuthError(error)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(const LoginInProgress());
    final loginResponse = await authRepository.login(
      email: email,
      password: password,
    );
    loginResponse.when(
      onSuccess: (user) => emit(AuthHasLoggedInUser(user)),
      onError: (error) => emit(AuthError(error)),
    );
  }
}
