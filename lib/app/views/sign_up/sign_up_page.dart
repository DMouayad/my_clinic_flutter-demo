import 'package:clinic_v2/app/shared_widgets/custom_buttons/text_buttons.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets/custom_dialogs/adaptive_dialog.dart';

import 'mobile_sign_up_screen.dart';
import 'wide_sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.signUpScreen),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.none,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen: _buildScreenWithBlocListener(
                  const MobileSignUpScreen(), context),
              defaultWideScreen: _buildScreenWithBlocListener(
                  WideSignUpScreen(animation: animation), context),
            );
          },
        );

  static Widget _buildScreenWithBlocListener(
      Widget screen, BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          if (state.serverUser.role == UserRole.admin) {
            Navigator.of(context).popAndPushNamed(Routes.adminPanelScreen);
          }
          if (state.serverUser.role == UserRole.dentist) {
            //TODO:: Navigate to dentist preferences setup
          }
          if (state.serverUser.role == UserRole.secretary) {
            //TODO:: Navigate to secretary preferences setup
          }
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return (await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return const _ExistingSignUpScreenAlertDialog();
                },
              )) ??
              false;
        },
        child: screen,
      ),
    );
  }
}

class _ExistingSignUpScreenAlertDialog extends StatelessWidget {
  const _ExistingSignUpScreenAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = [
      AdaptiveFilledButton(
        width: 100,
        backgroundColor: context.colorScheme.errorColor,
        labelColor: context.colorScheme.onError,
        label: context.localizations!.exit,
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      AdaptiveTextButton(
        label: context.localizations!.cancel,
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
    ];
    return AdaptiveDialog(
      titleText: context.localizations!.exitSignUpDialogTitle,
      contentText: context.localizations!.exitSignUpDialogMessage,
      actions: context.isWindowsPlatform ? actions : actions.reversed.toList(),
    );
  }
}
