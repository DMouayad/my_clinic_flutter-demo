import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/clinic_app_helper.dart';
import '../../../helpers/hydrated_bloc_helper.dart';

void main() {
  group('App themeMode testing with AppearancePreferencesCubit', () {
    AppearancePreferencesCubit? preferencesCubit;
    late ClinicApp myApp;

    setUp(() async {
      if (preferencesCubit != null) {
        await preferencesCubit!.close();
      }
      await mockHydratedStorage(() async {
        preferencesCubit = AppearancePreferencesCubit();
        myApp = getClinicAppForTest(
          preferencesCubit: preferencesCubit!,
          home: Scaffold(appBar: AppBar()),
        );
      });
    });

    tearDown(() => preferencesCubit!.close());

    testWidgets(
        'expect app [themeMode] to be [ThemeMode.dark] after calling [provideThemeMode]',
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
    });
  });
}
