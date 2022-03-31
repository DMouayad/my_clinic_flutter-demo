import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/clinic_app_helper.dart';

void main() {
  group('App themeMode testing with AppearancePreferencesCubit', () {
    AppearancePreferencesCubit? preferencesCubit;
    late ClinicApp myApp;

    setUp(() async {
      if (preferencesCubit != null) {
        await preferencesCubit!.close();
      }

      preferencesCubit = AppearancePreferencesCubit();
      myApp = getClinicAppForTest(
        preferencesCubit: preferencesCubit!,
        home: Scaffold(appBar: AppBar()),
      );
    });

    tearDown(() => preferencesCubit!.close());

    testWidgets('Verify initial [themeMode] is [ThemeMode.system] ',
        (WidgetTester tester) async {
      await tester.pumpWidget(myApp);

      // EXPECT
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.system,
      );
    });
    testWidgets(
        '[AppearancePreferencesCubit] should emit [ThemeModePreferenceProvided]'
        'when calling [provideThemeMode] and app theme mode is updated',
        (WidgetTester tester) async {
      // ARRANGE
      const newThemeMode = ThemeMode.dark;

      // ACT
      await tester.pumpWidget(myApp);
      preferencesCubit!.provideThemeMode(newThemeMode);
      await tester.pumpWidget(myApp);

      // EXPECT
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        newThemeMode,
      );
      expect(
        preferencesCubit!.state,
        const ThemeModePreferenceProvided(newThemeMode),
      );
    });
  });
}
