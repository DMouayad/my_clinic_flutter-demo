import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/screens/large_step_two_sign_up_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/step_two_sign_up_screen.dart';

class StepTwoSignUpPage extends AppPage {
  StepTwoSignUpPage({
    required AuthCubit authCubit,
    required SignUpCubit signUpCubit,
  }) : super(
          routeSettings:
              const RouteSettings(name: Routes.stepTwoSignUpScreenRoute),
          mobileScreenInfo: PageScreenInfo(
            screen: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: authCubit),
                BlocProvider<SignUpCubit>.value(value: signUpCubit),
              ],
              child: const StepTwoSignUpScreen(),
            ),
          ),
          tabletScreenInfo: _largeSignUpPageInfo(authCubit, signUpCubit),
          desktopScreenInfo: _largeSignUpPageInfo(authCubit, signUpCubit),
        );

  static PageScreenInfo _largeSignUpPageInfo(
      AuthCubit authCubit, SignUpCubit signUpCubit) {
    return PageScreenInfo(
      hasTransition: false,
      screenBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
            BlocProvider<SignUpCubit>.value(value: signUpCubit),
          ],
          child: const LargeStepTwoSignUpScreen(),
        );
      },
    );
  }
}
