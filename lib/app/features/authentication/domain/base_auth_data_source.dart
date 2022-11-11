import 'package:clinic_v2/app/core/entities/result/result.dart';

import 'base_server_user.dart';

abstract class BaseAuthDataSource<T extends BaseServerUser> {
  Future<Result> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  });
  Future<Result> login(String email, String password);
  Future<Result<T, BasicError>> loadUser();
  Future<Result<VoidValue, BasicError>> logout();
  Future<Result<VoidValue, BasicError>> requestPasswordReset(String email);
  Future<Result<VoidValue, BasicError>> sendVerificationEmail();
}
