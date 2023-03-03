import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

import '../auth_bloc_event_test_case.dart';
import '../utils/mock_async_result.dart';

void main() {
  group('LogoutRequested event tests', () {
    authBlocEventTestCase(
      desc:
          """should emit [LogoutInProgress,LogoutSuccess,AuthHasNoLoggedInUser] after
       event was added and received [SuccessResult] from the repository""",
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          logoutResult: AuthRepoMockAsyncResult(
            result: SuccessResult.voidResult(),
            userAfterExecution: null,
          ),
        );
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expectedStates: (_) {
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
          logoutResult: AuthRepoMockAsyncResult(
            result: FailureResult.withAppException(
              AppException.cannotConnectToServer,
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(const LogoutRequested()),
      expectedStates: (_) {
        return <AuthState>[
          // const LogoutInProgress(),
          LogoutFailed(
            AppError(appException: AppException.cannotConnectToServer),
          ),
        ];
      },
    );
  });
}
