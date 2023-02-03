import 'package:clinic_v2/app/blocs/auth_bloc/auth_error_state_handler.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/views/login/screens/wide_login_screen.dart';

import '../../../presentation/views/login/screens/mobile_login_screen.dart';

class LoginPage extends AppPage {
  LoginPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.loginScreen),
          pageTransitionBuilder: const ContextBuilder(
            tabletScreenChild: RouteTransitionType.platformDefault,
            windowsChild: RouteTransitionType.none,
          ),
          transitionDuration: const Duration(milliseconds: 1000),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              mobileScreenChild:
                  const AuthErrorStateHandler(child: MobileLoginScreen()),
              wideScreenChild: AuthErrorStateHandler(
                  child: WideLoginScreen(animation: animation)),
            );
          },
        );
}
