import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage({required AuthCubit authCubit})
      : super(
          route: MaterialPageRoute(
            settings: const RouteSettings(name: Routes.signUpScreenRoute),
            builder: (_) {
              return BlocProvider.value(
                value: authCubit,
                child: const SignUpScreen(),
              );
            },
          ),
        );
}
