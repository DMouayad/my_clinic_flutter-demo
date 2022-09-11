import 'package:clinic_v2/common/common/entities/custom_response.dart';
import 'package:mockito/mockito.dart';

import 'auth_cubit_test.mocks.dart';

void setupMockedAuthRepoWithLoggedInUser(
  MockBaseAuthRepository authRepository,
) {
  when(authRepository.init()).thenAnswer((_) async => true);
  when(authRepository.loadCurrentUser())
      .thenAnswer((_) async => SuccessResult());
  when(authRepository.hasLoggedInUser()).thenReturn(true);
}

void setupMockedAuthRepoWithNoLoggedInUser(
  MockBaseAuthRepository authRepository,
) {
  when(authRepository.init()).thenAnswer((_) async => true);
  when(authRepository.loadCurrentUser())
      .thenAnswer((_) async => SuccessResult());
  when(authRepository.hasLoggedInUser()).thenReturn(false);
}
