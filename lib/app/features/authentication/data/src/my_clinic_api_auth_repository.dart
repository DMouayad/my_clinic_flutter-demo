import 'dart:async';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/app/services/auth_tokens/base_auth_tokens_service.dart';

class MyClinicApiAuthRepository implements BaseAuthRepository<MyClinicApiUser> {
  late final MyClinicApiAuthDataSource _dataSource;

  MyClinicApiAuthRepository({
    required BaseAuthTokensService authTokensService,
  }) {
    _hasLoggedInUserStreamController = StreamController();
    _dataSource = MyClinicApiAuthDataSource(authTokensService);
  }

  late final StreamController<MyClinicApiUser?>
      _hasLoggedInUserStreamController;
  @override
  Stream<MyClinicApiUser?> get hasLoggedInUser =>
      _hasLoggedInUserStreamController.stream;
  @override
  Future<Result<VoidValue, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);

    return loginResult.mapSuccessToVoid(
      (user) {
        _hasLoggedInUserStreamController.add(user);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required ThemeMode themeModePreference,
    required Locale localePreference,
  }) async {
    return (await _dataSource.register(
      username: name,
      email: email,
      password: password,
      themeModePreference: themeModePreference,
      localePreference: localePreference,
      phoneNumber: phoneNumber,
    ))
        .mapSuccessToVoid(
      (user) {
        _hasLoggedInUserStreamController.add(user);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> logout() async {
    return (await _dataSource.logout()).fold(
      ifSuccess: (_) {
        _hasLoggedInUserStreamController.add(null);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> requestPasswordReset(
      String emailAddress) {
    // TODO: implement requestPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<VoidValue, BasicError>> requestVerificationEmail() async {
    return await _dataSource.sendVerificationEmail();
  }

  @override
  Future<Result<VoidValue, BasicError>> onInit() async {
    return (await _dataSource.loadUser()).flatMap(
      onSuccess: (user) {
        _hasLoggedInUserStreamController.add(user);
        return SuccessResult.voidResult();
      },
      onFailure: (error) {
        _hasLoggedInUserStreamController.add(null);
        return FailureResult(error);
      },
    );
  }
}
