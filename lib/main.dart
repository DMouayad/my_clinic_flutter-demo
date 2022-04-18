import 'dart:io';
import 'dart:ui' as ui;
import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/app_router.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
//
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
import 'package:clinic_v2/app/infrastructure/themes/themes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app/features/auth/auth_cubit/auth_cubit.dart';
import 'core/features/authentication/data/auth_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  final parseAuthRepository = ParseAuthRepository();
  //
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  //
  HydratedBlocOverrides.runZoned(
    () {
      runApp(
        ClinicApp(
          AppearancePreferencesCubit(),
          AuthCubit(parseAuthRepository),
          parseAuthRepository,
        ),
      );
    },
    storage: storage,
  );
}

class ClinicApp extends StatelessWidget {
  const ClinicApp(
    this._preferencesCubit,
    this._authCubit,
    this._authRepository, {
    Key? key,
    this.home,
  }) : super(key: key);

  final AppearancePreferencesCubit _preferencesCubit;
  final AuthCubit _authCubit;
  final BaseAuthRepository _authRepository;

  /// ### used only for testing purposes
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _preferencesCubit),
              BlocProvider.value(value: _authCubit),
            ],
            child: BlocBuilder<AppearancePreferencesCubit,
                AppearancePreferencesState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Clinic',
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.defaultDarkTheme,
                  themeMode: (state is UserPreferencesState)
                      ? state.themeMode
                      : ThemeMode.system,
                  home: home,
                  builder: (context, app) {
                    if (_preferencesCubit.state
                        is AppearancePreferencesInitial) {
                      _preferencesCubit.provideLocale(
                        Locale(
                          kIsWeb
                              ? ui.window.locale.languageCode
                              : Platform.localeName.substring(0, 2),
                        ),
                      );
                      print(context.themeMode);
                      _preferencesCubit.provideThemeMode(context.themeMode);
                    }
                    return app!;
                  },
                  locale: (state is UserPreferencesState) ? state.locale : null,
                  onGenerateRoute: AppRoute.onGenerateRoute,
                  localeListResolutionCallback:
                      (deviceLocales, supportedLocales) {
                    final supportedLocalesCodes =
                        supportedLocales.map((e) => e.languageCode);
                    if (deviceLocales != null) {
                      for (var locale in deviceLocales) {
                        if (supportedLocalesCodes
                            .contains(locale.languageCode)) {
                          return locale;
                        }
                      }
                    }
                    return supportedLocales.first;
                  },
                  localizationsDelegates: const [
                    ...AppLocalizations.localizationsDelegates,
                    fluent_ui.DefaultFluentLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
