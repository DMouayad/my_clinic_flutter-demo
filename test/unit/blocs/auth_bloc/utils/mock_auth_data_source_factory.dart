import 'package:clinic_v2/domain/authentication/base/base_auth_data_source.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'fake_server_user.dart';
import 'mock_async_result.dart';
@GenerateNiceMocks([MockSpec<BaseAuthDataSource<FakeServerUser>>()])
import 'mock_auth_data_source_factory.mocks.dart';

class MockAuthDataSourceFactory {
  final MockBaseAuthDataSource _dataSource;
  final MockAsyncResult<FakeServerUser?>? loadUserResult;
  final MockAsyncResult<FakeServerUser>? loginResult;
  final MockAsyncResult<FakeServerUser>? registerResult;
  final MockAsyncResult<VoidValue>? logoutResult;
  final MockAsyncResult<VoidValue>? sendVerificationEmailResult;

  factory MockAuthDataSourceFactory() {
    return MockAuthDataSourceFactory._(MockBaseAuthDataSource());
  }

  MockAuthDataSourceFactory._(
    this._dataSource, {
    this.loadUserResult,
    this.sendVerificationEmailResult,
    this.loginResult,
    this.registerResult,
    this.logoutResult,
  });

  Future<Result<T, AppError>> _processMethodCall<T>(
    MockAsyncResult<T> result,
  ) async {
    return await Future.delayed(result.returnAfter, () => result.result);
  }

  MockBaseAuthDataSource create() {
    if (loadUserResult != null) {
      when(_dataSource.loadUser()).thenAnswer((_) async {
        return await _processMethodCall(loadUserResult!);
      });
    }
    if (loginResult != null) {
      when(_dataSource.login(
        email: anyNamed("email"),
        password: anyNamed("password"),
      )).thenAnswer((_) async => await _processMethodCall(loginResult!));
    }
    if (registerResult != null) {
      when(_dataSource.register(
        email: anyNamed('email'),
        username: anyNamed('username'),
        phoneNumber: anyNamed('phoneNumber'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => await _processMethodCall(registerResult!));
    }
    if (logoutResult != null) {
      when(_dataSource.logout())
          .thenAnswer((_) async => await _processMethodCall(logoutResult!));
    }

    if (sendVerificationEmailResult != null) {
      when(_dataSource.sendVerificationEmail()).thenAnswer(
          (_) async => await _processMethodCall(sendVerificationEmailResult!));
    }

    return _dataSource;
  }

//
  MockAuthDataSourceFactory setupWith({
    MockAsyncResult<FakeServerUser?>? loadUserResult,
    MockAsyncResult<FakeServerUser>? loginResult,
    MockAsyncResult<FakeServerUser>? registerResult,
    MockAsyncResult<VoidValue>? logoutResult,
    MockAsyncResult<VoidValue>? sendVerificationEmailResult,
  }) {
    return MockAuthDataSourceFactory._(
      _dataSource,
      loadUserResult: loadUserResult ?? this.loadUserResult,
      sendVerificationEmailResult:
          sendVerificationEmailResult ?? this.sendVerificationEmailResult,
      loginResult: loginResult ?? this.loginResult,
      registerResult: registerResult ?? this.registerResult,
      logoutResult: logoutResult ?? this.logoutResult,
    );
  }
}
