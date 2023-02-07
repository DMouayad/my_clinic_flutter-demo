import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../auth_bloc_event_test_case.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  group('LogoutRequested event tests', () {
    authBlocEventTestCase(
      desc:
          """should emit [LogoutInProgress,LogoutSuccess,AuthHasNoLoggedInUser] after
       event was added and received [SuccessResult] from the repository""",
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          logoutResult: MockAuthRepoMethodResult(
            result: SuccessResult.voidResult(),
            userAfterExecution: null,
          ),
        );
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expectedStates: (repository, bloc, _) {
        return const <AuthState>[
          LogoutInProgress(),
          LogoutSuccess(),
          AuthHasNoLoggedInUser()
        ];
      },
    );
    authBlocEventTestCase(
      desc: """should emit [LogoutInProgress,LogoutFailed] after
       event was added and received [FailureResult] from the repository""",
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          logoutResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
              const AppException.cannotConnectToServer(),
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expectedStates: (repository, bloc, _) {
        return <AuthState>[
          // const LogoutInProgress(),
          LogoutFailed(
            AppError(appException: const AppException.cannotConnectToServer()),
          ),
        ];
      },
    );
  });
}
