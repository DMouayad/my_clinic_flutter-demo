import 'package:clinic_v2/app/core/entities/result/result.dart';

abstract class BaseAuthDataSource {
  Future<Result> register(
    String username,
    String email,
    String password,
  );
  Future<Result> login(
    String email,
    String password,
  );
  Future<Result<VoidResult, BasicError>> loadUser();
  Future<Result<VoidResult, BasicError>> logout();
  Future<Result<VoidResult, BasicError>> requestPasswordReset(String email);
  Future<Result<VoidResult, BasicError>> sendVerificationEmail();
}
