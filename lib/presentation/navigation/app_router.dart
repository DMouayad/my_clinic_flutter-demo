import 'package:clinic_v2/main.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:clinic_v2/presentation/navigation/src/routes.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';
import 'package:clinic_v2/presentation/views/admin_panel/admin_panel_page.dart';
import 'package:clinic_v2/presentation/views/home/view/home_page.dart';
import 'package:clinic_v2/presentation/views/login/login_page.dart';
import 'package:clinic_v2/presentation/views/sign_up/sign_up_page.dart';
import 'package:clinic_v2/presentation/views/startup/startup_page.dart';
import 'package:clinic_v2/presentation/views/startup_failure/startup_failure_page.dart';
import 'package:clinic_v2/presentation/views/verification_notice/verification_notice_page.dart';
import 'package:clinic_v2/utils/extensions/map_extensions.dart';
import 'package:flutter/material.dart';

class AppRouter {
  /// Redirects the current user after logging in.
  ///
  /// Destination screen determined by: the user's role and whether if his email was verified or not.
  static void redirectUser(BaseServerUser user) {
    if (user.isVerified) {
      if (user.role == UserRole.admin) {
        ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.adminPanelScreen,
          (route) => false,
        );
      } else {
        ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.homeScreen,
          (route) => false,
        );
      }
    } else {
      ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.verificationNoticeScreen,
        (route) => false,
      );
    }
  }

  static Route onGenerateRoute(RouteSettings settings) {
    Log.i("to route: ${settings.name}");
    switch (settings.name) {
      case AppRoutes.startupScreen:
        return StartupPage().route;

      case AppRoutes.failedToStartAppScreen:
        final passedError = (settings.arguments as Map).get('error');
        final error = passedError is AppError ? passedError : AppError();
        return StartupFailurePage(
          error: error,
        ).route;
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
