import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/scaffold_with_appbar.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/app_settings_bar.dart';

import '../../../presentation/views/sign_up/components/bloc_sign_up_form.dart';
import '../../../presentation/views/sign_up/components/sign_up_message.dart';

class WindowsSignUpScreen extends StatelessWidget {
  const WindowsSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          showInProgressIndicator: state is SignUpInProgress,
          leftSideAnimation: animation,
          topOptionsBar: const BlocAppSettingsBar(),
          leftSide: const _StepOneLeftSide(),
          rightSideChild: () {
            if (state is SignUpErrorState) {
              return ErrorCard(
                  errorText: state.error.exception?.getMessage(context) ??
                      "Signing up failed, please try again");
            }
          }(),
        );
      },
    );
  }
}

class _StepOneLeftSide extends StatelessWidget {
  const _StepOneLeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      showBottomTitle: context.isTablet,
      title: const SignUpMessage(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? context.horizontalMargins : 0,
          ),
          child: const BlocSignUpForm(),
        ),
      ),
    );
    // WindowsNavView.withAppBar(
    //   appBarColor: context.colorScheme.backgroundColor,
    //   backgroundColor: context.colorScheme.backgroundColor,
    //   appBarTitle: const SignUpMessage(),
    //   content: Center(
    //     child: SingleChildScrollView(
    //       padding: EdgeInsets.symmetric(
    //         horizontal: context.isDesktop ? context.horizontalMargins : 0,
    //       ),
    //       child: const BlocSignUpForm(),
    //     ),
    //   ),
    // );
  }
}
