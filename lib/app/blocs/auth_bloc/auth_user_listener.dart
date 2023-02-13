import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/main.dart';
import 'package:clinic_v2/app/blocs/app_preferences_cubit/app_preferences_cubit.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'auth_bloc.dart';

/// Listens to [AuthBloc]'s state changes,
/// Specifies all the actions triggered by an AuthState
class AuthUserListener extends StatelessWidget {
  const AuthUserListener(
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
        if (state is AuthInitRetryInProgress) {
          _onAuthInitRetry(context);
        }
        if (state is AuthHasLoggedInUser) {
          _onAuthHasUser(state, context);
        }
        if (state is AuthHasNoLoggedInUser) {
          _onAuthHasNoUser(context);
        }
      },
      child: child,
    );
  }

  void _onAuthInitRetry(BuildContext context) {
    ClinicApp.navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(AppRoutes.startupScreen, (route) => false);
  }

  void _onAuthHasNoUser(BuildContext context) {
    context.read<AppPreferencesCubit>().resetUserPreferences();
    ClinicApp.navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
  }

  void _onAuthHasUser(AuthHasLoggedInUser state, BuildContext context) {
    context.read<AppPreferencesCubit>().processUserPreferences(
          state.currentUser.preferences,
          appLocale: context.locale,
          appThemeMode: context.themeMode,
        );
    AppRouter.redirectUser(state.currentUser);
  }

  void _onAuthInitFailed(AuthInitFailed state, BuildContext context) {
    ClinicApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.failedToStartAppScreen,
      (route) => false,
      arguments: {'error': state.error},
    );
  }
}
