import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/hydrated_bloc_helper.dart';

void main() {
  late PreferencesCubit appearancePreferencesCubit;
  setUp(() async {
    await mockHydratedStorage(() {
      appearancePreferencesCubit = PreferencesCubit();
    });
  });
  group('PreferencesCubit tests', () {
    blocTest<PreferencesCubit, PreferencesState>(
      'emits [UserPreferencesState] when calling [provideLocale].',
      build: () => appearancePreferencesCubit,
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));
      },
      expect: () => const <PreferencesState>[
        UserPreferencesState(locale: Locale('ar')),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits [UserPreferencesState] when calling [provideThemeMode].',
      build: () => appearancePreferencesCubit,
      act: (cubit) {
        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        UserPreferencesState(themeMode: ThemeMode.dark),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits tow states of type [UserPreferencesState] with the provided preferences'
      'when calling [provideLocale,provideThemeMode]',
      build: () => appearancePreferencesCubit,
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));

        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        UserPreferencesState(locale: Locale('ar')),
        UserPreferencesState(locale: Locale('ar'), themeMode: ThemeMode.dark),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits two states of type [UserPreferencesState] '
      'when calling [provideLocale] two times with different values.',
      build: () => appearancePreferencesCubit,
      act: (cubit) async {
        cubit.provideLocale(const Locale('ar'));
        Timer(const Duration(seconds: 1), () {
          cubit.provideLocale(const Locale('en'));
        });
      },
      wait: const Duration(seconds: 1),
      expect: () => const <PreferencesState>[
        UserPreferencesState(locale: Locale('ar')),
        UserPreferencesState(locale: Locale('en')),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits two states of type [ThemeModePreferenceProvided] '
      'when calling [provideThemeMode] two times with different values.',
      build: () => appearancePreferencesCubit,
      act: (cubit) async {
        cubit.provideThemeMode(ThemeMode.dark);
        Timer(const Duration(seconds: 3), () {
          cubit.provideThemeMode(ThemeMode.system);
        });
      },
      wait: const Duration(seconds: 3),
      expect: () => const <PreferencesState>[
        UserPreferencesState(themeMode: ThemeMode.dark),
        UserPreferencesState(themeMode: ThemeMode.system),
      ],
    );
  });
}
