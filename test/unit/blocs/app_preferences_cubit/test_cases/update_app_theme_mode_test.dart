import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import '../utils/app_preferences_cubit_test_case.dart';

void main() {
  test.group('update app theme mode tests', () {
    appPreferencesCubitTestCase(
      'first state is expected to be [AppPreferencesInitial]',
      expect: (cubit, repo) {
        test.expect(cubit.state, const AppPreferencesInitial());
      },
    );
    appPreferencesCubitTestCase(
      'should emit [AppPreferences] after [updateAppTheme] is called and previous state is [AppPreferences]',
      act: (cubit) async {
        cubit.setAppPreferences(ThemeMode.dark, const Locale('en'));
        Future.delayed(const Duration(milliseconds: 400),
            () => cubit.updateAppTheme(ThemeMode.system));
      },
      waitAfterAct: const Duration(milliseconds: 600),
      expect: (cubit, _) {
        return [
          const AppPreferences(ThemeMode.dark, Locale('en')),
          const AppPreferences(ThemeMode.system, Locale('en')),
        ];
      },
    );

    appPreferencesCubitTestCase(
      'should throw an assertion error after [updateAppTheme] is called and previous state is [AppPreferencesInitial]',
      act: (cubit) => cubit.updateAppTheme(ThemeMode.system),
      expectToThrows: () => test.throwsAssertionError,
    );
  });
}
