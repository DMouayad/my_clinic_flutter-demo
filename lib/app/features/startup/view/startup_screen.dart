import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/common/widgets/screens/app_loading_screen.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthHasLoggedInUser) {
          Navigator.of(context).popAndPushNamed(Routes.homeScreenRoute);
        } else if (state is AuthHasNoLoggedInUser) {
          Navigator.of(context).popAndPushNamed(
            Routes.loginScreenRoute,
            arguments: context.read<AuthCubit>(),
          );
        }
      },
      child: BlocConsumer<StartupCubit, StartupState>(
        listener: (context, state) {
          if (state is StartupSuccess) {
            context.read<AuthCubit>().loadCurrentUser();
          }
        },
        builder: (context, state) {
          print(state);
          if (state is StartupFailure) {
            return ErrorStartingAppScreen(state.error);
          }

          return const LoadingAppScreen();
        },
      ),
    );
  }
}

class ErrorStartingAppScreen extends ResponsiveScreen {
  final CustomError error;
  const ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  @override
  Widget mobile(context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(),
    );
  }
}
