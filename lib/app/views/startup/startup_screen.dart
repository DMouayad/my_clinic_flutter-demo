import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/blocs/startup_bloc/startup_bloc.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/views/startup/startup_view.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthHasLoggedInUser) {
          Navigator.of(context).popAndPushNamed(Routes.homeScreenRoute);
        }
        if (state is AuthHasNoLoggedInUser) {
          Navigator.of(context).popAndPushNamed(Routes.loginScreenRoute);
        }
      },
      child: BlocConsumer<StartupBloc, StartupState>(
        listener: (context, state) {
          if (state is StartupSuccess) {
            context.read<AuthBloc>().add(const AuthInitRequested());
          }
        },
        builder: (context, state) {
          if (state is StartupFailure) {
            return ErrorStartingAppScreen(state.error);
          }
          // return loading screen while startup process is in progress
          return const LoadingAppScreen();
        },
      ),
    );
  }
}
