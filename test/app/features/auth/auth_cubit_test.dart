import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:clinic_v2/core/features/users/domain/src/entities/base_server_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'auth_cubit_test.mocks.dart';
import 'auth_cubit_test_helpers.dart';

@GenerateMocks([BaseAuthRepository, BaseServerUser])
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
        act: (cubit) => cubit.getAuthState(),
        expect: () => const <AuthState>[AuthHasNoLoggedInUser()],
      );
      blocTest<AuthCubit, AuthState>(
        'should emit [AuthHasLoggedInUser] when [loadCurrentUser] is called'
        'and we have a logged-in user',
        setUp: () => setupMockedAuthRepoWithLoggedInUser(authRepository),
        build: () => AuthCubit(authRepository),
        act: (cubit) => cubit.getAuthState(),
        expect: () => const <AuthState>[AuthHasLoggedInUser()],
      );
    },
  );
}
