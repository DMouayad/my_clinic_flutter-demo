import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'home_screen.dart';

class HomePage extends AppPage {
  HomePage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.homeScreen),
          pageScreenBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              const ContextBuilder(defaultChild: HomeScreen()),
        );
}
