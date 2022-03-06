import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/home_screen/view/home_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends AppPage {
  HomePage()
      : super(
          route: MaterialPageRoute(
            settings: const RouteSettings(name: Routes.homeScreenRoute),
            builder: (_) => const HomeScreen(),
          ),
        );
}
