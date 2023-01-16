import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:meta/meta.dart';

import 'user_preferences_repository_mock_factory.dart';
import 'user_preferences_repository_mock_factory.mocks.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

@isTest
void appPreferencesCubitTestCase(
  String description, {
  UserPreferencesRepositoryMockFactory Function(
          UserPreferencesRepositoryMockFactory factory)?
      setupRepository,
  dynamic Function(AppPreferencesCubit cubit)? act,
  dynamic Function(AppPreferencesCubit cubit,
          MockBaseUserPreferencesRepository repository)?
      expect,
  List<AppPreferencesState> Function(AppPreferencesCubit cubit,
          MockBaseUserPreferencesRepository repository)?
      expectedStates,
  dynamic Function(AppPreferencesCubit, MockBaseUserPreferencesRepository)?
      verify,
  Duration waitAfterAct = Duration.zero,
  dynamic Function()? expectToThrows,
}) {
  flutter_test.test(description, () async {
    UserPreferencesRepositoryMockFactory repoFactory =
        UserPreferencesRepositoryMockFactory();

    if (setupRepository != null) {
      repoFactory = setupRepository(repoFactory);
    }
    final mockRepository = repoFactory.create();
    final cubit =
        AppPreferencesCubit(mockRepository, shouldLogCubitChange: false);
    if (act != null) {
      if (expectToThrows != null) {
        Future.delayed(waitAfterAct, () {
          flutter_test.expect(act(cubit), expectToThrows());
        });
      } else {
        act(cubit);
      }
    }

    Future.delayed(waitAfterAct, () {
      if (expect != null) {
        expect(cubit, mockRepository);
      }
      if (expectedStates != null) {
        flutter_test.expect(
          cubit.stream,
          flutter_test.emitsInOrder(expectedStates(cubit, mockRepository)),
        );
      }
      if (verify != null) {
        verify(cubit, mockRepository);
      }
    });
  });
}
