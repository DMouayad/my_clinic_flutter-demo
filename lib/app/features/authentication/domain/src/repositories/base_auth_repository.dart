import 'package:clinic_v2/app/core/entities/result/result.dart';

import '../entities/base_server_user.dart';

abstract class BaseAuthRepository<T extends BaseServerUser> {
  T? currentUser;

  bool get hasLoggedInUser => currentUser != null;

  Future<bool> init() async => true;

  Future<Result> register({
    required String emailAddress,
    required String username,
    required String password,
  });
  Future<Result> login({required String username, required String password});
  Future<Result> resetUserPassword(String emailAddress);
  Future<Result> logout();
}
