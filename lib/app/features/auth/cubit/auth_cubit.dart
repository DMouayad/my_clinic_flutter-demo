import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthHasNoLoggedInUser());
  final BaseAuthRepository authRepository;

  Future<void> loadCurrentUser() async {
    await authRepository.init();
    if (authRepository.hasLoggedInUser()) {
      emit(AuthHasLoggedInUser());
    } else {
      emit(AuthHasNoLoggedInUser());
    }
  }
}
