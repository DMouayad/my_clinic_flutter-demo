import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'auth_cubit_test.mocks.dart';
import '../../../unit/blocs/auth_bloc/mock_auth_repository_factory.dart';

void main() {
  group(
    'AuthBloc test',
    () {
      final authRepository = MockBaseAuthRepository();
      blocTest<AuthBloc, AuthState>(
        "should emit [AuthHasNoLoggedInUser] when [loadCurrentUser] "
        "is called and we doesn't have a logged-in user.",
        setUp: () => setupMockedAuthRepoWithNoLoggedInUser(authRepository),
        build: () => AuthBloc(authRepository),
        act: (cubit) => cubit.getAuthState(),
        expect: () => const <AuthState>[AuthHasNoLoggedInUser()],
      );
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthHasLoggedInUser] when [loadCurrentUser] is called'
        'and we have a logged-in user',
        setUp: () => setupMockedAuthRepoWithLoggedInUser(authRepository),
        build: () => AuthBloc(authRepository),
        act: (cubit) => cubit.getAuthState(),
        expect: () => const <AuthState>[AuthHasLoggedInUser()],
      );
    },
  );
}
