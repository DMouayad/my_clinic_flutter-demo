import 'package:clinic_v2/app/base/entities/app_page/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/login/view/screens/login_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/screens/large_login_screen.dart';

class LoginPage extends AppPage {
  LoginPage({required AuthCubit authCubit})
      : super(
          routeSettings: const RouteSettings(name: Routes.loginScreenRoute),
          mobileScreenInfo: PageScreenInfo(
            screen: BlocProvider.value(
              value: authCubit,
              child: const LoginScreen(),
            ),
          ),
          tabletScreenInfo: _largeLoginPageInfo(authCubit),
          desktopScreenInfo: _largeLoginPageInfo(authCubit),
        );

  static PageScreenInfo _largeLoginPageInfo(AuthCubit authCubit) {
    return PageScreenInfo(
      transitionType: RouteTransitionType.none,
      screenBuilder: (context, animation, secondaryAnimation) {
        return BlocProvider.value(
          value: authCubit,
          child: LargeLoginScreen(animation: animation),
        );
      },
    );
  }
}
