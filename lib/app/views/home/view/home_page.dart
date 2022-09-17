import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomePage extends AppPage {
  HomePage()
      : super(
          routeSettings: const RouteSettings(name: Routes.homeScreenRoute),
          pageScreensBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              const PageScreensBuilder(
            defaultScreen: HomeScreen(),
          ),
        );
}
