import 'package:clinic_v2/app/blocs/auth_bloc/auth_error_state_handler.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

//
import 'package:clinic_v2/presentation/navigation/navigation.dart';

import '../../../presentation/views/sign_up/mobile_sign_up_screen.dart';
import '../../../presentation/views/sign_up/wide_sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.signUpScreen),
          pageTransitionBuilder: const ContextBuilder(
            tabletScreenChild: RouteTransitionType.none,
            windowsChild: RouteTransitionType.none,
          ),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              mobileScreenChild:
                  _buildScreen(const MobileSignUpScreen(), context),
              wideScreenChild:
                  _buildScreen(WideSignUpScreen(animation: animation), context),
            );
          },
        );

  static Widget _buildScreen(Widget screen, BuildContext context) {
    return AuthErrorStateHandler(
      child: WillPopScope(
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
      ),
    );
  }
}
