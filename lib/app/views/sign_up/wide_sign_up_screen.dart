import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view/windows_nav_view.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/app_settings_bar.dart';

import 'components/bloc_sign_up_form.dart';
import 'components/sign_up_message.dart';

class WideSignUpScreen extends StatelessWidget {
  const WideSignUpScreen({
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
          errorText: () {
            if (state is SignUpErrorState) {
              return state.error.exception?.getMessage(context) ??
                  state.error.message;
            }
          }(),
        );
      },
    );
  }
}

class _StepOneLeftSide extends StatelessWidget {
  const _StepOneLeftSide({Key? key}) : super(key: key);

  Widget windowsBuilder(BuildContext context) {
    return WindowsNavView.withAppBar(
      appBarColor: context.colorScheme.backgroundColor,
      backgroundColor: context.colorScheme.backgroundColor,
      appBarTitle: const SignUpMessage(),
      content: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? context.horizontalMargins : 0,
          ),
          child: const BlocSignUpForm(),
        ),
      ),
    );
  }

  Widget wideScreenBuilder(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : wideScreenBuilder(context);
  }
}
