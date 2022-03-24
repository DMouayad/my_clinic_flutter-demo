import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/helpers/parse_server.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStepOne());

  Future<void> validateUserEmail(String emailAddress) async {
    emit(SignUpInProgress());
    final validationResponse =
        (await ParseServer.checkIfValidEmailAddress(emailAddress));
    if (!(validationResponse.result ?? false)) {
      emit(SignUpEmailIsNotValid());
    } else {
      _proceedToSignUpStepTwo(emailAddress);
    }
  }

  Future<void> _proceedToSignUpStepTwo(String emailAddress) async {
    final userRoleResponse =
        await ParseServer.getUserRole(emailAddress: emailAddress);
    if (userRoleResponse.success) {
      if (userRoleResponse.result != null) {
        emit(SignUpStepTwo(userRoleResponse.result!));
      } else {
        emit(
          SignUpError(
            userRoleResponse.error ??
                CustomError(
                  message:
                      'Error getting user role for this email address.\nRecommended action:\n'
                      'In admin panel Check that the email address "$emailAddress" was assigned a role',
                ),
          ),
        );
      }
    }
  }
}
