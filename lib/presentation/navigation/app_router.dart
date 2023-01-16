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
  static void redirectUser(
      BaseServerUser user, GlobalKey<NavigatorState> navigatorKey) {
    if (user.isVerified) {
      if (user.role == UserRole.admin) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.adminPanelScreen,
          (route) => false,
        );
      } else {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.homeScreen,
          (route) => false,
        );
      }
    } else {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
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
        final error = passedError is BasicError ? passedError : BasicError();
        return StartupFailurePage(
          error: error,
          onRetry: (settings.arguments as Map).get('onRetry'),
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
