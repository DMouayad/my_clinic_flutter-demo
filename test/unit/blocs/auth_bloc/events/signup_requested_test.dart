import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/dio_error_factory.dart';
import '../auth_bloc_event_test_case.dart';
import '../utils/base_auth_repository.mocks.dart';
import '../utils/mock_auth_repository_factory.dart';

void main() {
  group("SignUpRequested event tests", () {
    const signupData = {
      'email': 'email@test.com',
      'password': 'password',
      'name': 'testuser',
      'phoneNumber': '0123456789',
    };
    void verifyRepositoryRegisterWasCalled(MockBaseAuthRepository repository) {
      return verify(
        repository.register(
          email: signupData['email']!,
          password: signupData['password']!,
          name: signupData['name']!,
          phoneNumber: signupData['phoneNumber']!,
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
        email: signupData['email']!,
        password: signupData['password']!,
        username: signupData['name']!,
        phoneNumber: signupData['phoneNumber']!,
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
          '''should emit [SignUpInProgress, EmailNotAuthorizedToRegister, AuthHasNoLoggedInUser]
          after [SignUpRequested] and received [FailureResult] with [ErrorException.emailUnauthorizedToRegister]
           ''',
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
          EmailNotAuthorizedToRegister(),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );

    authBlocEventTestCase(
      desc:
          '''should emit [SignUpInProgress, EmailAlreadySignedUp, AuthHasNoLoggedInUser]
          after [SignUpRequested] and received [FailureResult] with [ErrorException.emailAlreadyRegistered]
           ''',
      setup: (repoFactory, userFactory) {
        return repoFactory.setupWith(
          registerResult: MockAuthRepoMethodResult(
            result: FailureResult.fromErrorException(
                const ErrorException.emailAlreadyRegistered()),
          ),
        );
      },
      act: act,
      expectedStates: (repository, bloc, _) {
        return [
          const SignUpInProgress(),
          EmailAlreadySignedUp(),
          const AuthHasNoLoggedInUser(),
        ];
      },
      verify: verifyAfterExecution,
    );
    authBlocEventTestCase(
      desc:
          '''should emit [SignUpInProgress, LoginErrorState, AuthHasNoLoggedInUser]
          after [LoginRequested] and received [FailureResult.fromDioError]''',
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
