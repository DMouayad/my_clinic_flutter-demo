import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';

import '../../../presentation/views/sign_up/mobile_sign_up_screen.dart';
import '../../../presentation/views/sign_up/windows_sign_up_screen.dart';

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
              windowsSmallScreen:
                  _buildScreen(const MobileSignUpScreen(), context),
              windowsScreen: _buildScreen(
                  WindowsSignUpScreen(animation: animation), context),
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
