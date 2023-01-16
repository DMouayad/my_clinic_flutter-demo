import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../utils/app_preferences_cubit_test_case.dart';

void main() {
  group('update app locale tests', () {
    appPreferencesCubitTestCase(
      'first state is expected to be [AppPreferencesInitial]',
      expect: (cubit, repo) {
        expect(cubit.state, const AppPreferencesInitial());
      },
    );
    appPreferencesCubitTestCase(
      '''should emit [AppPreferences] with new locale after [updateAppLocale]
       is called and previous state is [AppPreferences]''',
      act: (cubit) async {
        cubit.setAppPreferences(ThemeMode.dark, const Locale('en'));
        Future.delayed(const Duration(milliseconds: 400),
            () => cubit.updateAppLocale(const Locale('ar')));
      },
      waitAfterAct: const Duration(milliseconds: 600),
      expect: (cubit, _) {
        return [
          const AppPreferences(ThemeMode.dark, Locale('en')),
          const AppPreferences(ThemeMode.dark, Locale('ar')),
        ];
      },
    );

    appPreferencesCubitTestCase(
      'should throw an assertion error after [updateAppLocale] is called and previous state is [AppPreferencesInitial]',
      act: (cubit) => cubit.updateAppLocale(const Locale('ar')),
      expectToThrows: () => throwsAssertionError,
    );
  });
}
