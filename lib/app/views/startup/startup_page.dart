import 'package:clinic_v2/app/blocs/startup_cubit/startup_cubit.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/services/startup/connectivity_startup_service.dart';
//
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';

import 'startup_screen.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.startupScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              defaultScreen: BlocProvider(
                lazy: false,
                create: (_) {
                  return StartupCubit(ConnectivityStartupService())
                    ..initStartup();
                },
                child: const StartupScreen(),
              ),
            );
          },
        );
}
