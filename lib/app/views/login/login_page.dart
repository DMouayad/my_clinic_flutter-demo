import 'package:clinic_v2/app/navigation/navigation.dart';

import 'screens/windows_login_screen.dart';
import 'screens/login_screen.dart';

class LoginPage extends AppPage {
  LoginPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.loginScreenRoute),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.desktopDrillIn,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              mobileScreen: const LoginScreen(),
              windowsScreen: WindowsLoginScreen(animation: animation),
            );
          },
        );
}
