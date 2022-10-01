import 'package:clinic_v2/app/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';

import 'mobile_sign_up_screen.dart';
import 'wide_sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.signUpScreen),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.none,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen: _buildScreen(const MobileSignUpScreen(), context),
              defaultWideScreen:
                  _buildScreen(WideSignUpScreen(animation: animation), context),
            );
          },
        );

  static Widget _buildScreen(Widget screen, BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showAdaptiveAlertDialog<bool>(
              context: context,
              titleText: context.localizations!.exitSignUpDialogTitle,
              contentText: context.localizations!.exitSignUpDialogMessage,
              confirmText: context.localizations!.exit,
            ) ??
            false;
      },
      child: screen,
    );
  }
}
