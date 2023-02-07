import 'package:clinic_v2/shared/models/result/result.dart';
import 'base_server_user.dart';

abstract class BaseAuthRepository<U extends BaseServerUser> {
  Stream<U?> get usersStream;

  U? get currentUser;

  Future<Result<VoidValue, AppError>> onInit();

  Future<Result<VoidValue, AppError>> register({
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
  });

  Future<Result<VoidValue, AppError>> login({
    required String email,
    required String password,
  });

  Future<Result<VoidValue, AppError>> requestPasswordReset(String emailAddress);

  Future<Result<VoidValue, AppError>> requestVerificationEmail();

  Future<Result<VoidValue, AppError>> logout();

  Future<Result<VoidValue, AppError>> resetAuth();
}
