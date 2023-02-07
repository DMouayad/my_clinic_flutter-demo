import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/utils/helpers/builders/context_builder.dart';

import 'startup_failure_screen.dart';
import 'startup_failure_wide_screen.dart';

class StartupFailurePage extends AppPage {
  StartupFailurePage({
    required AppError error,
  }) : super(
          routeSettings:
              const RouteSettings(name: AppRoutes.failedToStartAppScreen),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              wideScreenChild: AppStartupFailureWideScreen(error),
              defaultChild: AppStartupFailureScreen(error),
            );
          },
        );
}
