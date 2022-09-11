import 'package:clinic_v2/app/core/entities/result/base_error.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';

class MyClinicApiAuthRepository extends BaseAuthRepository {
  final Base
  @override
  Future<Result<Object, BaseError>> login(
      {required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<Object, BaseError>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<Object, BaseError>> register(
      {required String emailAddress,
      required String username,
      required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<Object, BaseError>> resetUserPassword(String emailAddress) {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }
}
