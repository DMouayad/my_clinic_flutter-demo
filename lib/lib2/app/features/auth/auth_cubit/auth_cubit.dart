import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthInitial());
  final BaseAuthRepository authRepository;

  Future<void> getAuthState() async {
    if (authRepository.hasLoggedInUser()) {
      emit(const AuthHasLoggedInUser());
    } else {
      emit(const AuthHasNoLoggedInUser());
    }
  }

  Future<void> loadCurrentUserFromStorage() async {
    final Result = await authRepository.loadCurrentUser();
    if (SuccessResult) {
      emit(const StoredUserWasFetched());
    } else {
      emit(AuthError(ErrorResult!));
    }
  }

  Future<void> login(String username, String password) async {
    emit(const LoginInProgress());
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
            ErrorResult(message: 'Login failed, please try again..'),
      ));
    }
  }
}
