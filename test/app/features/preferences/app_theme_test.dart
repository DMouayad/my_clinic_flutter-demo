import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/clinic_app_helper.dart';
import '../../../helpers/hydrated_bloc_helper.dart';

void main() {
  group('App themeMode testing with AppPreferencesCubit', () {
    AppPreferencesCubit? AppPreferencesCubit;
    late ClinicApp myApp;

    setUp(() async {
      if (AppPreferencesCubit != null) {
        await AppPreferencesCubit!.close();
      }
      await mockHydratedStorage(() async {
        AppPreferencesCubit = AppPreferencesCubit();
        myApp = getClinicAppForTest(
          AppPreferencesCubit: AppPreferencesCubit!,
          home: Scaffold(appBar: AppBar()),
        );
      });
    });

    tearDown(() => AppPreferencesCubit!.close());

    testWidgets(
        'expect app [themeMode] to be [ThemeMode.dark] after calling [provideThemeMode]',
        (WidgetTester tester) async {
      // ARRANGE
      const newThemeMode = ThemeMode.dark;

      // ACT
      await tester.pumpWidget(myApp);
      AppPreferencesCubit!.provideThemeMode(newThemeMode);
      await tester.pumpWidget(myApp);

      // EXPECT
      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        newThemeMode,
      );
    });
  });
}
