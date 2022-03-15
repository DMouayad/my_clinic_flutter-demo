import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/app/features/startup/view/startup_screen.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:clinic_v2/core/features/authentication/data/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupPage extends AppPage {
  StartupPage()
      : super(
          route: MaterialPageRoute(
            settings: const RouteSettings(name: Routes.startupScreen),
            builder: (_) {
              return RepositoryProvider(
                lazy: false,
                create: (context) => ParseAuthRepository(),
                child: Builder(builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        lazy: false,
                        create: (_) {
                          return StartupCubit()..initServerConnection();
                        },
                      ),
                      BlocProvider(
                        lazy: false,
                        create: (_) {
                          return AuthCubit(
                            context.read<ParseAuthRepository>(),
                          );
                        },
                      ),
                    ],
                    child: const StartupScreen(),
                  );
                }),
              );
            },
          ),
        );
}
