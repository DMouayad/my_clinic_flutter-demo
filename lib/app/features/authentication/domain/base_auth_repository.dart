import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'base_server_user.dart';

abstract class BaseAuthRepository<U extends BaseServerUser> {
  Stream<U?> get usersStream;
  U? get currentUser;
  Future<Result<VoidValue, BasicError>> onInit();

  Future<Result<VoidValue, BasicError>> register({
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
  });
  Future<Result<VoidValue, BasicError>> login({
    required String email,
    required String password,
  });
  Future<Result<VoidValue, BasicError>> requestPasswordReset(
    String emailAddress,
  );
  Future<Result<VoidValue, BasicError>> requestVerificationEmail();
  Future<Result<VoidValue, BasicError>> logout();
}
