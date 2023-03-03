import 'dart:async';

import 'package:clinic_v2/domain/authentication/base/base_auth_data_source.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:get_it/get_it.dart';
import 'base_auth_tokens_service.dart';
import 'base_server_user.dart';

abstract class BaseAuthRepository<D extends BaseAuthDataSource<U>,
    U extends BaseServerUser> {
  final D dataSource;

  BaseAuthRepository(this.dataSource) {
    usersStreamController = StreamController.broadcast();
  }

  U? currentUser;

  late final StreamController<U?> usersStreamController;

  Stream<U?> get usersStream => usersStreamController.stream;

  Future<Result<VoidValue, AppError>> login({
    required String email,
    required String password,
  }) async {
    return (await dataSource.login(email: email, password: password))
        .mapSuccessToVoid(
      onSuccess: (user) => usersStreamController.add(user),
    );
  }

  Future<Result<VoidValue, AppError>> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return (await dataSource.register(
      username: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    ))
        .mapSuccessToVoid(onSuccess: (user) => usersStreamController.add(user));
  }

  Future<Result<VoidValue, AppError>> logout() async {
    return (await dataSource.logout()).fold(
      ifSuccess: (_) => usersStreamController.add(null),
    );
  }

  Future<Result<VoidValue, AppError>> requestPasswordReset(
    String emailAddress,
  ) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  Future<Result<VoidValue, AppError>> requestVerificationEmail() async {
    return await dataSource.sendVerificationEmail();
  }

  Future<Result<VoidValue, AppError>> onInit() async {
    return (await dataSource.loadUser()).mapSuccessToVoid(
      onSuccess: (user) {
        print(user);
        usersStreamController.add(user);
      },
    );
  }

  Future<Result<VoidValue, AppError>> resetAuth() async {
    final authTokenDeleted =
        await GetIt.I.get<BaseAuthTokensService>().deleteAccessToken();
    if (authTokenDeleted) {
      usersStreamController.add(null);
      return SuccessResult.voidResult();
    } else {
      return FailureResult.withMessage("Failed to reset auth");
    }
  }
}
