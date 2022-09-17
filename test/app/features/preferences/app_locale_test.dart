import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../helpers/clinic_app_helper.dart';
import '../../../helpers/hydrated_bloc_helper.dart';

void main() {
  group('App locale tests using PreferencesCubit', () {
    PreferencesCubit? preferencesCubit;
    late ClinicApp myApp;

    setUp(() async {
      if (preferencesCubit != null) {
        await preferencesCubit!.close();
      }
      await mockHydratedStorage(() async {
        preferencesCubit = PreferencesCubit();
        myApp = getClinicAppForTest(
          preferencesCubit: preferencesCubit!,
          home: Scaffold(appBar: AppBar()),
        );
      });
    });

    tearDown(() => preferencesCubit!.close());
    //
    group('Verify initial locale based on the device locale', () {
      testWidgets(
        "Device locales contains only one supported locale"
        " which should be assigned to the app locale",
        (WidgetTester tester) async {
          // ARRANGE
          const deviceLocales = [Locale('ar')];
          const supportedLocales = AppLocalizations.supportedLocales;

          // ACT
          await tester.pumpWidget(myApp);

          // EXPECT
          expect(
            tester
                .widget<MaterialApp>(find.byType(MaterialApp))
                .localeListResolutionCallback!(deviceLocales, supportedLocales),
            const Locale('ar'),
          );
        },
      );

      testWidgets(
        "Device locales contains more than one supported locale"
        "then the app's locale is set to the first supported device-locale",
        (WidgetTester tester) async {
          // ARRANGE
          const deviceLocales = [Locale('en'), Locale('ar')];
          const supportedLocales = AppLocalizations.supportedLocales;

          // ACT
          await tester.pumpWidget(myApp);

          // EXPECT
          expect(
            tester
                .widget<MaterialApp>(find.byType(MaterialApp))
                .localeListResolutionCallback!(deviceLocales, supportedLocales),

            deviceLocales
                .firstWhere((element) => supportedLocales.contains(element)),
            // const Locale('en'),
          );
        },
      );
      testWidgets(
        "Device locales DOESN'T contains a supported locale"
        "then the app's locale is set to the first supported locale",
        (WidgetTester tester) async {
          // ARRANGE
          const deviceLocales = [Locale('fr')];
          const supportedLocales = AppLocalizations.supportedLocales;

          // ACT
          await tester.pumpWidget(myApp);

          // EXPECT
          expect(
            tester
                .widget<MaterialApp>(find.byType(MaterialApp))
                .localeListResolutionCallback!(deviceLocales, supportedLocales),
            supportedLocales.first,
          );
        },
      );
    });

    group(
      'PreferencesCubit updating app-locale tests',
      () {
        testWidgets(
          'Verify app locale is updated after calling [provideLocale]',
          (WidgetTester tester) async {
            // ARRANGE
            const newLocale = Locale('en');

            // ACT
            await tester.pumpWidget(myApp);

            preferencesCubit!.provideLocale(newLocale);
            await tester.pumpWidget(myApp);

            // EXPECT
            expect(preferencesCubit!.state,
                const UserPreferencesState(locale: newLocale));
            expect(
              tester.widget<MaterialApp>(find.byType(MaterialApp)).locale,
              newLocale,
            );
          },
        );
      },
    );
  });
}
