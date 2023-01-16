import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../utils/app_preferences_cubit_test_case.dart';

void main() {
  group('provide app preferences tests', () {
    appPreferencesCubitTestCase(
      '''should emit [AppPreferences] with provided locale and theme mode after [setAppPreferences]
       is called''',
      act: (cubit) async {
        cubit.setAppPreferences(ThemeMode.dark, const Locale('en'));
      },
      expectedStates: (cubit, _) {
        return [const AppPreferences(ThemeMode.dark, Locale('en'))];
      },
    );
  });
}
