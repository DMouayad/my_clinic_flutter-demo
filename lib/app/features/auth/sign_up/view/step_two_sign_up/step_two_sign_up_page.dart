import 'package:clinic_v2/app/base/entities/app_page/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/screens/large_step_two_sign_up_screen.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/screens/step_two_sign_up_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepTwoSignUpPage extends AppPage {
  StepTwoSignUpPage({
    required AuthCubit authCubit,
    required SignUpCubit signUpCubit,
  }) : super(
          routeSettings:
              const RouteSettings(name: Routes.stepTwoSignUpScreenRoute),
          mobileScreenInfo: _pageScreenInfo(
              const StepTwoSignUpScreen(), authCubit, signUpCubit),
          tabletScreenInfo: _pageScreenInfo(
            const LargeStepTwoSignUpScreen(),
            authCubit,
            signUpCubit,
            routeTransitionType: RouteTransitionType.slideFromTop,
          ),
          desktopScreenInfo: _pageScreenInfo(
            const LargeStepTwoSignUpScreen(),
            authCubit,
            signUpCubit,
            routeTransitionType: RouteTransitionType.slideFromTop,
          ),
        );

  static PageScreenInfo _pageScreenInfo(
    Widget screen,
    AuthCubit authCubit,
    SignUpCubit signUpCubit, {
    RouteTransitionType routeTransitionType =
        RouteTransitionType.platformDefault,
  }) {
    return PageScreenInfo(
      transitionType: routeTransitionType,
      screen: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authCubit),
          BlocProvider<SignUpCubit>.value(value: signUpCubit),
        ],
        child: screen,
      ),
    );
  }
}
