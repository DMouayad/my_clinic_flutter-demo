import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/main.dart';
import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'auth_bloc.dart';

/// Listens to [AuthBloc]'s state changes,
/// Specifies all the actions triggered by an AuthState
class AuthStatesHandler extends StatelessWidget {
  const AuthStatesHandler(
    this.child, {
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthInitFailed) {
          _onAuthInitFailed(state, context);
        }
        if (state is AuthHasLoggedInUser) {
          _onAuthHasUser(state, context);
        }
        if (state is AuthHasNoLoggedInUser) {
          context.read<AppPreferencesCubit>().resetUserPreferences();
          ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.loginScreen, (route) => false);
        }
      },
      child: child,
    );
  }

  void _onAuthHasUser(AuthHasLoggedInUser state, BuildContext context) {
    context
        .read<AppPreferencesCubit>()
        .processUserPreferences(state.currentUser.preferences, context);
    AppRouter.redirectUser(state.currentUser, ClinicApp.navigatorKey);
  }

  void _onAuthInitFailed(AuthInitFailed state, BuildContext context) {
    ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.failedToStartAppScreen,
      (route) => false,
      arguments: {'error': state.error},
    );
  }
}