import 'dart:io';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
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
import 'package:clinic_v2/app/infrastructure/themes/material_themes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'app/features/auth/auth_cubit/auth_cubit.dart';
import 'app/infrastructure/themes/fluent_themes.dart';
import 'core/features/authentication/data/auth_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(560, 700));
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
      // doWhenWindowReady(() {
      //   final initialSize = Size(600, 450);
      //   appWindow.minSize = initialSize;
      //   // appWindow.size = initialSize;
      //   appWindow.alignment = Alignment.center;
      //   appWindow.show();
      // });
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
            child: context.isWindowsPlatform
                ? _WindowsApp(home: home)
                : _AndroidApp(home: home),
          );
        },
      ),
    );
  }
}

class _WindowsApp extends StatelessWidget with _ClinicAppHelper {
  const _WindowsApp({this.home, Key? key}) : super(key: key);

  /// ### used only for testing purposes
  final Widget? home;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppearancePreferencesCubit, AppearancePreferencesState>(
        builder: (context, state) {
      return fluent_ui.FluentApp(
        title: 'Clinic',
        debugShowCheckedModeBanner: false,
        theme: FluentAppThemes.lightTheme,
        darkTheme: FluentAppThemes.defaultDarkTheme,
        themeMode: (state is UserPreferencesState)
            ? state.themeMode
            : ThemeMode.system,
        home: home,
        builder: appBuilder,
        locale: (state is UserPreferencesState) ? state.locale : null,
        onGenerateRoute: AppRoute.onGenerateRoute,
        localeListResolutionCallback: localeResolutionCallBack,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          fluent_ui.DefaultFluentLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    });
  }
}

class _AndroidApp extends StatelessWidget with _ClinicAppHelper {
  const _AndroidApp({this.home, Key? key}) : super(key: key);

  /// ### used only for testing purposes
  final Widget? home;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppearancePreferencesCubit, AppearancePreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Clinic',
          debugShowCheckedModeBanner: false,
          theme: MaterialAppThemes.lightTheme,
          darkTheme: MaterialAppThemes.defaultDarkTheme,
          themeMode: (state is UserPreferencesState)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          builder: appBuilder,
          locale: (state is UserPreferencesState) ? state.locale : null,
          onGenerateRoute: AppRoute.onGenerateRoute,
          localeListResolutionCallback: localeResolutionCallBack,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

mixin _ClinicAppHelper {
  Widget appBuilder(BuildContext context, Widget? app) {
    final preferencesCubit = context.read<AppearancePreferencesCubit>();
    if (preferencesCubit.state is AppearancePreferencesInitial) {
      preferencesCubit.provideLocale(
        Locale(
          Platform.localeName.substring(0, 2),
        ),
      );
      preferencesCubit.provideThemeMode(context.themeMode);
    }
    return app!;
  }

  Locale localeResolutionCallBack(
      List<Locale>? deviceLocales, Iterable<Locale> supportedLocales) {
    final supportedLocalesCodes = supportedLocales.map((e) => e.languageCode);
    if (deviceLocales != null) {
      for (var locale in deviceLocales) {
        if (supportedLocalesCodes.contains(locale.languageCode)) {
          return locale;
        }
      }
    }
    return supportedLocales.first;
  }
}
