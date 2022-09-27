import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:flutter/material.dart';
import 'base_server_user.dart';

abstract class BaseAuthRepository<U extends BaseServerUser> {
  U? currentUser;
  void setCurrentUser(U user);

  Stream<bool> get hasLoggedInUser;

  Future<Result<VoidValue, BasicError>> onInit();

  Future<Result<VoidValue, BasicError>> register({
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
    required ThemeMode themeModePreference,
    required Locale localePreference,
  });
  Future<Result<U, BasicError>> login({
    required String email,
    required String password,
  });
  Future<Result<VoidValue, BasicError>> requestPasswordReset(
    String emailAddress,
  );
  Future<Result<VoidValue, BasicError>> requestVerificationEmail();
  Future<Result<VoidValue, BasicError>> logout();
}
