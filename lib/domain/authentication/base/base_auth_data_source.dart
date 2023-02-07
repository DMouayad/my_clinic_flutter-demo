import 'package:clinic_v2/shared/models/result/result.dart';

import 'base_server_user.dart';

abstract class BaseAuthDataSource<T extends BaseServerUser> {
  Future<Result> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  });
  Future<Result> login(String email, String password);
  Future<Result<T?, AppError>> loadUser();
  Future<Result<VoidValue, AppError>> logout();
  Future<Result<VoidValue, AppError>> requestPasswordReset(String email);
  Future<Result<VoidValue, AppError>> sendVerificationEmail();
}
