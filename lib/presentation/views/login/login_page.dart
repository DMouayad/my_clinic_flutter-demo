import 'package:clinic_v2/app/blocs/auth_bloc/auth_error_state_handler.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'screens/wide_login_screen.dart';
import 'screens/mobile_login_screen.dart';

class LoginPage extends AppPage {
  LoginPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.loginScreen),
          pageTransitionBuilder: const ContextBuilder(
            tabletScreenChild: RouteTransitionType.platformDefault,
            windowsChild: RouteTransitionType.none,
          ),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              mobileScreenChild:
                  const AuthErrorStateHandler(child: MobileLoginScreen()),
              tabletScreenChild: AuthErrorStateHandler(
                  child: WideLoginScreen(animation: animation)),
              desktopScreenChild: WideLoginScreen(animation: animation),
            );
          },
        );
}
