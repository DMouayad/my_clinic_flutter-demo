import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/large_step_one_sign_up_screen.dart';
import 'screens/step_one_sign_up_screen.dart';

class StepOneSignUpPage extends AppPage {
  StepOneSignUpPage({required AuthCubit authCubit})
      : super(
          routeSettings:
              const RouteSettings(name: Routes.stepOneSignUpScreenRoute),
          mobileScreenInfo: PageScreenInfo(
            screen: _stepOneSignUpBlocProvider(
                authCubit, const StepOneSignUpScreen()),
          ),
          tabletScreenInfo: _largeSignUpPageInfo(authCubit),
          desktopScreenInfo: _largeSignUpPageInfo(authCubit),
        );

  static PageScreenInfo _largeSignUpPageInfo(AuthCubit authCubit) {
    return PageScreenInfo(
      hasTransition: false,
      screenBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return _stepOneSignUpBlocProvider(
          authCubit,
          LargeStepOneSignUpScreen(animation: animation),
        );
      },
    );
  }

  static _stepOneSignUpBlocProvider(AuthCubit authCubit, Widget screen) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider<SignUpCubit>(create: (context) => SignUpCubit()),
      ],
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpStepTwo) {
            Navigator.of(context).popAndPushNamed(
              Routes.stepTwoSignUpScreenRoute,
              arguments: {
                'sign_up_cubit': context.read<SignUpCubit>(),
                'auth_cubit': context.read<AuthCubit>(),
              },
            );
          }
        },
        child: screen,
      ),
    );
  }
}
