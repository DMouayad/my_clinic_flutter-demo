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
    hasLoggedInUserStreamController = StreamController();
    _dataSource = MyClinicApiAuthDataSource(authTokensService);
  }

  @override
  MyClinicApiUser? currentUser;
  @override
  void setCurrentUser(MyClinicApiUser user) {
    currentUser = user;
  }

  late final StreamController<bool> hasLoggedInUserStreamController;
  @override
  Stream<bool> get hasLoggedInUser => hasLoggedInUserStreamController.stream;
  @override
  Future<Result<MyClinicApiUser, BasicError>> login({
    required String email,
    required String password,
  }) async {
    // login user with email and password
    final loginResult = await _dataSource.login(email, password);

    return loginResult.mapSuccess(
      (result) {
        hasLoggedInUserStreamController.add(true);
        // set returned user as the current user
        setCurrentUser(result);
        return currentUser!;
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
      (result) {
        hasLoggedInUserStreamController.add(true);
        // set current user to the retrieved user
        setCurrentUser(result);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> logout() async {
    return (await _dataSource.logout()).fold(
      ifSuccess: (_) {
        hasLoggedInUserStreamController.add(false);
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
      onSuccess: (result) {
        currentUser = result;
        hasLoggedInUserStreamController.add(true);
        return SuccessResult.voidResult();
      },
      onFailure: (error) {
        hasLoggedInUserStreamController.add(false);
        return FailureResult(error);
      },
    );
  }
}
