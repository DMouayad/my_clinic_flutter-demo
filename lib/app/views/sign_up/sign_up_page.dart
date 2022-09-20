import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mobile_sign_up_screen.dart';
import 'wide_sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.signUpScreenRoute),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.none,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen:
                  _buildScreenWithBlocListener(const MobileSignUpScreen()),
              defaultWideScreen: _buildScreenWithBlocListener(
                WideSignUpScreen(animation: animation),
              ),
            );
          },
        );

  static Widget _buildScreenWithBlocListener(Widget screen) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          if (state.serverUser.role == UserRole.admin) {
            //TODO:: Navigate to admin panel
          }
          if (state.serverUser.role == UserRole.dentist) {
            //TODO:: Navigate to dentist preferences setup
          }
          if (state.serverUser.role == UserRole.secretary) {
            //TODO:: Navigate to secretary preferences setup
          }
        }
      },
      child: screen,
    );
  }
}
