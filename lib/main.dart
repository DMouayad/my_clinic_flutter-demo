import 'dart:io';
import 'package:flutter/material.dart';
//
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/navigation/app_router.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/services/auth_token/auth_token_service.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:clinic_v2/app/themes/fluent_themes.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:clinic_v2/app/blocs/preferences_cubit/preferences_cubit.dart';
//
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(660, 700));
  AuthTokenServiceProvider.instance.service.deleteRefreshToken();
  AuthTokenServiceProvider.instance.service.deleteAccessToken();
  //
  Log.i("Logger is working");
  runApp(
    ClinicApp(
      PreferencesCubit(),
      AuthBloc(
        MyClinicApiAuthRepository(
          authTokensService: AuthTokenServiceProvider.instance.service,
        ),
      ),
    ),
  );
  // doWhenWindowReady(() {
  //   final initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   // appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.show();
  // });
}

class ClinicApp extends StatelessWidget {
  const ClinicApp(
    this._preferencesCubit,
    this._authCubit, {
    Key? key,
    this.home,
  }) : super(key: key);

  final PreferencesCubit _preferencesCubit;
  final AuthBloc _authCubit;

  /// ### used only for testing purposes
  final Widget? home;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _preferencesCubit),
        BlocProvider(create: (_) => _authCubit),
      ],
      child: context.isWindowsPlatform
          ? _WindowsApp(navigatorKey, home: home)
          : _AndroidApp(navigatorKey, home: home),
    );
  }
}

class _WindowsApp extends StatelessWidget with _ClinicAppHelper {
  const _WindowsApp(this.navigatorKey, {this.home, Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;

  /// ### used only for testing purposes
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
        builder: (context, state) {
      return fluent_ui.FluentApp(
        title: 'Clinic',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: FluentAppThemes.lightTheme,
        darkTheme: FluentAppThemes.defaultDarkTheme,
        themeMode: (state is UserPreferencesState)
            ? state.themeMode
            : ThemeMode.system,
        home: home,
        builder: appBuilder,
        initialRoute: Routes.startupScreen,
        locale: (state is UserPreferencesState) ? state.locale : null,
        onGenerateRoute: AppRouter.onGenerateRoute,
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
  const _AndroidApp(this.navigatorKey, {this.home, Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;

  /// ### used only for testing purposes
  final Widget? home;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Clinic',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: MaterialAppThemes.lightTheme,
          darkTheme: MaterialAppThemes.defaultDarkTheme,
          themeMode: (state is UserPreferencesState)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          initialRoute: Routes.startupScreen,
          builder: appBuilder,
          locale: (state is UserPreferencesState) ? state.locale : null,
          onGenerateRoute: AppRouter.onGenerateRoute,
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
    final preferencesCubit = context.read<PreferencesCubit>();
    if (preferencesCubit.state is AppearancePreferencesInitial) {
      preferencesCubit.provideLocale(
        Locale(Platform.localeName.substring(0, 2)),
      );
      preferencesCubit.provideThemeMode(context.themeMode);
    }
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthHasLoggedInUser) {
          ClinicApp.navigatorKey.currentState
              ?.popAndPushNamed(Routes.homeScreenRoute);
        }
        if (state is AuthHasNoLoggedInUser) {
          ClinicApp.navigatorKey.currentState
              ?.popAndPushNamed(Routes.loginScreenRoute);
        }
      },
      child: app!,
    );
  }

  Locale localeResolutionCallBack(
      List<Locale>? deviceLocales, Iterable<Locale> supportedLocales) {
    final supportedLocalesCodes = supportedLocales.map((e) => e.languageCode);
    if (deviceLocales != null) {
      for (var locale in deviceLocales) {
        if (supportedLocalesCodes.contains(locale.languageCode)) {
          return Locale(locale.languageCode);
        }
      }
    }
    return supportedLocales.first;
  }
}
