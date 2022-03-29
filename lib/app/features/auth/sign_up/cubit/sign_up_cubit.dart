import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/helpers/parse_server.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/core/features/users/domain/src/entities/base_server_user.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStepOne());

  Future<void> submitStepOne({
    required String emailAddress,
    required String username,
    required String password,
  }) async {
    _validateUserEmail(emailAddress);
    if (state is SignUpEmailIsValid) {
      _proceedToSignUpStepTwo(
        emailAddress: emailAddress,
        username: username,
        password: password,
      );
    }
  }

  Future<void> _validateUserEmail(String emailAddress) async {
    emit(SignUpInProgress());
    final validationResponse =
        await ParseServer.checkIfEmailAddressIsValid(emailAddress);

    if (validationResponse.success) {
      if ((validationResponse.result ?? false)) {
        emit(SignUpEmailIsValid());
      } else {
        emit(SignUpEmailIsNotValid());
      }
    } else {
      emit(SignUpError(validationResponse.error!));
    }
  }

  Future<void> _proceedToSignUpStepTwo({
    required String emailAddress,
    required String username,
    required String password,
  }) async {
    final userRoleResponse =
        await ParseServer.getUserRole(emailAddress: emailAddress);
    if (userRoleResponse.success) {
      if (userRoleResponse.result != null) {
        emit(SignUpStepTwo(
          CustomParseUser(
            role: userRoleResponse.result!,
            username: username,
            emailAddress: emailAddress,
          ),
        ));
      } else {
        emit(
          SignUpError(
            userRoleResponse.error ??
                CustomError(
                  message:
                      'Error getting user role for the user with the provided email address.\nRecommended action:\n'
                      'In admin panel: check that this user was assigned a role',
                ),
          ),
        );
      }
    }
  }
}
