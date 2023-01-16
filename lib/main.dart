import 'dart:io';
import 'package:clinic_v2/app/services/socketio/socketio_notifications_listener.dart';
import 'package:clinic_v2/domain/notifications/base/base_notifications_listener.dart';
import 'package:flutter/material.dart';

//
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/navigation/app_router.dart';
import 'package:clinic_v2/presentation/themes/material_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';
import 'package:get_it/get_it.dart';
//

import 'app/services/socketio/socketio_provider.dart';
import 'utils/extensions/context_extensions.dart';
import 'app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'app/services_providers/auth_tokens_service_provider.dart';
import 'domain/authentication/base/base_auth_repository.dart';
import 'domain/user_preferences/base/base_user_preferences_repository.dart';
import 'domain/user_preferences/data/my_clinic_api_user_preferences_repository.dart';
import 'presentation/navigation/src/routes.dart';
import 'presentation/themes/fluent_themes.dart';
import 'shared/services/logger_service.dart';
import 'domain/authentication/data/my_clinic_api_auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(400, 700));

  // AuthTokensServiceProvider.instance.service.deleteRefreshToken();
  // AuthTokensServiceProvider.instance.service.deleteAccessToken();

  // states that Logger is working
  Log.v("Logger started | ${DateTime.now()}");
  Log.v("App is running on ${Platform.operatingSystemVersion}");

  GetIt.I.registerSingleton(SocketIoProvider());
  GetIt.I.registerSingleton<BaseNotificationsListener>(
      SocketIoNotificationsListener());

  runApp(
    ClinicApp(
      userPreferencesRepository: MyClinicApiUserPreferencesRepository(),
      authRepository: MyClinicApiAuthRepository(
        authTokensService: AuthTokensServiceProvider.instance.service,
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

/// Main App widget
class ClinicApp extends StatelessWidget {
  const ClinicApp({
    required this.authRepository,
    required this.userPreferencesRepository,
    Key? key,
    this.home,
  }) : super(key: key);

  final BaseUserPreferencesRepository userPreferencesRepository;
  final BaseAuthRepository authRepository;

  /// ### used only for testing purposes
  final Widget? home;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppPreferencesCubit(userPreferencesRepository),
          ),
          BlocProvider(
            create: (context) => AuthBloc(context.read<BaseAuthRepository>())
              ..add(const AuthInitRequested()),
          ),
        ],
        child: context.isWindowsPlatform
            ? _WindowsApp(navigatorKey, home: home)
            : _AndroidApp(navigatorKey, home: home),
      ),
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
    return BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
      builder: (context, state) {
        return fluent_ui.FluentApp(
          title: 'MyClinic',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: FluentAppThemes.lightTheme,
          darkTheme: FluentAppThemes.defaultDarkTheme,
          themeMode: (state is AppPreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          builder: appBuilder,
          initialRoute: AppRoutes.startupScreen,
          locale: (state is AppPreferencesStateWithData) ? state.locale : null,
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
    return BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'MyClinic',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: MaterialAppThemes.lightTheme,
          darkTheme: MaterialAppThemes.defaultDarkTheme,
          themeMode: (state is AppPreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          initialRoute: AppRoutes.startupScreen,
          builder: appBuilder,
          locale: (state is AppPreferencesStateWithData) ? state.locale : null,
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
    if (context.read<AppPreferencesCubit>().state is AppPreferencesInitial) {
      context.read<AppPreferencesCubit>().setAppPreferences(
            context.themeMode,
            context.locale,
          );
    }
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthInitFailed) {
          ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.failedToStartAppScreen,
            (route) => false,
            arguments: {
              'error': state.error,
              'onRetry': () =>
                  context.read<AuthBloc>().add(AuthInitRequested()),
            },
          );
        } else if (state is AuthHasLoggedInUser) {
          _processUserPreferences(state, context);
          AppRouter.redirectUser(state.currentUser, ClinicApp.navigatorKey);
        } else if (state is AuthHasNoLoggedInUser) {
          ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.loginScreen, (route) => false);
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

void _processUserPreferences(AuthHasLoggedInUser state, BuildContext context) {
  if (state.currentUser.preferences != null) {
    context.read<AppPreferencesCubit>().setAppPreferences(
        state.currentUser.preferences!.themePreference,
        state.currentUser.preferences!.localePreference);
  } else {
    context
        .read<AppPreferencesCubit>()
        .setUserPreferences(context.themeMode, context.locale);
  }
}
