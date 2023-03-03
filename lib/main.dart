import 'dart:io';
import 'package:clinic_v2/domain/authentication/base/base_auth_tokens_service.dart';
import 'package:clinic_v2/domain/authentication/data/api_auth_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
import 'package:get_it/get_it.dart';

import 'package:clinic_v2/app/services/socketio/socketio_notifications_listener.dart';
import 'package:clinic_v2/domain/notifications/base/base_notifications_listener.dart';
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/navigation/app_router.dart';
import 'package:clinic_v2/presentation/themes/material_themes.dart';
import 'api/services/api_endpoint_request_maker.dart';
import 'api/services/dio_http_client.dart';
import 'app/blocs/auth_bloc/auth_user_listener.dart';
import 'app/services/socketio/socketio_provider.dart';
import 'domain/authentication/data/my_clinic_api_refresh_tokens_service.dart';
import 'domain/authentication/data/secure_storage_auth_tokens_service.dart';
import 'domain/notifications/data/socket_io/socket_io_auth_notifications_handler.dart';
import 'utils/extensions/context_extensions.dart';
import 'app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'domain/authentication/base/base_auth_repository.dart';
import 'domain/user_preferences/base/base_user_preferences_repository.dart';
import 'domain/user_preferences/data/my_clinic_api_user_preferences_repository.dart';
import 'presentation/navigation/src/routes.dart';
import 'presentation/themes/fluent_themes.dart';
import 'shared/services/logger_service.dart';
import 'domain/authentication/data/api_auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    await windowManager.setMinimumSize(const Size(400, 700));
  }

  // states that Logger is working
  Log.v("Logger started | ${DateTime.now()}");
  Log.v("App is running on ${Platform.operatingSystemVersion}");

  _injectDependencies();

  // GetIt.I.get<BaseAuthTokensService>().deleteAccessToken();
  // GetIt.I.get<BaseAuthTokensService>().deleteRefreshToken();
  runApp(const ClinicApp());
}

void _injectDependencies() {
  GetIt.I.registerSingleton(SocketIoProvider());
  GetIt.I.registerSingleton<BaseNotificationsListener>(
      SocketIoNotificationsListener());
  GetIt.I.registerSingleton<BaseAuthTokensService>(
    SecureStorageAuthTokensService(ApiRefreshTokensService()),
  );
  GetIt.I.registerSingleton(ApiEndpointRequestMaker(DioHttpClient()));
  GetIt.I.registerSingleton<BaseUserPreferencesRepository>(
      ApiUserPreferencesRepository());
  GetIt.I.registerSingleton<BaseAuthRepository>(ApiAuthRepository(
    const ApiAuthDataSource(),
    notificationsHandlers: [SocketIoAuthNotificationHandler()],
  ));
}

/// Main App widget
class ClinicApp extends StatelessWidget {
  const ClinicApp({
    Key? key,
    this.home,
  }) : super(key: key);

  /// ### used only for testing purposes
  final Widget? home;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppPreferencesCubit(GetIt.I.get()),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(GetIt.I.get())..add(const AuthInitRequested()),
        ),
      ],
      child: AuthUserListener(
        context.isWindowsPlatform
            ? _WindowsApp(home: home)
            : _AndroidApp(home: home),
      ),
    );
  }
}

class _WindowsApp extends StatelessWidget {
  const _WindowsApp({this.home, Key? key}) : super(key: key);

  /// ### used only for testing purposes
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
      buildWhen: (prev, next) {
        return next is AppPreferencesStateWithData;
      },
      builder: (context, state) {
        return fluent_ui.FluentApp(
          title: 'MyClinic',
          debugShowCheckedModeBanner: false,
          navigatorKey: ClinicApp.navigatorKey,
          theme: FluentAppThemes.lightTheme,
          darkTheme: FluentAppThemes.defaultDarkTheme,
          themeMode: (state is AppPreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          initialRoute: AppRoutes.startupScreen,
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

class _AndroidApp extends StatelessWidget {
  const _AndroidApp({this.home, Key? key}) : super(key: key);

  /// ### used only for testing purposes
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
      buildWhen: (prev, next) {
        return next is AppPreferencesStateWithData;
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'MyClinic',
          navigatorKey: ClinicApp.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: MaterialAppThemes.lightTheme,
          darkTheme: MaterialAppThemes.defaultDarkTheme,
          themeMode: (state is AppPreferencesStateWithData)
              ? state.themeMode
              : ThemeMode.system,
          home: home,
          initialRoute: AppRoutes.startupScreen,
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

Locale localeResolutionCallBack(
  List<Locale>? deviceLocales,
  Iterable<Locale> supportedLocales,
) {
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
