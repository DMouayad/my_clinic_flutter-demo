import 'package:clinic_v2/app/base/responsive/responsive.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/common/widgets/screens/app_loading_screen.dart';
import 'package:clinic_v2/app/features/auth/view/auth_gate.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return BlocBuilder<StartupCubit, StartupState>(
      builder: (context, state) {
        if (state is StartupSuccess) {
          return const AuthGate();
        }
        if (state is StartupFailure) {
          return _ErrorStartingAppScreen(state.error);
        }

        return const LoadingAppScreen();
      },
    );
  }
}

class _ErrorStartingAppScreen extends ResponsiveScreen {
  final CustomError error;
  const _ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  @override
  Widget mobile(context) {
    return Scaffold(
      body: Column(),
    );
  }
}
