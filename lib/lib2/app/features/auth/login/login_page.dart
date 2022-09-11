import 'package:clinic_v2/infrastructure/navigation/app_page.dart';
import 'package:clinic_v2/infrastructure/navigation/routes.dart';
import 'package:clinic_v2/infrastructure/navigation/transition_type.dart';
import 'package:clinic_v2/lib2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
//

import 'package:flutter_bloc/flutter_bloc.dart';
//

import 'view/screens/large_login_screen.dart';
import 'view/screens/login_screen.dart';

class LoginPage extends AppPage {
  LoginPage({required AuthCubit authCubit})
      : super(
          routeSettings: const RouteSettings(name: Routes.loginScreenRoute),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.desktopDrillIn,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen: BlocProvider.value(
                value: authCubit,
                child: const LoginScreen(),
              ),
              defaultWideScreen: _wideLoginScreen(authCubit, animation),
            );
          },
        );

  static Widget _wideLoginScreen(
    AuthCubit authCubit,
    Animation<double> animation,
  ) {
    return BlocProvider.value(
      value: authCubit,
      child: LargeLoginScreen(animation: animation),
    );
  }
}
