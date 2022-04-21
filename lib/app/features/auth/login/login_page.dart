import 'package:flutter/material.dart';
//

import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/base/entities/app_page/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/login/view/screens/login_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'view/screens/large_login_screen.dart';

class LoginPage extends AppPage {
  LoginPage({required AuthCubit authCubit})
      : super(
          routeSettings: const RouteSettings(name: Routes.loginScreenRoute),
          pageScreensInfo: PageScreensInfo(
            tabletScreenTransitionType: RouteTransitionType.none,
            desktopScreenTransitionType: RouteTransitionType.desktopDrillIn,
            screensBuilder: (context, animation, secondaryAnimation) {
              return PageScreensBuilder(
                mobileScreen: BlocProvider.value(
                  value: authCubit,
                  child: const LoginScreen(),
                ),
                wideScreen: _wideLoginScreen(authCubit, animation),
              );
            },
          ),
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
