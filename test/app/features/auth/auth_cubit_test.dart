import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'auth_cubit_test.mocks.dart';
import 'auth_cubit_test_helpers.dart';

@GenerateMocks([BaseAuthRepository, AuthCubit])
void main() {
  group(
    'AuthCubit test',
    () {
      final authRepository = MockBaseAuthRepository();
      blocTest<AuthCubit, AuthState>(
        "should emit [AuthHasNoLoggedInUser] when [loadCurrentUser] "
        "is called and we doesn't have a logged-in user.",
        setUp: () => setupMockedAuthRepoWithNoLoggedInUser(authRepository),
        build: () => AuthCubit(authRepository),
        act: (cubit) => cubit.loadCurrentUser(),
        expect: () => const <AuthState>[AuthHasNoLoggedInUser()],
      );
      blocTest<AuthCubit, AuthState>(
        'should emit [AuthHasLoggedInUser] when [loadCurrentUser] is called'
        'and we have a logged-in user',
        setUp: () => setupMockedAuthRepoWithLoggedInUser(authRepository),
        build: () => AuthCubit(authRepository),
        act: (cubit) => cubit.loadCurrentUser(),
        expect: () => const <AuthState>[AuthHasLoggedInUser()],
      );
    },
  );
}
