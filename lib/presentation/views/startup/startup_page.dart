import 'package:clinic_v2/presentation/navigation/navigation.dart';

import 'widgets/app_loading_screen.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return const PageScreensBuilder(defaultScreen: LoadingAppScreen());
          },
        );
}
