import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';

import 'startup_failure_screen.dart';

class StartupFailurePage extends AppPage {
  StartupFailurePage({
    required BasicError error,
    required void Function()? onRetry,
  }) : super(
          routeSettings:
              const RouteSettings(name: AppRoutes.failedToStartAppScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              defaultScreen: AppStartupFailureScreen(error, onRetry),
            );
          },
        );
}
