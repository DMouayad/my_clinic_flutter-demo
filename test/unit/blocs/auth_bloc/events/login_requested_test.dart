import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/dio_error_factory.dart';
import '../auth_bloc_event_test_case.dart';
import 'package:mockito/mockito.dart';

import '../utils/base_auth_repository.mocks.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  const Duration returnResultAfter = Duration(milliseconds: 200);
  const Duration streamUserAfter = Duration(milliseconds: 500);

  const loginCreds = {'email': 'email@tests.com', 'password': 'password1234'};
  void addLoginEvent(AuthBloc bloc) {
    bloc.add(LoginRequested(loginCreds['email']!, loginCreds['password']!));
  }

  void verifyRepositoryLoginWasCalled(MockBaseAuthRepository repository) {
    verify(repository.login(
      email: loginCreds['email']!,
      password: loginCreds['password']!,
    )).called(1);
  }

  void verifyAfterExecution(MockBaseAuthRepository repository, AuthBloc bloc) {
    Future.delayed(const Duration(seconds: 3), () {
      verifyRepositoryLoginWasCalled(repository);
    });
  }

  group("[LoginRequested] event tests", () {
    authBlocEventTestCase(
      desc: '''should emit [LoginInProgress, LoginSuccess, AuthHasLoggedInUser]
          after [LoginRequested] and a [SuccessResult] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
            loginResult: MockAuthRepoMethodResult(
          result: SuccessResult.voidResult(),
          returnAfter: returnResultAfter,
          userAfterExecution: userFactory.create(),
          streamUserAfter: streamUserAfter,
        ));
      },
      act: addLoginEvent,
      expect: (repository, bloc, userAfterEvents) {
        expectLater(
          bloc.stream,
          emitsInOrder([
            const LoginInProgress(),
            const LoginSuccess(),
            AuthHasLoggedInUser(userAfterEvents.afterLogin!),
          ]),
        );
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc: "should emit [LoginInProgress] after [LoginRequested]",
      act: addLoginEvent,
      expect: (repository, bloc, userAfterEvents) => expect(
        bloc.stream,
        emits(const LoginInProgress()),
      ),
    );

    authBlocEventTestCase(
      desc:
          '''should emit [LoginInProgress, LoginEmailNotFound, AuthHasNoLoggedInUser]
          after [LoginRequested] with [AppException.invalidEmailCredential()] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          loginResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
              const AppException.invalidEmailCredential(),
            ),
            returnAfter: returnResultAfter,
            streamUserAfter: streamUserAfter,
          ),
        );
      },
      act: addLoginEvent,
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder([
            const LoginInProgress(),
            LoginEmailNotFound(),
            const AuthHasNoLoggedInUser(),
          ]),
        );
      },
      // verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [LoginInProgress, LoginPasswordIsIncorrect, AuthHasNoLoggedInUser]
          after [LoginRequested] with [FailureResult] with [AppException.invalidPasswordCredential()]
          returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          loginResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
              const AppException.invalidPasswordCredential(),
            ),
            streamUserAfter: streamUserAfter,
            returnAfter: returnResultAfter,
          ),
        );
      },
      act: addLoginEvent,
      expect: (repository, bloc, userAfterEvents) {
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
          loginResult: MockAuthRepoMethodResult(
            result: FailureResult.withDioError(
              DioErrorFactory()
                  .setupWith(errorType: DioErrorType.connectTimeout)
                  .create(),
            ),
            streamUserAfter: streamUserAfter,
            returnAfter: returnResultAfter,
          ),
        );
      },
      act: addLoginEvent,
      expect: (repository, bloc, userAfterEvents) {
        return [
          const LoginInProgress(),
          LoginErrorState(
            AppError(
                message: '',
                appException: AppException(DioErrorType.connectTimeout.name)),
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
          initResult: MockAuthRepoMethodResult(
            result: SuccessResult.voidResult(),
            streamUserAfter: streamUserAfter,
            returnAfter: returnResultAfter,
          ),
          loginResult: MockAuthRepoMethodResult(
            result: SuccessResult.voidResult(),
            returnAfter: returnResultAfter,
            streamUserAfter:
                // the user must be streamed after [authInit] and
                // [login] were called and executed
                Duration(milliseconds: streamUserAfter.inMilliseconds + 1000),
            userAfterExecution: userFactory.create(),
          ),
        );
      },
      act: (bloc) async {
        Future.delayed(const Duration(milliseconds: 800), () {
          addLoginEvent(bloc);
        });
        bloc.add(const AuthInitRequested());
      },
      expect: (repository, bloc, userAfterEvents) async {
        expect(
          bloc.stream,
          emitsInOrder([
            const AuthInitInProgress(),
            const AuthHasNoLoggedInUser(),
            const LoginInProgress(),
            const LoginSuccess(),
            AuthHasLoggedInUser(userAfterEvents.afterLogin!),
          ]),
        );
      },
      verify: verifyAfterExecution,
    );
  });
}
