import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/home_screen/view/home_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends AppPage {
  HomePage()
      : super(
          routeSettings: const RouteSettings(name: Routes.homeScreenRoute),
          mobileScreenInfo: const PageScreenInfo(screen: HomeScreen()),
          desktopScreenInfo: const PageScreenInfo(screen: HomeScreen()),
        );
}
