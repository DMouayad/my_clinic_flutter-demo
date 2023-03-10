import 'package:clinic_v2/domain/authentication/base/base_auth_repository.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../../../app/blocs/email_verification_cubit/email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this._authRepository)
      : super(const EmailVerificationInitial());
  final BaseAuthRepository _authRepository;

  Future<void> requestForCurrentUser() async {
    emit(const RequestingVerificationEmail());
    (await _authRepository.requestVerificationEmail()).fold(
      ifSuccess: (_) {
        emit(const VerificationEmailWasSent());
        Future.delayed(const Duration(seconds: 8), () {
          emit(const EmailVerificationInitial());
        });
      },
      ifFailure: (error) => emit(VerificationEmailRequestFailed(error)),
    );
  }
}
