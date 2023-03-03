import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:meta/meta.dart';
import 'utils/mock_auth_repository_factory.dart';
import 'utils/fake_server_user_factory.dart';

@isTest
void authBlocEventTestCase({
  required String desc,
  FakeAuthRepositoryFactory Function(
    FakeAuthRepositoryFactory,
    FakeServerUserFactory,
  )?
      setup,
  dynamic Function(AuthBloc)? act,
  dynamic Function(
          UserAfterEvents userAfterEvents, List<AuthState> emittedStates)?
      expect,
  List<AuthState> Function(UserAfterEvents userAfterEvents)? expectedStates,
  dynamic Function(FakeAuthRepository, AuthBloc)? verify,
  Duration? waitAfterAct,
}) {
  UserAfterEvents getUserAfterEvents(FakeAuthRepositoryFactory factory) =>
      UserAfterEvents(
        afterAuthInit: factory.initResult?.userAfterExecution,
        afterLogin: factory.loginResult?.userAfterExecution,
        afterLogout: factory.logoutResult?.userAfterExecution,
        afterRegister: factory.registerResult?.userAfterExecution,
      );

  test.test(
    desc,
    () async {
      List<AuthState> states = [];

      FakeAuthRepositoryFactory authRepositoryFactory =
          FakeAuthRepositoryFactory();
      if (setup != null) {
        authRepositoryFactory =
            setup(authRepositoryFactory, FakeServerUserFactory());
      }
      final authRepository = authRepositoryFactory.create();

      final bloc = AuthBloc(authRepository, shouldLogTransitions: false);
      final sub = bloc.stream.listen((s) => states.add(s));

      if (act != null) act(bloc);
      await Future.delayed(waitAfterAct ?? const Duration(milliseconds: 100));
      // await Future<void>.delayed();
      // After [act] is called, the bloc should be closed to prevent emitting
      // undesired states
      await bloc.close();

      if (expect != null) {
        expect(
          getUserAfterEvents(authRepositoryFactory),
          states,
        );
      }
      if (expectedStates != null) {
        test.expect(
          states,
          expectedStates(getUserAfterEvents(authRepositoryFactory)),
        );
      }

      if (verify != null) verify(authRepository, bloc);
      await sub.cancel();
    },
  );
}

// }
class UserAfterEvents extends Object {
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
