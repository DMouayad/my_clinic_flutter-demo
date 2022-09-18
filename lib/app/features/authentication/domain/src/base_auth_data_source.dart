import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:flutter/material.dart';

abstract class BaseAuthDataSource<T extends BaseServerUser> {
  Future<Result> register(
    String username,
    String email,
    String password,
    ThemeMode themeModePreference,
    Locale localePreference,
  );
  Future<Result> login(
    String email,
    String password,
  );
  Future<Result<T, BasicError>> loadUser();
  Future<Result<VoidResult, BasicError>> logout();
  Future<Result<VoidResult, BasicError>> requestPasswordReset(String email);
  Future<Result<VoidResult, BasicError>> sendVerificationEmail();
}
