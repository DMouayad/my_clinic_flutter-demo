import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:clinic_v2/app/shared_widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets//windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/shared_widgets//windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/account_info_form.dart';
import 'components/sign_up_message.dart';
import 'components/sign_up_step_indicator.dart';

class WideSignUpScreen extends CustomStatelessWidget {
  const WideSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          showInProgressIndicator: state is SignUpInProgress,
          leftSideAnimation: animation,
          leftSide: const _StepOneLeftSide(),
          errorText: () {
            if (state is SignUpError) {
              if (state.error.exception == ErrorException.noConnectionFound()) {
                return AppLocalizations.of(context)!.noInternetConnection;
              }
              return state.error.message;
            }
          }(),
        );
      },
    );
  }
}

class _StepOneLeftSide extends CustomStatelessWidget {
  const _StepOneLeftSide({Key? key}) : super(key: key);

  @override
  Widget desktopScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return WindowsNavView.onlyAppBar(
      appBarColor: context.colorScheme.backgroundColor,
      backgroundColor: context.colorScheme.backgroundColor,
      appBarActions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignUpStepIndicator(
            title: AppLocalizations.of(context)!.stepOne,
          ),
        ],
      ),
      appBarTitle: const SignUpMessage(),
      content: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: contextInfo.isDesktop ? context.horizontalMargins : 0,
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
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      showBottomTitle: contextInfo.isTablet,
      title: const SignUpMessage(),
      actions: [
        SignUpStepIndicator(
          title: AppLocalizations.of(context)!.stepOne,
        ),
      ],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: contextInfo.isDesktop ? context.horizontalMargins : 0,
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
}
