import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppearancePreferencesCubit tests', () {
    blocTest<AppearancePreferencesCubit, PreferencesState>(
      'emits [LocalePreferenceProvided] when calling [provideLocale].',
      build: () => AppearancePreferencesCubit(),
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));
      },
      expect: () => const <PreferencesState>[
        LocalePreferenceProvided(Locale('ar')),
      ],
    );
    blocTest<AppearancePreferencesCubit, PreferencesState>(
      'emits [ThemeModePreferenceProvided] when calling [provideThemeMode].',
      build: () => AppearancePreferencesCubit(),
      act: (cubit) {
        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        ThemeModePreferenceProvided(ThemeMode.dark),
      ],
    );
    blocTest<AppearancePreferencesCubit, PreferencesState>(
      'emits [ThemeModePreferenceProvided,LocalePreferenceProvided] '
      'when calling [provideLocale,provideThemeMode].',
      build: () => AppearancePreferencesCubit(),
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));

        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <PreferencesState>[
        LocalePreferenceProvided(Locale('ar')),
        ThemeModePreferenceProvided(ThemeMode.dark),
      ],
    );
    blocTest<AppearancePreferencesCubit, PreferencesState>(
      'emits two states of type [LocalePreferenceProvided] '
      'when calling [provideLocale] two times with different values.',
      build: () => AppearancePreferencesCubit(),
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
    blocTest<AppearancePreferencesCubit, PreferencesState>(
      'emits two states of type [ThemeModePreferenceProvided] '
      'when calling [provideThemeMode] two times with different values.',
      build: () => AppearancePreferencesCubit(),
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
