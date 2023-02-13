import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../utils/app_preferences_cubit_test_case.dart';
import '../utils/fake_user_preferences.dart';

void main() {
  group('Setting app theme mode tests with no logged-in user', () {
    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] with new [ThemeMode] after [setAppThemeMode]
       is called''',
      act: (cubit) async {
        cubit.setAppLocale(const Locale('en'), currentTheme: ThemeMode.dark);
        Future.delayed(
          const Duration(milliseconds: 400),
          () => cubit.setAppThemeMode(
            ThemeMode.light,
            currentLocale: const Locale('en'),
          ),
        );
      },
      waitAfterAct: const Duration(milliseconds: 800),
      expectedStates: (cubit, _) {
        return [
          const AppPreferences(ThemeMode.dark, Locale('en')),
          const AppPreferences(ThemeMode.light, Locale('en')),
        ];
      },
    )();
    AppPreferencesCubitTestCase(
      '''should emit [AppPreferences] with new [ThemeMode] after [setAppThemeMode]
       is called and current state is [AppPreferencesInitial]''',
      act: (cubit) async {
        cubit.emit(const AppPreferencesInitial());
        cubit.setAppThemeMode(
          ThemeMode.light,
          currentLocale: const Locale('en'),
        );
      },
      expectedStates: (cubit, _) {
        return const [
          AppPreferencesInitial(),
          AppPreferences(ThemeMode.light, Locale('en')),
        ];
      },
    )();
  });
  group("Setting app and user's [ThemeMode] tests", () {
    const ThemeMode currentUserThemeMode = ThemeMode.system;
    const ThemeMode newUserThemeMode = ThemeMode.light;
    const Locale currentUserLocale = Locale('en');
    AppPreferencesCubitTestCase(
      '''should call [BaseUserPreferencesRepository.updateUserThemePreference]
         and on success, emits [AppPreferences] state to update app's [ThemeMode]''',
      setupRepository: (factory) {
        return factory.setupWith(
          currentUserThemeMode: currentUserThemeMode,
          currentUserLocale: currentUserLocale,
          updateUserThemePreferenceResult: SuccessResult.voidResult(),
        );
      },
      seed: () => const AppPreferences(currentUserThemeMode, currentUserLocale),
      act: (cubit) async {
        cubit.setAppThemeMode(
          newUserThemeMode,
          currentLocale: const Locale('en'),
        );
      },
      verify: (cubit, repo) {
        verify(repo.updateUserThemePreference(ThemeMode.light));
      },
      waitAfterAct: const Duration(seconds: 2),
      expectedStates: (cubit, repo) => const [
        AppPreferences(currentUserThemeMode, currentUserLocale),
        UpdatingUserPreferencesInProgress(),
        UserPreferencesUpdatedSuccessfully(),
        AppPreferences(newUserThemeMode, currentUserLocale),
      ],
    )();
    AppPreferencesCubitTestCase(
      '''should call [BaseUserPreferencesRepository.updateUserThemePreference]
         and on failure, emits [UpdatingUserPreferencesFailed] with an error''',
      setupRepository: (factory) {
        return factory.setupWith(
          currentUserThemeMode: currentUserThemeMode,
          currentUserLocale: currentUserLocale,
          updateUserThemePreferenceResult:
              FailureResult.withAppException(AppException.noConnectionFound),
        );
      },
      seed: () => const AppPreferences(currentUserThemeMode, currentUserLocale),
      act: (cubit) async {
        cubit.setAppThemeMode(
          newUserThemeMode,
          currentLocale: currentUserLocale,
        );
      },
      verify: (cubit, repo) {
        verify(repo.updateUserThemePreference(newUserThemeMode));
        // called in the expect part
        verify(repo.getUserPreferences());
        verifyNoMoreInteractions(repo);
      },
      waitAfterAct: const Duration(seconds: 2),
      expect: (_, repo) {
        // expect that [ThemeMode] was not changed
        expect(
            repo.getUserPreferences(),
            const FakeUserPreferences(
              localePreference: currentUserLocale,
              themePreference: currentUserThemeMode,
            ));
      },
      expectedStates: (cubit, repo) => [
        const AppPreferences(currentUserThemeMode, currentUserLocale),
        const UpdatingUserPreferencesInProgress(),
        UpdatingUserPreferencesFailed(
          AppError(appException: AppException.noConnectionFound),
        ),
      ],
    )();
  });
}
