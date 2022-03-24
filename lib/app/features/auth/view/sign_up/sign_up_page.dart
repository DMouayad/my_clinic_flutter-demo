import 'package:clinic_v2/app/base/entities/app_page.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/view/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_screen.dart';

class SignUpPage extends AppPage {
  SignUpPage({required AuthCubit authCubit})
      : super(
          route: PageRouteBuilder(
            settings: const RouteSettings(name: Routes.signUpScreenRoute),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return
                  //  SlideTransition(
                  //   position: animation
                  //       .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                  //   child:
                  MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: authCubit,
                  ),
                  BlocProvider<SignUpCubit>(
                    create: (context) => SignUpCubit(),
                  ),
                ],
                child: SignUpScreen(animation: animation),
              );
              // );
            },
          ),
        );
}
