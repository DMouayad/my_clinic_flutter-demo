import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/dio_error_factory.dart';
import '../event_test_case.dart';
import '../utils/base_auth_repository.mocks.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  group("SignUpRequested event tests", () {
    const signUpCreds = {
      'email': 'email@test.com',
      'password': 'password',
      'name': 'testuser',
      'phoneNumber': '0123456789',
    };
    void verifyRepositoryRegisterWasCalled(MockBaseAuthRepository repository) {
      return verify(
        repository.register(
          email: signUpCreds['email']!,
          password: signUpCreds['password']!,
          name: signUpCreds['name']!,
          phoneNumber: signUpCreds['phoneNumber']!,
        ),
      ).called(1);
    }

    void verifyAfterExecution(
        MockBaseAuthRepository repository, AuthBloc bloc) {
      Future.delayed(const Duration(seconds: 3), () {
        verifyRepositoryRegisterWasCalled(repository);
      });
    }

    void act(AuthBloc bloc) {
      bloc.add(SignUpRequested(
        email: signUpCreds['email']!,
        password: signUpCreds['password']!,
        username: signUpCreds['name']!,
        phoneNumber: signUpCreds['phoneNumber']!,
      ));
    }

    authBlocEventTestCase(
      desc: "should emit [SignUpInProgress] after [SignUpRequested]",
      setup: (repoFactory, _) => repoFactory.setupWith(
        registerResult:
            MockAuthRepoMethodResult(result: SuccessResult.voidResult()),
      ),
      act: act,
      expect: (repository, bloc, _) =>
          expect(bloc.stream, emits(const SignUpInProgress())),
      verify: verifyAfterExecution,
    );

    authBlocEventTestCase(
      desc:
          '''should emit [SignUpInProgress, SignUpSuccess, AuthHasLoggedInUser]
          after [SignUpRequested] and a [SuccessResult] returned by the repository''',
      act: act,
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          registerResult: MockAuthRepoMethodResult(
            result: SuccessResult.voidResult(),
            userAfterExecution: userFactory.create(),
          ),
        );
      },
      expectedStates: (repository, bloc, userAfterEvents) {
        return [
          const SignUpInProgress(),
          const SignUpSuccess(),
          AuthHasLoggedInUser(userAfterEvents.afterRegister!),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [SignUpInProgress, SignUpEmailIsNotAuthorizedToRegister, AuthHasNoLoggedInUser]
          after [SignUpRequested] and [FailureResult] with [ErrorException.emailUnauthorizedToRegister] returned by the repository''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          registerResult: MockAuthRepoMethodResult(
            result: FailureResult.fromErrorException(
                const ErrorException.emailUnauthorizedToRegister()),
          ),
        );
      },
      act: act,
      expectedStates: (repository, bloc, _) {
        return [
          const SignUpInProgress(),
          SignUpEmailIsNotAuthorizedToRegister(),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );

    authBlocEventTestCase(
      desc:
          '''should emit [SignUpInProgress, LoginErrorState, AuthHasNoLoggedInUser]
          after [LoginRequested] with [FailureResult.fromDioError] and [ErrorException] returned by the repository''',
      setup: (repoFactory, _) {
        return repoFactory.setupWith(
            registerResult: MockAuthRepoMethodResult(
          result: FailureResult.fromDioError(
            DioErrorFactory()
                .setupWith(errorType: DioErrorType.connectTimeout)
                .create(),
          ),
        ));
      },
      act: act,
      expect: (repository, bloc, _) {
        return [
          const SignUpInProgress(),
          LoginErrorState(
            BasicError(
                message: '',
                exception: ErrorException(DioErrorType.connectTimeout.name)),
          ),
          const AuthHasNoLoggedInUser(),
        ];
      },
    );
  });
}
