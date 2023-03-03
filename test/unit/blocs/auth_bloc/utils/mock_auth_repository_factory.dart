import 'package:clinic_v2/domain/authentication/base/base_auth_repository.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

import 'mock_async_result.dart';
import 'fake_server_user.dart';
import 'mock_auth_data_source_factory.dart';
import 'mock_auth_data_source_factory.mocks.dart';

class FakeAuthRepository
    extends BaseAuthRepository<MockBaseAuthDataSource, FakeServerUser> {
  FakeAuthRepository(super.dataSource);
}

class FakeAuthRepositoryFactory {
  final AuthRepoMockAsyncResult<VoidValue>? initResult;
  final AuthRepoMockAsyncResult<VoidValue>? loginResult;
  final AuthRepoMockAsyncResult<VoidValue>? registerResult;
  final AuthRepoMockAsyncResult<VoidValue>? logoutResult;
  final AuthRepoMockAsyncResult<VoidValue>? requestVerificationEmail;

  FakeAuthRepositoryFactory({
    this.initResult,
    this.loginResult,
    this.registerResult,
    this.logoutResult,
    this.requestVerificationEmail,
  });

  FakeAuthRepository create() {
    final dataSource = MockAuthDataSourceFactory()
        .setupWith(
          loadUserResult: initResult?.toRegular(),
          registerResult: registerResult?.toRegular(),
          loginResult: loginResult?.toRegular(),
          logoutResult: logoutResult?.toRegular(),
          sendVerificationEmailResult: requestVerificationEmail?.toRegular(),
        )
        .create();

    return FakeAuthRepository(dataSource);
  }

  FakeAuthRepositoryFactory setupWith({
    AuthRepoMockAsyncResult<VoidValue>? initResult,
    AuthRepoMockAsyncResult<VoidValue>? loginResult,
    AuthRepoMockAsyncResult<VoidValue>? registerResult,
    AuthRepoMockAsyncResult<VoidValue>? logoutResult,
    AuthRepoMockAsyncResult<VoidValue>? requestVerificationEmail,
  }) {
    return FakeAuthRepositoryFactory(
      initResult: initResult ?? this.initResult,
      loginResult: loginResult ?? this.loginResult,
      registerResult: registerResult ?? this.registerResult,
      logoutResult: logoutResult ?? this.logoutResult,
      requestVerificationEmail:
          requestVerificationEmail ?? this.requestVerificationEmail,
    );
  }
}
