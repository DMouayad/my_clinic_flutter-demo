import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/shared_widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

import 'components/account_info_form.dart';
import 'components/sign_up_message.dart';
import 'components/sign_up_step_indicator.dart';

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
          leftSide: const _StepOneLeftSide(),
          errorText: () {
            if (state is SignUpError) {
              if (state.error.exception == ErrorException.noConnectionFound()) {
                return context.localizations!.noInternetConnection;
              }
              return state.error.message;
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
    return WindowsNavView.onlyAppBar(
      appBarColor: context.colorScheme.backgroundColor,
      backgroundColor: context.colorScheme.backgroundColor,
      appBarActions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignUpStepIndicator(
            title: context.localizations!.stepOne,
          ),
        ],
      ),
      appBarTitle: const SignUpMessage(),
      content: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? context.horizontalMargins : 0,
          ),
          child: SignUpAccountInfoForm(
            onSubmit: (
              String emailAddress,
              String password,
              String username,
            ) {
              context.read<AuthBloc>().add(SignUpRequested(
                    email: emailAddress,
                    username: username,
                    password: password,
                    themeMode: context.themeMode,
                    locale: context.locale,
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget defaultBuilder(BuildContext context) {
    return ScaffoldWithAppBar(
      showBottomTitle: context.isTablet,
      title: const SignUpMessage(),
      actions: [
        SignUpStepIndicator(
          title: context.localizations!.stepOne,
        ),
      ],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? context.horizontalMargins : 0,
          ),
          child: SignUpAccountInfoForm(
            onSubmit: (
              String emailAddress,
              String password,
              String username,
            ) {
              context.read<AuthBloc>().add(SignUpRequested(
                    email: emailAddress,
                    username: username,
                    password: password,
                    themeMode: context.themeMode,
                    locale: context.locale,
                  ));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? windowsBuilder(context)
        : defaultBuilder(context);
  }
}
