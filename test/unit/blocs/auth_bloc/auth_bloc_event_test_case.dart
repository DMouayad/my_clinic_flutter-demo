import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:meta/meta.dart';
import 'utils/base_auth_repository.mocks.dart';
import 'utils/mock_auth_repository_factory.dart';
import 'utils/mock_server_user_factory.dart';

@isTest
void authBlocEventTestCase({
  required String desc,
  MockAuthRepositoryFactory Function(
    MockAuthRepositoryFactory,
    MockServerUserFactory,
  )?
      setup,
  dynamic Function(AuthBloc)? act,
  dynamic Function(
    MockBaseAuthRepository repository,
    AuthBloc bloc,
    UserAfterEvents userAfterEvents,
  )?
      expect,
  List<AuthState> Function(
    MockBaseAuthRepository repository,
    AuthBloc bloc,
    UserAfterEvents userAfterEvents,
  )?
      expectedStates,
  dynamic Function(MockBaseAuthRepository, AuthBloc)? verify,
}) {
  test.test(
    desc,
    () async {
      MockAuthRepositoryFactory authRepositoryFactory =
          MockAuthRepositoryFactory();
      if (setup != null) {
        authRepositoryFactory =
            setup(authRepositoryFactory, MockServerUserFactory());
      }
      final authRepository = authRepositoryFactory.create();

      final bloc = AuthBloc(authRepository, shouldLogTransitions: false);

      if (act != null) act(bloc);
      if (expect != null) {
        expect(
          authRepository,
          bloc,
          UserAfterEvents(
            afterAuthInit: authRepositoryFactory.initResult?.userAfterExecution,
            afterLogin: authRepositoryFactory.loginResult?.userAfterExecution,
            afterLogout: authRepositoryFactory.logoutResult?.userAfterExecution,
            afterRegister:
                authRepositoryFactory.registerResult?.userAfterExecution,
          ),
        );
        if (expectedStates != null) {
          test.expect(
            bloc.stream,
            test.emitsInAnyOrder(expectedStates(
              authRepository,
              bloc,
              UserAfterEvents(
                afterAuthInit:
                    authRepositoryFactory.initResult?.userAfterExecution,
                afterLogin:
                    authRepositoryFactory.loginResult?.userAfterExecution,
                afterLogout:
                    authRepositoryFactory.logoutResult?.userAfterExecution,
                afterRegister:
                    authRepositoryFactory.registerResult?.userAfterExecution,
              ),
            )),
          );
        }
      }
      if (verify != null) verify(authRepository, bloc);
    },
  );
}

// }
class UserAfterEvents {
  final BaseServerUser? afterAuthInit;
  final BaseServerUser? afterLogin;
  final BaseServerUser? afterRegister;
  final BaseServerUser? afterLogout;

  const UserAfterEvents({
    this.afterAuthInit,
    this.afterLogin,
    this.afterRegister,
    this.afterLogout,
  });
}
