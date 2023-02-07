import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/dio_error_factory.dart';
import '../auth_bloc_event_test_case.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  group('AuthInitRequested event tests', () {
    authBlocEventTestCase(
      desc: "should emit [AuthHasNoLoggedInUser] when no user was found",
      setup: (repoFactory, userFactory) => repoFactory.setupWith(
          initResult: MockAuthRepoMethodResult(
              result: SuccessResult.voidResult(), userAfterExecution: null)),
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder(
            const <AuthState>[AuthInitInProgress(), AuthHasNoLoggedInUser()],
          ),
        );
      },
    );
    authBlocEventTestCase(
      desc: '''should emit [AuthHasNoLoggedInUser] without an error
           when a [FailureResult] returned with [NoAccessTokenFoundException]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
                const AppException.noAccessTokenFound()),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder(
            const <AuthState>[
              AuthInitInProgress(),
              AuthHasNoLoggedInUser(),
            ],
          ),
        );
      },
    );
    authBlocEventTestCase(
      desc: '''should emit [AuthHasNoLoggedInUser] with an error
           when a [FailureResult] returned with [NoRefreshTokenFoundException]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
                const AppException.noRefreshTokenFound()),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder(
            <AuthState>[
              const AuthInitInProgress(),
              AuthHasNoLoggedInUser(
                error: AppError(
                    appException: const AppException.noRefreshTokenFound()),
              ),
            ],
          ),
        );
      },
    );
    authBlocEventTestCase(
      desc: '''should emit [AuthHasNoLoggedInUser] with an error
           when a [FailureResult] returned with [FailedToRefreshAuthTokensException]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: MockAuthRepoMethodResult(
            result: FailureResult.withAppException(
                const AppException.failedToRefreshTokens()),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder(
            <AuthState>[
              const AuthInitInProgress(),
              AuthHasNoLoggedInUser(
                error: AppError(
                    appException: const AppException.failedToRefreshTokens()),
              ),
            ],
          ),
        );
      },
    );
    authBlocEventTestCase(
      desc: '''should emit [AuthInitFailed]
           when a [FailureResult] returned by [authInit]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: MockAuthRepoMethodResult(
            result: FailureResult.withDioError(
              DioErrorFactory()
                  .setupWith(errorType: DioErrorType.connectTimeout)
                  .create(),
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) {
        expect(
          bloc.stream,
          emitsInOrder(
            <AuthState>[
              const AuthInitInProgress(),
              AuthInitFailed(
                AppError(
                  message: '',
                  appException: AppException(DioErrorType.connectTimeout.name),
                ),
              ),
            ],
          ),
        );
      },
    );
    authBlocEventTestCase(
      desc: "should emit [AuthHasLoggedInUser] when a user was found",
      setup: (repoFactory, userFactory) => repoFactory.setupWith(
        initResult: MockAuthRepoMethodResult(
          result: SuccessResult.voidResult(),
          userAfterExecution: userFactory.create(),
        ),
      ),
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, userAfterEvents) {
        expect(
          bloc.stream,
          emitsInOrder([
            const AuthInitInProgress(),
            AuthHasLoggedInUser(userAfterEvents.afterAuthInit!),
          ]),
        );
      },
    );
    authBlocEventTestCase(
      desc: "should emit [AuthInitInProgress] after [AuthInitRequested] event",
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expect: (repository, bloc, _) =>
          expect(bloc.stream, emits(const AuthInitInProgress())),
    );
  });
}
