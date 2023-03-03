import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../utils/app_preferences_cubit_test_case.dart';
import '../utils/fake_user_preferences.dart';

void main() {
  group(
      "Testing the process of getting [AppPreferences] when there's a user login",
      () {
    const ThemeMode currentThemeMode = ThemeMode.system;
    const Locale currentLocale = Locale('en');

    const userPrefs = FakeUserPreferences(
      localePreference: Locale('ar'),
      themePreference: ThemeMode.dark,
    );

    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] if current user's [BaseUserPreferences] is
       not null and should call [repository.setUserPreferences] with these preferences''',
      act: (cubit) {
        cubit.processUserPreferences(
          userPrefs,
          appLocale: currentLocale,
          appThemeMode: currentThemeMode,
        );
      },
      verify: (cubit, repo) {
        verify(repo.setUserPreferences(userPrefs));
        verifyNoMoreInteractions(repo);
      },
      expectedStates: (cubit, repo) => () {
        return [
          AppPreferences(userPrefs.themePreference, userPrefs.localePreference),
        ];
      }(),
    )();
    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] with current app [Locale] and [ThemeMode]
       if current user's [BaseUserPreferences] is null and should call
        [repository.createUserPreferences] with these preferences''',
      setupRepository: (factory) => factory.setupWith(
        createUserPrefsResult: SuccessResult.voidResult(),
      ),
      act: (cubit) {
        cubit.processUserPreferences(
          null,
          appLocale: currentLocale,
          appThemeMode: currentThemeMode,
        );
      },
      verify: (cubit, repo) {
        verify(repo.createUserPreferences(currentThemeMode, currentLocale));
        verifyNoMoreInteractions(repo);
      },
      expectedStates: (cubit, repo) => () {
        return [
          const AppPreferences(currentThemeMode, currentLocale),
        ];
      }(),
    )();
  });
}
