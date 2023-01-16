import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_alert_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/show_progress_dialog.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutInProgress) {
          showAdaptiveProgressDialog(
            context: context,
            contentText: context.localizations!.loggingOut,
          );
        }
      },
      child: CustomIconButton(
        tooltipMessage: context.localizations!.logout,
        icon: Icon(
          Icons.logout,
          color: Colors.red.shade400,
          size: 22,
        ),
        onPressed: () async {
          final logoutConfirmed = await showAdaptiveAlertDialog<bool>(
            context: context,
            titleText: context.localizations!.logoutConfirmation,
            contentText: context.localizations!.confirmLogoutMessage,
            confirmText: context.localizations!.logout,
          );
          if (logoutConfirmed ?? false) {
            context.read<AuthBloc>().add(const LogoutRequested());
          }
        },
      ),
    );
  }
}
