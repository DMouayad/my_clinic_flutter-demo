import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthInitial());
  final BaseAuthRepository authRepository;

  Future<void> loadCurrentUser() async {
    await authRepository.init();
    if (authRepository.hasLoggedInUser()) {
      emit(const AuthHasLoggedInUser());
      // emit(AuthHasLoggedInUser(authRepository.currentUser!));
    } else {
      emit(const AuthHasNoLoggedInUser());
    }
  }

  Future<void> login(String username, String password) async {
    final loginResponse = await authRepository.login(
      username: username,
      password: password,
    );
    if (loginResponse.success) {
      emit(const AuthHasLoggedInUser());
      // emit(AuthHasLoggedInUser(authRepository.currentUser!));
    } else {
      emit(AuthError(
        loginResponse.error ??
            CustomError(message: 'Login failed, please try again..'),
      ));
    }
  }
}
