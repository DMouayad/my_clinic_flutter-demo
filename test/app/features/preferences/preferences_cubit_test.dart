import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/app_preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/hydrated_bloc_helper.dart';

void main() {
  late AppPreferencesCubit appearanceAppPreferencesCubit;
  setUp(() async {
    await mockHydratedStorage(() {
      appearanceAppPreferencesCubit = AppPreferencesCubit();
    });
  });
  group('AppPreferencesCubit tests', () {
    blocTest<AppPreferencesCubit, AppPreferencesState>(
      'emits [AppPreferencesState] when calling [provideLocale].',
      build: () => appearanceAppPreferencesCubit,
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));
      },
      expect: () => const <AppPreferencesState>[
        AppPreferencesState(locale: Locale('ar')),
      ],
    );
    blocTest<AppPreferencesCubit, AppPreferencesState>(
      'emits [AppPreferencesState] when calling [provideThemeMode].',
      build: () => appearanceAppPreferencesCubit,
      act: (cubit) {
        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <AppPreferencesState>[
        AppPreferencesState(themeMode: ThemeMode.dark),
      ],
    );
    blocTest<AppPreferencesCubit, AppPreferencesState>(
      'emits tow states of type [AppPreferencesState] with the provided preferences'
      'when calling [provideLocale,provideThemeMode]',
      build: () => appearanceAppPreferencesCubit,
      act: (cubit) {
        cubit.provideLocale(const Locale('ar'));

        cubit.provideThemeMode(ThemeMode.dark);
      },
      expect: () => const <AppPreferencesState>[
        AppPreferencesState(locale: Locale('ar')),
        AppPreferencesState(locale: Locale('ar'), themeMode: ThemeMode.dark),
      ],
    );
    blocTest<AppPreferencesCubit, AppPreferencesState>(
      'emits two states of type [AppPreferencesState] '
      'when calling [provideLocale] two times with different values.',
      build: () => appearanceAppPreferencesCubit,
      act: (cubit) async {
        cubit.provideLocale(const Locale('ar'));
        Timer(const Duration(seconds: 1), () {
          cubit.provideLocale(const Locale('en'));
        });
      },
      wait: const Duration(seconds: 1),
      expect: () => const <AppPreferencesState>[
        AppPreferencesState(locale: Locale('ar')),
        AppPreferencesState(locale: Locale('en')),
      ],
    );
    blocTest<AppPreferencesCubit, AppPreferencesState>(
      'emits two states of type [ThemeModePreferenceProvided] '
      'when calling [provideThemeMode] two times with different values.',
      build: () => appearanceAppPreferencesCubit,
      act: (cubit) async {
        cubit.provideThemeMode(ThemeMode.dark);
        Timer(const Duration(seconds: 3), () {
          cubit.provideThemeMode(ThemeMode.system);
        });
      },
      wait: const Duration(seconds: 3),
      expect: () => const <AppPreferencesState>[
        AppPreferencesState(themeMode: ThemeMode.dark),
        AppPreferencesState(themeMode: ThemeMode.system),
      ],
    );
  });
}
