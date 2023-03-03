import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../utils/app_preferences_cubit_test_case.dart';
import '../utils/fake_user_preferences.dart';

void main() {
  group('Setting app locale tests with no logged-in user', () {
    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] with new locale after [setAppLocale]
       is called''',
      act: (cubit) async {
        cubit.setAppLocale(const Locale('en'), currentTheme: ThemeMode.dark);
        Future.delayed(
          const Duration(milliseconds: 400),
          () => cubit.setAppLocale(const Locale('ar'),
              currentTheme: ThemeMode.dark),
        );
      },
      waitAfterAct: const Duration(milliseconds: 800),
      expectedStates: (cubit, _) {
        return [
          const AppPreferences(ThemeMode.dark, Locale('en')),
          const AppPreferences(ThemeMode.dark, Locale('ar')),
        ];
      },
    )();
    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] with new locale after [setAppLocale]
       is called and current state is [AppPreferencesInitial]''',
      act: (cubit) async {
        cubit.emit(const AppPreferencesInitial());
        cubit.setAppLocale(const Locale('en'), currentTheme: ThemeMode.dark);
      },
      expectedStates: (cubit, _) {
        return const [
          AppPreferencesInitial(),
          AppPreferences(ThemeMode.dark, Locale('en'))
        ];
      },
    )();
  });
  group("Setting app and user's locale tests", () {
    const ThemeMode currentUserThemeMode = ThemeMode.system;
    AppPreferencesCubitTestCase(
      '''should call [BaseUserPreferencesRepository.updateUserLocalePreference]
         and on success, emits [AppPreferences] state to update app's locale''',
      setupRepository: (factory) {
        return factory.setupWith(
          currentUserThemeMode: currentUserThemeMode,
          currentUserLocale: const Locale('ar'),
          updateUserLocalePreferenceResult: SuccessResult.voidResult(),
        );
      },
      seed: () => const AppPreferences(currentUserThemeMode, Locale('ar')),
      act: (cubit) async {
        cubit.setAppLocale(
          const Locale('en'),
          currentTheme: currentUserThemeMode,
        );
      },
      verify: (cubit, repo) {
        verify(repo.updateUserLocalePreference(const Locale('en')));
      },
      waitAfterAct: const Duration(seconds: 1),
      expectedStates: (cubit, repo) => const [
        AppPreferences(currentUserThemeMode, Locale('ar')),
        UpdatingUserPreferencesInProgress(),
        UserPreferencesUpdatedSuccessfully(),
        AppPreferences(currentUserThemeMode, Locale('en')),
      ],
    )();
    AppPreferencesCubitTestCase(
      '''should call [BaseUserPreferencesRepository.updateUserLocalePreference]
         and on failure, emits [UpdatingUserPreferencesFailed] with an error''',
      setupRepository: (factory) {
        return factory.setupWith(
          currentUserThemeMode: currentUserThemeMode,
          currentUserLocale: const Locale('ar'),
          updateUserLocalePreferenceResult:
              FailureResult.withAppException(AppException.noConnectionFound),
        );
      },
      seed: () => const AppPreferences(currentUserThemeMode, Locale('ar')),
      act: (cubit) async {
        cubit.setAppLocale(
          const Locale('en'),
          currentTheme: currentUserThemeMode,
        );
      },
      verify: (cubit, repo) {
        verify(repo.updateUserLocalePreference(const Locale('en')));
        // called in the expect part
        verify(repo.getUserPreferences());
        verifyNoMoreInteractions(repo);
      },
      waitAfterAct: const Duration(seconds: 1),
      expect: (_, repo) {
        expect(
            repo.getUserPreferences(),
            const FakeUserPreferences(
              localePreference: Locale('ar'),
              themePreference: currentUserThemeMode,
            ));
      },
      expectedStates: (cubit, repo) => [
        const AppPreferences(currentUserThemeMode, Locale('ar')),
        const UpdatingUserPreferencesInProgress(),
        UpdatingUserPreferencesFailed(
          AppError(appException: AppException.noConnectionFound),
        ),
      ],
    )();
  });
}
