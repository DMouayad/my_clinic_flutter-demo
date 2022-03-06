import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/home_screen/view/home_page.dart';
import 'package:clinic_v2/app/features/login/view/login_page.dart';
import 'package:clinic_v2/app/features/startup/view/startup_page.dart';
import 'package:flutter/cupertino.dart';

import 'navigation.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupScreen:
        return StartupPage().route;
      case Routes.homeScreenRoute:
        return HomePage().route;
      case Routes.loginScreenRoute:
        return LoginPage(authCubit: settings.arguments as AuthCubit).route;
      default:
        return StartupPage().route;
    }
  }
}
