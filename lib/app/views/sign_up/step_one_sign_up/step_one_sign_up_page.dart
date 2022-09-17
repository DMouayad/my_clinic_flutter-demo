import 'package:clinic_v2/app/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'large_step_one_sign_up_screen.dart';
import 'step_one_sign_up_screen.dart';

class StepOneSignUpPage extends AppPage {
  StepOneSignUpPage()
      : super(
          routeSettings:
              const RouteSettings(name: Routes.stepOneSignUpScreenRoute),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.none,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen: _buildScreenWithBloc(const StepOneSignUpScreen()),
              defaultWideScreen: _buildScreenWithBloc(
                LargeStepOneSignUpScreen(animation: animation),
              ),
            );
          },
        );

  static Widget _buildScreenWithBloc(Widget screen) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.of(context).popAndPushNamed(
            Routes.stepTwoSignUpScreenRoute,
          );
        }
      },
      child: screen,
    );
  }
}
