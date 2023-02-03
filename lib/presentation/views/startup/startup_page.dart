import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'widgets/app_loading_screen.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageTransitionBuilder: const ContextBuilder(
              windowsChild: RouteTransitionType.desktopEntrance),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return const ContextBuilder(
              mobileScreenChild: MobileAppStartupScreen(),
              wideScreenChild: WideAppStartupScreen(),
            );
          },
        );
}
