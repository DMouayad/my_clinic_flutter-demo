import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(SignUpInitialState());

  final BaseAuthRepository _authRepository;

  Future<void> submitStepOne({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(SignUpInProgress());
    final signUpResponse = await _authRepository.register(
      email: email,
      name: username,
      password: password,
    );

    signUpResponse.when(
      onSuccess: (result) => emit(SignUpSuccess(_authRepository.currentUser!)),
      onError: (error) {
        if (error.exception == ErrorException.emailUnauthorizedToRegister()) {
          emit(SignUpEmailIsNotAuthorizedToRegister());
        } else if (error.exception == ErrorException.invalidEmailCredential()) {
          emit(SignUpEmailNotFound());
        } else if (error.exception ==
            ErrorException.invalidPasswordCredential()) {
          emit(SignUpPasswordIsIncorrect());
        }
      },
    );
  }
}
