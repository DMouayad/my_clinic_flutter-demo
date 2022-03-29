import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/login/login_page.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_one_sign_up/step_one_sign_up_page.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/step_two_sign_up_page.dart';
import 'package:clinic_v2/app/features/home_screen/view/home_page.dart';
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
      case Routes.stepOneSignUpScreenRoute:
        return StepOneSignUpPage(authCubit: settings.arguments as AuthCubit)
            .route;
      case Routes.stepTwoSignUpScreenRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        return StepTwoSignUpPage(
          authCubit: arguments['auth_cubit'] as AuthCubit,
          signUpCubit: arguments['sign_up_cubit'] as SignUpCubit,
        ).route;
      default:
        return StartupPage().route;
    }
  }
}
