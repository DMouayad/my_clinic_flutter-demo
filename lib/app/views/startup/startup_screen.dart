//
import 'package:clinic_v2/app/blocs/startup_cubit/startup_cubit.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/views/startup/startup_view.dart';
import 'package:clinic_v2/lib2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is StoredUserWasFetched) {
          context.read<AuthCubit>().getAuthState();
        }
        if (state is AuthHasLoggedInUser) {
          Navigator.of(context).popAndPushNamed(Routes.homeScreenRoute);
        }
        if (state is AuthHasNoLoggedInUser) {
          Navigator.of(context).popAndPushNamed(
            Routes.loginScreenRoute,
            arguments: context.read<AuthCubit>(),
          );
        }
      },
      child: BlocConsumer<StartupCubit, StartupState>(
        listener: (context, state) {
          if (state is StartupSuccess) {
            context.read<AuthCubit>().loadCurrentUserFromStorage();
          }
        },
        builder: (context, state) {
          if (state is StartupFailure) {
            return ErrorStartingAppScreen(state.error);
          }

          return const LoadingAppScreen();
        },
      ),
    );
  }
}
