import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/simple_card.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/app_settings_bar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter_bloc/flutter_bloc.dart';

class WindowsVerificationNoticeScreen extends StatelessWidget {
  const WindowsVerificationNoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsTwoSidesScreen(
      showInProgressIndicator: false,
      topOptionsBar: const BlocAppSettingsBar(),
      leftSide: BuilderWithWidgetInfo(builder: (context, widgetInfo) {
        return Center(
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.verified_user_outlined,
                color: context.colorScheme.errorColor,
                size: 46,
              ),
              const SizedBox(height: 24),
              Text(
                "Email verification required!",
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(flex: 2),
              SimpleCard(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Please check if an email with verification link was sent to "${(context.read<AuthBloc>().state as AuthHasLoggedInUser).currentUser.email}"\n'
                  'Click on "Send new link" to request a new verification link',
                  style: context.textTheme.titleSmall,
                ),
              ),
              CustomElevatedButton(
                label: 'Send new verification link',
                onPressed: () {},
                iconData: Icons.email_outlined,
              ),
              const Spacer(flex: 2),
            ],
          ),
        );
      }),
    );
  }
}
