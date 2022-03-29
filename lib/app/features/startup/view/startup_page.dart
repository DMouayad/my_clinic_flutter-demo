import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/app/features/startup/view/startup_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.startupScreen),
          mobileScreenInfo: _startUpPage(),
          desktopScreenInfo: _startUpPage(),
        );
  static PageScreenInfo _startUpPage() {
    return PageScreenInfo(
      screen: BlocProvider(
        lazy: false,
        create: (_) {
          return StartupCubit()..initServerConnection();
        },
        child: const StartupScreen(),
      ),
    );
  }
}
