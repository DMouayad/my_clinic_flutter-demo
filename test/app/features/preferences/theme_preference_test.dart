import 'package:clinic_v2/app/features/preferences/cubit/preferences_cubit.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App themeMode testing with PreferencesCubit', () {
    PreferencesCubit? preferencesCubit;
    late ClinicApp myApp;

    setUp(() async {
      if (preferencesCubit != null) {
        await preferencesCubit!.close();
      }

      preferencesCubit = PreferencesCubit();
      myApp = ClinicApp(
        preferencesCubit!,
        home: Scaffold(appBar: AppBar()),
      );
    });

    tearDown(() => preferencesCubit!.close());

    testWidgets('Verify initial [themMode] is [ThemeMode.system] ',
        (WidgetTester tester) async {
      await tester.pumpWidget(myApp);

      // EXPECT
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.system,
      );
    });
    testWidgets(
        '[PreferencesCubit] should emit [ThemeModePreferenceProvided]'
        'when calling [provideThemeMode] and App them mode is updated',
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
