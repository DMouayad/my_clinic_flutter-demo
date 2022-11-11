import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_auth_repository.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_server_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<BaseAuthRepository>()])
import 'base_auth_repository.mocks.dart';
import 'mock_server_user_factory.dart';
import 'mock_base_server_user.dart';

class MockAuthRepositoryFactory {
  late final MockBaseAuthRepository _repository;
  BaseServerUser? _currentUser;
  final MockAuthRepoMethodResult<VoidValue>? initResult;
  final MockAuthRepoMethodResult<VoidValue>? loginResult;
  final MockAuthRepoMethodResult<VoidValue>? registerResult;
  final MockAuthRepoMethodResult<VoidValue>? logoutResult;

  factory MockAuthRepositoryFactory() {
    return MockAuthRepositoryFactory._(repository: MockBaseAuthRepository());
  }
  MockBaseAuthRepository get repository => _repository;
  MockAuthRepositoryFactory._({
    required MockBaseAuthRepository repository,
    this.initResult,
    this.loginResult,
    this.registerResult,
    this.logoutResult,
  }) {
    _repository = repository;
    _currentUser = null;
  }
  Future<Result<VoidValue, BasicError>> _processMethodCall(
    MockAuthRepoMethodResult<VoidValue>? result,
    String resultName,
  ) async {
    result ??= MockAuthRepoMethodResult(result: SuccessResult.voidResult());
    final stubResult =
        await Future.delayed(result.returnAfter, () => result!.result);
    return stubResult;
  }

  MockBaseAuthRepository create() {
    when(_repository.onInit()).thenAnswer((_) async {
      return await _processMethodCall(initResult, 'authInit');
    });

    when(_repository.login(
      email: anyNamed("email"),
      password: anyNamed("password"),
    )).thenAnswer((_) async => await _processMethodCall(loginResult, 'login'));
    when(_repository.register(
      email: anyNamed('email'),
      name: anyNamed('name'),
      phoneNumber: anyNamed('phoneNumber'),
      password: anyNamed('password'),
    )).thenAnswer(
        (_) async => await _processMethodCall(registerResult, 'register'));

    when(_repository.logout()).thenAnswer(
        (_) async => await _processMethodCall(logoutResult, 'logout'));
    when(_repository.usersStream).thenAnswer(
      (_) {
        final MockServerUserFactory userFactory = MockServerUserFactory();
        final users = <Future<BaseServerUser?>>[];

        if (initResult != null) {
          users.add(_getResultUser(initResult!, userFactory));
        }

        if (registerResult != null) {
          users.add(_getResultUser(registerResult!, userFactory));
        }
        if (loginResult != null) {
          users.add(_getResultUser(loginResult!, userFactory));
        }
        if (logoutResult != null) {
          users.add(_getResultUser(logoutResult!, userFactory));
        }
        return Stream.fromFutures(users);
      },
    );
    when(_repository.currentUser).thenReturn(() {
      return _currentUser;
    }());
    return _repository;
  }

  Future<BaseServerUser?> _getResultUser(
    MockAuthRepoMethodResult result,
    MockServerUserFactory userFactory,
  ) async {
    return Future.delayed(result.streamUserAfter, () {
      _currentUser = result.userAfterExecution;
      return _currentUser;
    });
  }

  MockAuthRepositoryFactory setupWith({
    MockAuthRepoMethodResult<VoidValue>? initResult,
    MockAuthRepoMethodResult<VoidValue>? loginResult,
    MockAuthRepoMethodResult<VoidValue>? registerResult,
    MockAuthRepoMethodResult<VoidValue>? logoutResult,
  }) {
    return MockAuthRepositoryFactory._(
      repository: _repository,
      initResult: initResult ?? this.initResult,
      loginResult: loginResult ?? this.loginResult,
      registerResult: registerResult ?? this.registerResult,
      logoutResult: logoutResult ?? this.logoutResult,
    );
  }
}

class MockAuthRepoMethodResult<ResultType extends Object> {
  final MockBaseServerUser? userAfterExecution;
  final Duration streamUserAfter;
  final Duration returnAfter;
  final Result<ResultType, BasicError> result;

  const MockAuthRepoMethodResult({
    required this.result,
    this.userAfterExecution,
    this.returnAfter = const Duration(milliseconds: 300),
    this.streamUserAfter = const Duration(milliseconds: 500),
  });
}
