import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/dio_error_factory.dart';
import '../auth_bloc_event_test_case.dart';
import '../utils/mock_async_result.dart';

void main() {
  group('AuthInitRequested event tests', () {
    authBlocEventTestCase(
      desc: "should emit [AuthHasNoLoggedInUser] when no user was found",
      setup: (repoFactory, userFactory) => repoFactory.setupWith(
          initResult: AuthRepoMockAsyncResult(
        result: SuccessResult.voidResult(),
        userAfterExecution: null,
      )),
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expectedStates: (_) {
        return const <AuthState>[AuthInitInProgress(), AuthHasNoLoggedInUser()];
      },
    );

    authBlocEventTestCase(
      desc: '''should emit [AuthHasNoLoggedInUser] with an error
           when a [FailureResult] returned with [NoRefreshTokenFoundException]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: AuthRepoMockAsyncResult(
            result: FailureResult.withAppException(
                AppException.noRefreshTokenFound),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expectedStates: (_) {
        return <AuthState>[
          const AuthInitInProgress(),
          AuthInitFailed(
            AppError(appException: AppException.noRefreshTokenFound),
          ),
        ];
      },
    );
    authBlocEventTestCase(
      desc: '''should emit [AuthHasNoLoggedInUser] with an error
           when a [FailureResult] returned with [FailedToRefreshAuthTokensException]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: AuthRepoMockAsyncResult(
            result: FailureResult.withAppException(
                AppException.failedToRefreshTokens),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expectedStates: (_) {
        return <AuthState>[
          const AuthInitInProgress(),
          AuthInitFailed(
            AppError(appException: AppException.failedToRefreshTokens),
          ),
        ];
      },
    );
    authBlocEventTestCase(
      desc:
          '''should emit [AuthInitFailed] when a [FailureResult] returned by [authInit]''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          initResult: AuthRepoMockAsyncResult(
            result: FailureResult.withDioError(
              DioErrorFactory()
                  .setupWith(errorType: DioErrorType.connectTimeout)
                  .create(),
            ),
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expectedStates: (_) {
        return [
          const AuthInitInProgress(),
          AuthInitFailed(
            AppError(
              message: '',
              appException: AppException.cannotConnectToServer,
              description: DioErrorType.connectTimeout.toString(),
            ),
          ),
        ];
      },
    );
    authBlocEventTestCase(
      desc: "should emit [AuthHasLoggedInUser] when a user was found",
      setup: (repoFactory, userFactory) => repoFactory.setupWith(
        initResult: AuthRepoMockAsyncResult(
          result: SuccessResult.voidResult(),
          userAfterExecution: userFactory.create(),
        ),
      ),
      act: (bloc) => bloc.add(const AuthInitRequested()),
      expectedStates: (userAfterEvents) {
        return [
          const AuthInitInProgress(),
          AuthHasLoggedInUser(userAfterEvents.afterAuthInit!),
        ];
      },
    );
  });
}
