import 'package:clinic_v2/app/navigation/src/routes.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:clinic_v2/app/views/admin_panel/admin_panel_page.dart';
import 'package:clinic_v2/app/views/home/view/home_page.dart';
import 'package:clinic_v2/app/views/login/login_page.dart';
import 'package:clinic_v2/app/views/sign_up/sign_up_page.dart';
import 'package:clinic_v2/app/views/startup/startup_page.dart';
import 'package:clinic_v2/app/views/verification_notice/verification_notice_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    Log.i("to route: ${settings.name}");
    switch (settings.name) {
      case AppRoutes.startupScreen:
        return StartupPage().route;
      case AppRoutes.loginScreen:
        return LoginPage().route;
      case AppRoutes.signUpScreen:
        return SignUpPage().route;
      case AppRoutes.homeScreen:
        return HomePage().route;
      case AppRoutes.adminPanelScreen:
        return AdminPanelPage().route;
      case AppRoutes.verificationNoticeScreen:
        return VerificationNoticePage().route;
      default:
        throw UnimplementedError(
            '${settings.name} route page is not implemented');
    }
  }
}
