import 'package:clinic_v2/app/base/entities/app_page/app_page.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/appearance_settings_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';

class AppearanceSettingsPage extends AppPage {
  AppearanceSettingsPage()
      : super(
          routeSettings:
              const RouteSettings(name: Routes.appearanceSettingsScreenRoute),
          pageScreensInfo: PageScreensInfo(
            screensBuilder: (context, animation, secondaryAnimation) {
              return const PageScreensBuilder(
                defaultScreen: AppearanceSettingsScreen(),
              );
            },
          ),
        );
}
