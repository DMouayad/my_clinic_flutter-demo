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
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:clinic_v2/app/themes/fluent_themes.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:clinic_v2/app/blocs/preferences_cubit/preferences_cubit.dart';
//
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app/core/enums.dart';
import 'app/services/auth_tokens/auth_tokens_service_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(500, 700));

  // AuthTokensServiceProvider.instance.service.deleteRefreshToken();
  // AuthTokensServiceProvider.instance.service.deleteAccessToken();

  // states that Logger is working
  Log.v("Logger started | ${DateTime.now()}");
  Log.v("App is running on ${Platform.operatingSystemVersion}");

  runApp(
    ClinicApp(
      PreferencesCubit(),
      AuthBloc(
        MyClinicApiAuthRepository(
          authTokensService: AuthTokensServiceProvider.instance.service,
        ),
      )..add(const AuthInitRequested()),
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

/// Main App widget
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
          themeMode: (state is PreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          builder: appBuilder,
          initialRoute: AppRoutes.startupScreen,
          locale: (state is PreferencesStateWithData) ? state.locale : null,
          onGenerateRoute: AppRouter.onGenerateRoute,
          localeListResolutionCallback: localeResolutionCallBack,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            // fluent_ui.Deleg,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
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
          themeMode: (state is PreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          initialRoute: AppRoutes.startupScreen,
          builder: appBuilder,
          locale: (state is PreferencesStateWithData) ? state.locale : null,
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
    if (context.read<PreferencesCubit>().state is PreferencesInitial) {
      context.read<PreferencesCubit>().provideDefaultPreferences(
            context.themeMode,
            Locale(Platform.localeName.substring(0, 2)),
          );
    }
    return _AuthBlocListener(app!);
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

/// Listens to auth state changes and redirect user according to it.
///
/// Also provides [PreferencesCubit] with current user.
///
/// Uses [ClinicApp.navigatorKey] to access the app navigator.
class _AuthBlocListener extends StatelessWidget {
  const _AuthBlocListener(
    this.child, {
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthHasLoggedInUser) {
          context
              .read<PreferencesCubit>()
              .provideUserPreferences(state.currentUser.preferences);

          // await Future.delayed(const Duration(milliseconds: 400));
          if (state.currentUser.role == UserRole.admin) {
            ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.adminPanelScreen,
              (route) => route.isFirst,
            );
          }
          if (state.currentUser.role == UserRole.dentist) {
            //TODO:: Navigate to dentist preferences setup
          }
          if (state.currentUser.role == UserRole.secretary) {
            //TODO:: Navigate to secretary preferences setup
          }
        } else if (state is AuthHasNoLoggedInUser) {
          context.read<PreferencesCubit>().provideDefaultPreferences(
                context.themeMode,
                context.locale,
              );
          ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.loginScreen,
            (route) => route.isFirst,
          );
        }
      },
      child: child,
    );
  }
}
