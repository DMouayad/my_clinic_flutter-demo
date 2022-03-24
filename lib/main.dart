import 'package:clinic_v2/app/features/preferences/cubit/preferences_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/app_router.dart';
import 'package:clinic_v2/core/features/authentication/domain/auth_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
import 'package:clinic_v2/app/infrastructure/themes/themes.dart';

import 'app/features/auth/cubit/auth_cubit.dart';
import 'core/features/authentication/data/auth_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = ParseAuthRepository();

  runApp(
    ClinicApp(
      PreferencesCubit(),
      AuthCubit(authRepository),
      authRepository,
    ),
  );
}

class ClinicApp extends StatelessWidget {
  const ClinicApp(this._preferencesCubit, this._authCubit, this._authRepository,
      {Key? key, this.home})
      : super(key: key);
  final PreferencesCubit _preferencesCubit;
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
            child: BlocBuilder<PreferencesCubit, PreferencesState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Clinic',
                  
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.defaultDarkTheme,
                  themeMode: (state is ThemeModePreferenceProvided)
                      ? state.themeMode
                      : ThemeMode.system,
                  home: home,
                  locale: (state is LocalePreferenceProvided)
                      ? state.locale
                      : AppLocalizations.supportedLocales.first,
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
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
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
