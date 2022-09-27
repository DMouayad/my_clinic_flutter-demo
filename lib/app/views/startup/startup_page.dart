import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/startup_bloc/startup_bloc.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/services/startup/connectivity_startup_service.dart';
//
import 'startup_screen.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.startupScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              defaultScreen: BlocProvider(
                lazy: false,
                create: (_) {
                  return StartupBloc(ConnectivityStartupService())
                    ..add(StartupInitRequested());
                },
                child: const StartupScreen(),
              ),
            );
          },
        );
}
