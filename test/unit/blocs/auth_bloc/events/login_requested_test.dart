import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/dio_error_factory.dart';
import '../auth_bloc_event_test_case.dart';
import 'package:mockito/mockito.dart';

import '../utils/mock_async_result.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  const Duration returnResultAfter = Duration(milliseconds: 200);
  const Duration waitAfterAct = Duration(milliseconds: 600);
  const Duration verifyAfter = Duration(milliseconds: 700);

  const loginCreds = {'email': 'email@tests.com', 'password': 'password1234'};
  void addLoginEvent(AuthBloc bloc) {
    bloc.add(LoginRequested(loginCreds['email']!, loginCreds['password']!));
  }

  void verifyRepositoryLoginWasCalled(FakeAuthRepository repository) {
    verify(repository.login(
      email: loginCreds['email']!,
      password: loginCreds['password']!,
    )).called(1);
  }

  void verifyAfterExecution(FakeAuthRepository repository, AuthBloc bloc) {
    Future.delayed(verifyAfter, () {
      verifyRepositoryLoginWasCalled(repository);
    });
  }

  group("[LoginRequested] event tests", () {
    authBlocEventTestCase(
      desc: '''should emit [LoginInProgress, LoginSuccess, AuthHasLoggedInUser]
          after [LoginRequested] and a [SuccessResult] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
            loginResult: AuthRepoMockAsyncResult(
          result: SuccessResult.voidResult(),
          returnAfter: returnResultAfter,
          userAfterExecution: userFactory.create(),
        ));
      },
      waitAfterAct: waitAfterAct,
      act: addLoginEvent,
      expectedStates: (userAfterEvents) {
        return [
          const LoginInProgress(),
          const LoginSuccess(),
          AuthHasLoggedInUser(userAfterEvents.afterLogin!),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc: "should emit [LoginInProgress] after [LoginRequested]",
      act: addLoginEvent,
      expectedStates: (userAfterEvents) => [const LoginInProgress()],
    );
    //
    authBlocEventTestCase(
      desc:
          '''should emit [LoginInProgress, LoginEmailNotFound, AuthHasNoLoggedInUser]
          after [LoginRequested] with [AppException.invalidEmailCredential()] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          loginResult: AuthRepoMockAsyncResult(
            result: FailureResult.withAppException(
              AppException.invalidEmailCredential,
            ),
            returnAfter: returnResultAfter,
          ),
        );
      },
      act: addLoginEvent,
      waitAfterAct: waitAfterAct,
      expectedStates: (_) {
        return [
          const LoginInProgress(),
          LoginEmailNotFound(),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [LoginInProgress, LoginPasswordIsIncorrect, AuthHasNoLoggedInUser]
      after [LoginRequested] with [FailureResult] with [AppException.invalidPasswordCredential()]
      returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          loginResult: AuthRepoMockAsyncResult(
            result: FailureResult.withAppException(
              AppException.invalidPasswordCredential,
            ),
            returnAfter: returnResultAfter,
          ),
        );
      },
      waitAfterAct: waitAfterAct,
      act: addLoginEvent,
      expectedStates: (userAfterEvents) {
        return [
          const LoginInProgress(),
          LoginPasswordIsIncorrect(),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [LoginInProgress, LoginErrorState, AuthHasNoLoggedInUser]
          after [LoginRequested] with [FailureResult.withDioError] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          loginResult: AuthRepoMockAsyncResult(
            result: FailureResult.withDioError(
              DioErrorFactory()
                  .setupWith(errorType: DioErrorType.connectTimeout)
                  .create(),
            ),
            returnAfter: returnResultAfter,
          ),
        );
      },
      waitAfterAct: waitAfterAct,
      act: addLoginEvent,
      expectedStates: (userAfterEvents) {
        return [
          const LoginInProgress(),
          LoginErrorState(
            AppError(
              message: '',
              appException: AppException.cannotConnectToServer,
              description: DioErrorType.connectTimeout.toString(),
            ),
          ),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [AuthInitInProgress, AuthHasNoLoggedInUser, LoginInProgress, LoginSuccess,
           AuthHasNoLoggedInUser]
          after the following events [AuthInitRequested, LoginRequested]
          ''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: AuthRepoMockAsyncResult(
            result: SuccessResult.voidResult(),
            returnAfter: Duration.zero,
          ),
          loginResult: AuthRepoMockAsyncResult(
            result: SuccessResult.voidResult(),
            returnAfter: const Duration(milliseconds: 100),
            userAfterExecution: userFactory.create(),
          ),
        );
      },
      act: (bloc) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          addLoginEvent(bloc);
        });
        bloc.add(const AuthInitRequested());
      },
      waitAfterAct: const Duration(seconds: 1),
      expectedStates: (userAfterEvents) {
        return [
          const AuthInitInProgress(),
          const AuthHasNoLoggedInUser(),
          const LoginInProgress(),
          const LoginSuccess(),
          AuthHasLoggedInUser(userAfterEvents.afterLogin!),
        ];
      },
      verify: verifyAfterExecution,
    );
  });
}
