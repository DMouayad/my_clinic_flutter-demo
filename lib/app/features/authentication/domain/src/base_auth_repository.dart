import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/src/base_user_preferences.dart';

import 'base_server_user.dart';

abstract class BaseAuthRepository<T extends BaseServerUser> {
  T? currentUser;
  void setCurrentUser(T user);

  Stream<bool> get hasLoggedInUser;

  Future<Result<T, BasicError>> onInit();

  Future<Result<VoidResult, BasicError>> register({
    required String email,
    required String name,
    required String password,
  });
  Future<Result<T, BasicError>> login({
    required String email,
    required String password,
  });
  Future<Result<VoidResult, BasicError>> requestPasswordReset(
    String emailAddress,
  );
  Future<Result<VoidResult, BasicError>> requestVerificationEmail();
  Future<Result<VoidResult, BasicError>> logout();
}
