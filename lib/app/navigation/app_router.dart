import 'package:clinic_v2/app/navigation/src/routes.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:clinic_v2/app/views/home/view/home_page.dart';
import 'package:clinic_v2/app/views/login/login_page.dart';
import 'package:clinic_v2/app/views/sign_up/sign_up_page.dart';
import 'package:clinic_v2/app/views/startup/startup_page.dart';
import 'package:flutter/material.dart';

class AppRouter with Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    Log.i("to route: ${settings.name}");
    switch (settings.name) {
      case Routes.startupScreen:
        return StartupPage().route;
      case Routes.loginScreen:
        return LoginPage().route;
      case Routes.signUpScreen:
        return SignUpPage().route;
      case Routes.homeScreen:
        return HomePage().route;
      default:
        throw UnimplementedError(
            '${settings.name} route page is not implemented');
    }
  }
}
