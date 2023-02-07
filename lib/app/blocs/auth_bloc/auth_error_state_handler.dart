import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_error_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_progress_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_bloc.dart';

class AuthErrorStateHandler extends StatefulWidget {
  const AuthErrorStateHandler({super.key, required this.child});

  final Widget child;

  @override
  State<AuthErrorStateHandler> createState() => _AuthErrorStateHandlerState();
}

class _AuthErrorStateHandlerState extends State<AuthErrorStateHandler> {
  bool dialogIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (context.isMobile || context.isPortraitTablet) {
          _hideDialog(context);

          if (state is AuthErrorState) {
            dialogIsVisible = true;
            showAdaptiveErrorDialog(
              context: context,
              titleText: getErrorDialogTitle(state, context),
              contentText: state.error.appException?.getMessage(context),
            ).then((value) => dialogIsVisible = false);
          }
          if (state is AuthInitRetryInProgress) {
            dialogIsVisible = true;

            showAdaptiveProgressDialog(
              context: context,
              contentText: "Retrying...",
            ).then((value) => dialogIsVisible = false);
          }

          if (state is LoginInProgress) {
            dialogIsVisible = true;
            showAdaptiveProgressDialog(
              context: context,
              contentText: context.localizations!.loginInProgress,
            ).then((value) => dialogIsVisible = false);
          } else if (state is SignUpInProgress) {
            dialogIsVisible = true;
            showAdaptiveProgressDialog(
              context: context,
              contentText: context.localizations!.signUpInProgress,
            ).then((value) => dialogIsVisible = false);
          }
        }
      },
      child: widget.child,
    );
  }

  String getErrorDialogTitle(AuthErrorState state, BuildContext context) {
    if (state is LoginErrorState) {
      return context.localizations!.loginFailed;
    } else if (state is SignUpErrorState) {
      return context.localizations!.signupFailed;
    }
    if (state is AuthInitFailed) {
      return "Authentication Error";
    }
    return "Error!";
  }

  void _hideDialog(BuildContext context) {
    if (dialogIsVisible) {
      Navigator.of(context).pop();
      dialogIsVisible = false;
    }
  }
}
