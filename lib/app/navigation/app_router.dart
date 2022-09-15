import 'package:clinic_v2/app/navigation/src/routes.dart';
import 'package:clinic_v2/app/views/login/login_page.dart';
import 'package:clinic_v2/app/views/startup/startup_page.dart';
import 'package:clinic_v2/lib2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/lib2/app/features/startup/view/startup_page.dart';
import 'package:flutter/cupertino.dart';

class AppRouter with Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupScreen:
        return StartupPage().route;
      case Routes.loginScreenRoute:
        return LoginPage(authCubit: settings.arguments as AuthCubit).route;
      // case Routes.appearanceSettingsScreenRoute:
      //   return AppearanceSettingsPage().route;
      // case Routes.homeScreenRoute:
      //   return HomePage().route;
      // case Routes.stepOneSignUpScreenRoute:
      //   return StepOneSignUpPage(authCubit: settings.arguments as AuthCubit)
      //       .route;
      // case Routes.stepTwoSignUpScreenRoute:
      //   final arguments = settings.arguments as Map<String, dynamic>;
      //   return StepTwoSignUpPage(
      //     authCubit: arguments['auth_cubit'] as AuthCubit,
      //     signUpCubit: arguments['sign_up_cubit'] as SignUpCubit,
      //   ).route;
      default:
        throw UnimplementedError(
            '${settings.name} route page is not implemented');
    }
  }
}
