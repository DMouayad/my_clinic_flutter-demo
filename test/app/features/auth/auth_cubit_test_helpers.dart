import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

void setupMockedAuthRepoWithLoggedInUser(
  MockBaseAuthRepository authRepository,
) {
  when(authRepository.init()).thenAnswer((_) async {
    // authRepository.currentUser =
  });
  when(authRepository.hasLoggedInUser()).thenReturn(true);
}

void setupMockedAuthRepoWithNoLoggedInUser(
  MockBaseAuthRepository authRepository,
) {
  when(authRepository.init()).thenAnswer((_) async {});
  when(authRepository.hasLoggedInUser()).thenReturn(false);
}
