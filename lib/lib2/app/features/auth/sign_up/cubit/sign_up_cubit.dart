import 'package:clinic_v2/common/common/helpers/parse_server.dart';
import 'package:clinic_v2/common/common/entities/custom_error.dart';
import 'package:clinic_v2/common/common/entities/custom_response.dart';
import 'package:clinic_v2/common/common/utilities/enums.dart';
import 'package:clinic_v2/common/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/common/features/users/data/dentist_data.dart';
import 'package:clinic_v2/common/features/users/domain/dentist_contracts.dart';
import 'package:clinic_v2/common/features/users/domain/src/entities/base_server_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpStepOne());

  Future<void> submitStepOne({
    required String emailAddress,
    required String username,
    required String password,
  }) async {
    // check if provided email address is approved by CLINIC's admin.

    final validationResponse = await _validateUserEmail(emailAddress);
    if (validationResponse.success) {
      final isValid = validationResponse.result ?? false;
      if (isValid) {
        _proceedToSignUpStepTwo(
          emailAddress: emailAddress,
          username: username,
          password: password,
        );
      } else {
        emit(SignUpEmailIsNotValid());
      }
    } else {
      emit(SignUpError(validationResponse.error!));
    }
  }

  Future<Result<bool>> _validateUserEmail(String emailAddress) async {
    emit(SignUpInProgress());
    return await ParseServer.checkIfEmailAddressIsValid(emailAddress);
  }

  Future<void> _proceedToSignUpStepTwo({
    required String emailAddress,
    required String username,
    required String password,
  }) async {
    emit(SignUpInProgress());
    //
    final userRoleResponse =
        await ParseServer.getUserRole(emailAddress: emailAddress);
    if (userRoleResponse.success) {
      if (userRoleResponse.result != null) {
        emit(
          SignUpStepTwo(
            CustomParseUser(
              role: userRoleResponse.result!,
              username: username,
              emailAddress: emailAddress,
            ),
          ),
        );
      } else {
        emit(
          SignUpError(
            userRoleResponse.error ??
                ErrorResult(
                  message:
                      'Error getting user role for the user with the provided email address.'
                      '\nRecommended action:\n'
                      'In admin panel: check that this user was assigned a role',
                ),
          ),
        );
      }
    } else {
      emit(
        SignUpError(
          ErrorResult(
            message: userRoleResponse.error?.message ??
                'An unexpected error have happened, please try again',
          ),
        ),
      );
    }
  }

  Future<void> finishDentistSignUpProcess(BaseDentist baseDentist) async {
    var serverUser = (state as SignUpStepTwo).serverUser as CustomParseUser;
    emit(SignUpInProgress());

    assert(serverUser.role == UserRole.dentist);
    final ParseDentist newDentist = ParseDentist(
      dentalServices: baseDentist.dentalServices,
      medicationsList: baseDentist.medicationsList,
      selectedLocale: baseDentist.selectedLocale,
      selectedThemeMode: baseDentist.selectedThemeMode,
      isLoggedIn: true,
      calendar: baseDentist.calendar,
    );
    final response = await newDentist.create();
    if (response.success) {
      serverUser = serverUser.copy(
          appUserId: (response.results?.first as ParseUser).objectId);
      await serverUser.save();
    }
  }
}