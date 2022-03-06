import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/login/cubit/login_screen_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class LoginPage extends AppPage {
  LoginPage({required AuthCubit authCubit})
      : super(
          route: MaterialPageRoute(
            settings: const RouteSettings(name: Routes.loginScreenRoute),
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => LoginScreenCubit()),
                  BlocProvider.value(value: authCubit),
                ],
                child: const LoginScreen(),
              );
            },
          ),
        );
}
