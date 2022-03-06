import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/preferences/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PreferencesCubit tests', () {
    blocTest<PreferencesCubit, PreferencesState>(
      'emits [LocalePreferenceProvided] when calling [provideLocale].',
      build: () => PreferencesCubit(),
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));
      },
      expect: () => const <PreferencesState>[
        LocalePreferenceProvided(Locale('ar')),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits [ThemeModePreferenceProvided] when calling [provideThemeMode].',
      build: () => PreferencesCubit(),
      act: (cubit) {
        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        ThemeModePreferenceProvided(ThemeMode.dark),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits [ThemeModePreferenceProvided,LocalePreferenceProvided] '
      'when calling [provideLocale,provideThemeMode].',
      build: () => PreferencesCubit(),
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));

        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        LocalePreferenceProvided(Locale('ar')),
        ThemeModePreferenceProvided(ThemeMode.dark),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits two states of type [LocalePreferenceProvided] '
      'when calling [provideLocale] two times with different values.',
      build: () => PreferencesCubit(),
      act: (cubit) async {
        cubit.provideLocale(const Locale('ar'));
        Timer(const Duration(seconds: 1), () {
          cubit.provideLocale(const Locale('en'));
        });
      },
      wait: const Duration(seconds: 1),
      expect: () => const <PreferencesState>[
        LocalePreferenceProvided(Locale('ar')),
        LocalePreferenceProvided(Locale('en')),
      ],
    );
    blocTest<PreferencesCubit, PreferencesState>(
      'emits two states of type [ThemeModePreferenceProvided] '
      'when calling [provideThemeMode] two times with different values.',
      build: () => PreferencesCubit(),
      act: (cubit) async {
        cubit.provideThemeMode(ThemeMode.dark);
        Timer(const Duration(seconds: 3), () {
          cubit.provideThemeMode(ThemeMode.system);
        });
      },
      wait: const Duration(seconds: 3),
      expect: () => const <PreferencesState>[
        ThemeModePreferenceProvided(ThemeMode.dark),
        ThemeModePreferenceProvided(ThemeMode.system),
      ],
    );
  });
}
